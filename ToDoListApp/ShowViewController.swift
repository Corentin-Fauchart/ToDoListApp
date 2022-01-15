//
//  ShowViewController.swift
//  ToDoListApp
//
//  Created by Corentin Fauchart on 07/12/2021.
//

import UIKit

protocol ShowViewControllerDelegate : AnyObject {
    func changeValueCheckBox(_ valueToChange: UIButton)
}

class ShowViewController: UIViewController {
    var data: Todo?
    var indiceData: Int?
    
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var dateReal: UIDatePicker!
    weak var delegate: ShowViewControllerDelegate?
    
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        print("mon gars")
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            print("On retourne chez papa")
            delegate?.changeValueCheckBox(checkbox)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let toDo = data {
            titre.text = toDo.getNom()
            desc.text = toDo.getDescription()
            checkbox.isSelected = toDo.getEtatTache()
            dateReal.date = toDo.getDateReal()
        }else{
            titre.text = "ERROR"
            desc.text = "ERROR"
            checkbox.isSelected = false
            dateReal.date = Date()
        }
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
