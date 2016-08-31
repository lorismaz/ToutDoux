//
//  User.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/30/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

class User {
    //let userId: String
    var username: String?
    var lists: [List]?
    
    init(username usernameProvided: String?, lists listProvided: [List]?) {
        //userId = NSUUID().uuidString.lowercased()
        username = usernameProvided
        lists = listProvided
    }
    
    func getLists() -> [List]? {
        guard let allUserLists = self.lists else {
            return nil
        }
        
        return allUserLists
    }
    
    func addList(with list: List) {
        self.lists?.append(list)
    }
    
    func deleteList(with list: List) {
    
    }
    
}
