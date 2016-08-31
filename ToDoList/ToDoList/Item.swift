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
    var status: Status
    //let itemPriority: Priority
    
    init(title providedTitle: String, description providedDescription: String?) {
        title = providedTitle
        description = providedDescription
        status = .New
    }
    
    func setStatus(to newStatus: Status) {
        self.status = newStatus
    }
    
    func isComplete() -> Bool {
        
        switch status {
        case .Complete:
            return true
        default:
            return false
        }
        
    }
    
    func updateDescription(with content: String) {
        self.description = content
    }
    
    func updateTitle(with content: String) {
        self.title = content
    }
}
