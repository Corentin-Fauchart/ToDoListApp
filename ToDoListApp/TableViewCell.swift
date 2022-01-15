//
//  TableViewCell.swift
//  ToDoListApp
//
//  Created by Corentin Fauchart on 07/12/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var bouton: UIButton!
    @IBOutlet weak var checkBoxValidate: UIButton!
    @IBOutlet weak var titre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
