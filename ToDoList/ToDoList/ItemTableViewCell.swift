//
//  ItemTableViewCell.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/28/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

//
//protocol ItemTableViewCellDelegate: class {
//    func switchStatus(forItem item: Item, cell: ItemTableViewCell, sender: UIButton)
//}

class ItemTableViewCell: UITableViewCell {
    
    //var item: Item?
    var onClick: ( (ItemTableViewCell) -> () )?
    
    //func functionName(name: ItemTableViewCell) -> ()
    // MARK: Properties
    @IBOutlet weak var itemCheckboxImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        onClick?(self)
//        checkboxButtonTapped()
//        
//        guard let selectedItem = item else { print("item not item"); return }
//        
//        print("item is complete: \(selectedItem.isCompleted)")
//        delegate?.switchStatus(forItem: selectedItem, cell: self, sender: sender)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func checkboxButtonTapped() {
//        if itemCheckboxImage.image == UIImage(named:"not-checked") {
//            itemCheckboxImage.image = UIImage(named: "checked")
//            itemNameLabel.textColor = UIColor.gray
//            //print(" Task complete // item.setStatus(to: .complete)")
//            
//        } else {
//            itemCheckboxImage.image = UIImage(named: "not-checked")
//            itemNameLabel.textColor = UIColor.black
//            //print("Task not complete // item.setStatus(to: .new)")
//        }
//        
//    }

}
