//
//  CreationViewController.swift
//  ToDoListApp
//
//  Created by Corentin Fauchart on 07/12/2021.
//

import UIKit

class CreationViewController: UIViewController {

    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var titleToAdd: UITextField!
    @IBOutlet weak var descToAdd: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        descToAdd.layer.borderWidth = 0.5
        descToAdd.layer.borderColor = borderColor.cgColor
        descToAdd.layer.cornerRadius = 5.0
        
        buttonAdd.layer.borderWidth = 0.7
        buttonAdd.layer.borderColor = UIColor.blue.cgColor
        buttonAdd.layer.cornerRadius = 5.0
        
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
