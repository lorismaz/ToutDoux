//
//  Common.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/30/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

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

// Item Status
enum Status {
    case new
    case complete
}
