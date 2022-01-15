//
//  descToDo.swift
//  ToDoListApp
//
//  Created by Corentin Fauchart on 17/12/2021.
//

import UIKit

class descToDo: UITextView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func viewDidLoad() {
      super.viewDidLoad()
      var borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
      taskNotes.layer.borderWidth = 0.5
      taskNotes.layer.borderColor = borderColor.CGColor
      taskNotes.layer.cornerRadius = 5.0
    }

}
