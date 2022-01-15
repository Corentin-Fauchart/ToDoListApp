//
//  ShowViewController.swift
//  ToDoListApp
//
//  Created by Corentin Fauchart on 07/12/2021.
//

import UIKit

/*
 Ce Delegate va permettre de lier les checkbox de cette classe avec la classe parente ViewController
 Nous sommes obligé de passer par un delegate pour faire la liaison étant donné que le bouton permettant de revenir à l'écran précédent
 n'a aucun évènement pour transmettre cette information autrement.
 */
protocol ShowViewControllerDelegate : AnyObject {
    func changeValueCheckBox(_ valueToChange: UIButton)
}

class ShowViewController: UIViewController {
    var data: Todo?
    var indiceData: Int!
    
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var dateReal: UIDatePicker!
    weak var delegate: ShowViewControllerDelegate?
    
    /*
     Cette fonction change l'état de notre checkbox quand on clique dessus (activé/désactivé).
     */
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent { //Lorsque l'on retourne à l'écran parent
            delegate?.changeValueCheckBox(checkbox) // On appelle la fonction déninie dans notre protocol
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toDo = data {
            titre.text = toDo.getNom()
            desc.text = toDo.getDescription()
            checkbox.isSelected = toDo.getEtatTache()
            dateReal.date =  toDo.getDateReal()
        }else{
            titre.text = "ERROR"
            desc.text = "ERROR"
            checkbox.isSelected = false
            dateReal.date = Date()
        }
        
        checkbox.tag = indiceData
        
        
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
