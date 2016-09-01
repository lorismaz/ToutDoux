//
//  Item.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/30/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

class Item {
    var title: String
    var description: String?
    var isCompleted: Bool = false
    //let itemPriority: Priority
    
    init(title providedTitle: String, description providedDescription: String?) {
        title = providedTitle
        description = providedDescription
    }
    
}
