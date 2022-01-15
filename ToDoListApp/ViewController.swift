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
    
    let dateFormatter = DateFormatter()
    var currentDate: Date = Date()
    var sectionHeaderTitles = [String]()
    var sectionsToDo = [[Todo]]()
    
    @IBOutlet weak var tableview: UITableView!
    
    func rowAndSectionOfElement(tag: Int) -> [Int] {
        let nbSections = numberOfSections(in: tableview)
        var foundSection = false
        var compteur = 0
        var nbRowAndSection = [Int]()
        for i in 0...nbSections-1{
            compteur += tableView(tableview, numberOfRowsInSection: i)
            if !foundSection && compteur > tag{
                foundSection = true
                nbRowAndSection.append(i)
                nbRowAndSection.append(compteur-tag-1)
            }
        }
        return nbRowAndSection
    }
    
    
    func nbPreviousSectionsElements(currentSection: Int) -> Int {
        var res = 0
        if currentSection > 0 {
            for i in 0...currentSection-1{
                res += tableView(tableview, numberOfRowsInSection: i)
            }
        }
        return res
    }
    
    @IBAction func validateToDo(_ sender: UIButton) {
        let indices = rowAndSectionOfElement(tag: sender.tag)
        sectionsToDo[indices[0]].remove(at: indices[1])
        tableview.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaderTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsToDo[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellContent", for: indexPath) as! TableViewCell
        
        cell.titre.text = sectionsToDo[indexPath.section][indexPath.row].getNom()
        cell.bouton.tag = indexPath.row + nbPreviousSectionsElements(currentSection: indexPath.section)
        cell.checkBoxValidate.tag = indexPath.row + nbPreviousSectionsElements(currentSection: indexPath.section)
        
        cell.checkBoxValidate.isSelected = sectionsToDo[indexPath.section][indexPath.row].getEtatTache()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Find the row of the cell
            let row = indexPath.row
            sectionsToDo[indexPath.section].remove(at: row)
            tableview.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sectionsToDo.removeAll(keepingCapacity: true)
        dateFormatter.locale = Locale(identifier: "FR-fr")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        sectionHeaderTitles.append("Aujourd'hui")
        sectionHeaderTitles.append("Demain")
        sectionHeaderTitles.append("Cette semaine")
        sectionHeaderTitles.append("Plus tard")
        let emptyrow = [Todo]()
        sectionsToDo.append(emptyrow)
        sectionsToDo.append(emptyrow)
        sectionsToDo.append(emptyrow)
        sectionsToDo.append(emptyrow)
        
    
        tableview.dataSource = self
        tableview.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ShowViewController {
            vc.delegate = self
            let row = tableview.indexPathForSelectedRow!.row
            let section = tableview.indexPathForSelectedRow!.section
            
            vc.data = sectionsToDo[section][row]
            vc.indiceData = row
            cellDeleted = false
        }
        
    }
    
    @IBAction func backToMainView(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "ajouterTache" {
            let ajouterViewController = unwindSegue.source as! CreationViewController
            let titre = ajouterViewController.titleToAdd.text!
            let desc = ajouterViewController.descToAdd.text!
            let dateReal = ajouterViewController.dateRealToAdd.date
            let newTodo = Todo(nom: titre, description: desc, date: dateReal)
            
            let dateElement =  newTodo.getDateReal()
            let tomorrow = addOrSubstrateDays(date: currentDate, nb: 1)
            //let twodayslater = addOrSubstrateDays(date: currentDate, nb: 2)
            let weekLater = addOrSubstrateDays(date: currentDate, nb: 7)
            
            if Calendar.current.compare(dateElement, to: currentDate, toGranularity: .day) == .orderedSame{
                sectionsToDo[0].append(newTodo)
            }else if Calendar.current.compare(dateElement, to: tomorrow, toGranularity: .day) == .orderedSame{
                sectionsToDo[1].append(newTodo)
            }else if Calendar.current.compare(dateElement, to: weekLater, toGranularity: .day) == .orderedSame || Calendar.current.compare(dateElement, to: weekLater, toGranularity: .day) == .orderedAscending{
                sectionsToDo[2].append(newTodo)
            }else {
                sectionsToDo[3].append(newTodo)
            }
            
            print(sectionsToDo)
            tableview.reloadData()
        }
        if unwindSegue.identifier == "supprimerTache" {
            let showViewController = unwindSegue.source as! ShowViewController
            let indices = rowAndSectionOfElement(tag: showViewController.checkbox.tag)
            sectionsToDo[indices[0]].remove(at: indices[1])
            cellDeleted = true
            
            tableview.reloadData()
        }
        
        
        // Use data from the view controller which initiated the unwind segue
    }
    
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        let indices = rowAndSectionOfElement(tag: sender.tag)
        if sender.isSelected {
            sender.isSelected = false
            sectionsToDo[indices[0]][indices[1]].setEtatTache(etat: false)
            tableview.reloadData()
        } else {
            sender.isSelected = true
            sectionsToDo[indices[0]][indices[1]].setEtatTache(etat: true)
            tableview.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let valueToDisplay = valueSentFromShowViewController{
            let indices = rowAndSectionOfElement(tag: valueToDisplay.tag)
            sectionsToDo[indices[0]][indices[1]].setEtatTache(etat: valueToDisplay.isSelected)
            tableview.reloadData()
        }
        
    }
    
    func changeValueCheckBox(_ valueToChange: UIButton) {
        if !cellDeleted!{
            self.valueSentFromShowViewController = valueToChange
        }
    }
    
    func addOrSubstrateDays(date: Date, nb: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: nb, to: date)!
    }
    
}

