//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Corentin Fauchart on 07/12/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, ShowViewControllerDelegate {
    
    var valueSentFromShowViewController: UIButton?
    var cellDeleted: Bool?
    var toDo = [Todo]()
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func validateToDo(_ sender: UIButton) {
        toDo.remove(at: sender.tag)
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellContent", for: indexPath) as! TableViewCell
        
        cell.titre.text = toDo[indexPath.row].getNom()
        cell.bouton.tag = indexPath.row
        cell.checkBoxValidate.tag = indexPath.row
        
        cell.checkBoxValidate.isSelected = toDo[indexPath.row].getEtatTache()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Find the row of the cell
            let row = indexPath.row
            toDo.remove(at: row)
            tableview.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HELLO DEAR")
        if let vc = segue.destination as? ShowViewController {
            vc.delegate = self
            let row = tableview.indexPathForSelectedRow!.row
            vc.data = toDo[row]
            vc.indiceData = row
            cellDeleted = false
        }
        
    }
    
    @IBAction func backToMainView(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "ajouterTache" {
            let ajouterViewController = unwindSegue.source as! CreationViewController
            let titre = ajouterViewController.titleToAdd.text!
            let desc = ajouterViewController.descToAdd.text!
            toDo.append(Todo(nom: titre, description: desc))
            tableview.reloadData()
        }
        if unwindSegue.identifier == "supprimerTache" {
            let showViewController = unwindSegue.source as! ShowViewController
            print("OUIIIII")
            toDo.remove(at: showViewController.indiceData!)
            cellDeleted = true
            tableview.reloadData()
        }
        
        
        // Use data from the view controller which initiated the unwind segue
    }
    
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            toDo[sender.tag].setEtatTache(etat: false)
            tableview.reloadData()
        } else {
            sender.isSelected = true
            toDo[sender.tag].setEtatTache(etat: true)
            tableview.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let valueToDisplay = valueSentFromShowViewController{
            print("Value from display = \(valueToDisplay)")
            toDo[valueToDisplay.tag].setEtatTache(etat: valueToDisplay.isSelected)
            tableview.reloadData()
        }
    }
    
    func changeValueCheckBox(_ valueToChange: UIButton) {
        if !cellDeleted!{
            self.valueSentFromShowViewController = valueToChange
        }
    }
    
}

