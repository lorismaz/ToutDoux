//
//  List.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/28/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

class List {
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
    
    func add(item: Item) {
        
        self.items?.append(item)
        
    }
    
    func delete(item: Item) {
        //find current item's index in array
        // then remove
        //self.items?.remove(at: <*index*>)
    }
    
}


