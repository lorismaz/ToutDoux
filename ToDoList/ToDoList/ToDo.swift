//
//  List.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/28/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

//MARK: Functions
// Random Pastel Color Generator
// from: https://gist.github.com/JohnCoates/725d6d3c5a07c4756dec
func generateRandomPastelColor(withMixedColor mixColor: UIColor?) -> UIColor {
    // Randomly generate number in closure
    let randomColorGenerator = { ()-> CGFloat in
        CGFloat(arc4random() % 256 ) / 256
    }
    
    var red: CGFloat = randomColorGenerator()
    var green: CGFloat = randomColorGenerator()
    var blue: CGFloat = randomColorGenerator()
    
    // Mix the color
    if let mixColor = mixColor {
        var mixRed: CGFloat = 0, mixGreen: CGFloat = 0, mixBlue: CGFloat = 0;
        mixColor.getRed(&mixRed, green: &mixGreen, blue: &mixBlue, alpha: nil)
        
        red = (red + mixRed) / 2;
        green = (green + mixGreen) / 2;
        blue = (blue + mixBlue) / 2;
    }
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}


enum Status {
    case New
    case Complete
    case WorkingOnIt
}

//MARK: Classes & Structs

class User {
    let userId: String
    var username: String?
    var lists: [ToDoList]?
    
    init(username usernameProvided: String?, lists listProvided: [ToDoList]?) {
        userId = NSUUID().uuidString.lowercased()
        username = usernameProvided
        lists = listProvided
    }
    
    func getLists() -> [ToDoList]? {
        guard let allUserLists = self.lists else {
            return nil
        }
        
        return allUserLists
    }
    
}

class ToDoList {
    var name: String
    var items: [Item]?
    let color: UIColor
    
    init(name providedName: String, items providedItem: [Item]?) {
        name = providedName
        items = providedItem
        color = generateRandomPastelColor(withMixedColor: nil)
    }
    
    //not sure if this one is needed because it's the same thing as doing listName.items
    func getItems() -> [Item]? {
        guard let allExistingItems = self.items else {
            return nil
        }
        
        return allExistingItems
    }
    
    func getItemsFilteredBy(status filter: Status ) -> [Item]? {
        guard let allExistingItems = self.items else {
            return nil
        }
        
        var filteredItems: [Item]?
        
        for item in allExistingItems {
            
            if item.status == filter {
                
                if filteredItems != nil {
                    
                    filteredItems?.append(item)
                    
                } else {
                    
                    filteredItems = [item]
                    
                }
                
            }
            
        }
        
        return filteredItems
        
    }
    
    func addTo(user currentUser: User) {
        
        if currentUser.lists != nil {
            currentUser.lists?.append(self)
        } else {
            currentUser.lists = [self]
        }
    }
    
}

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
    
    func addTo(list existingList: ToDoList) {
        
        if existingList.items != nil {
            existingList.items?.append(self)
        } else {
            existingList.items = [self]
        }
    }
    
    func updateDescription(with content: String) {
        self.description = content
    }
    
    func updateTitle(with content: String) {
        self.title = content
    }
}
