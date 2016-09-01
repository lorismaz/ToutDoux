//: Playground - noun: a place where people can play

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
    var lists: [List]?
    
    init(username usernameProvided: String?, lists listProvided: [List]?) {
        userId = NSUUID().uuidString.lowercased()
        username = usernameProvided
        lists = listProvided
    }
    
    func getLists() -> [List]? {
        guard let allUserLists = self.lists else {
            return nil
        }
        
        return allUserLists
    }
    
}

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
    
    func addTo(list existingList: List) {
        
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

//MARK: Tests

let currentUser = User(username: nil, lists: nil)

currentUser.userId
currentUser.getLists()

let list1 = List(name: "Home", items: nil)

print(list1.color)

list1.addTo(user: currentUser)

list1.getItems()

let item1 = Item(title: "Don't forget to eat", description: nil)
let item2 = Item(title: "Do that!", description: "Do that or you will be late")

item1.updateDescription(with: "Hello")

item1.description
item1.title
item1.status
item1.isComplete()

item1.addTo(list: list1)

item2.addTo(list: list1)

item1.isComplete()
item1.setStatus(to: .Complete)
item1.isComplete()


list1.getItemsFilteredBy(status: .New)

list1.getItems()
//or
list1.items





