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
    //introducing the Statusji™
    var statusji: String = ""
    
    init(title providedTitle: String, description providedDescription: String?) {
        title = providedTitle
        description = providedDescription
        statusji = randomStatusji()
    }
    
    func randomStatusji() -> String {
        let statusEmojis = ["🤘🏼","👍🏼","🙌🏼","✌🏼","👌🏼","😎","💁🏽","🍾","🏅","🦄"]
        let randomIndex = Int(arc4random_uniform(UInt32(statusEmojis.count)))
        
        return statusEmojis[randomIndex]
    }
}
