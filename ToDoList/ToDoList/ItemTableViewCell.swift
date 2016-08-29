//
//  ItemTableViewCell.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/28/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var itemCheckboxImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    // MARK: Actions
    @IBAction func checkboxButton(_ sender: UIButton) {
        checkboxButtonTapped()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func checkboxButtonTapped() {
        if self.itemCheckboxImage.image == UIImage(named:"not-checked") {
            self.itemCheckboxImage.image = UIImage(named: "checked")
            self.itemNameLabel.textColor = UIColor.gray
            print(" Task complete // item.setStatus(to: .Complete)")
            
        } else {
            self.itemCheckboxImage.image = UIImage(named: "not-checked")
            self.itemNameLabel.textColor = UIColor.black
            print("Task not complete // item.setStatus(to: .New)")
        }

    }

}
