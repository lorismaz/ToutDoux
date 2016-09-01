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
    @IBOutlet weak var checkBoxButton: UIButton!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
