//
//  Colors.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 11/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit
import ChameleonFramework

struct Color {
    static let mainBgColor = colorWith(r: 38, g: 58, b: 71)

    static let black = colorWith(r: 75, g: 80, b: 85)

    struct Button {
        static let buttonColor = color(hex: "#0C6B92")
        
        static let buttonActiveColor = color(hex: "#00ADEF")
    }
    
    struct Sidebar {
        static let backgroundColor = colorWith(r: 25, g: 41, b: 52)
        
        static let buttonColor = backgroundColor
        
        static let buttonActiveColor = color(hex: "#73B938")
    }
    
    struct Alert {
        static let textFieldColor = color(hex: "#263A47")
    }

    static let lightBlue = colorWith(r: 51, g: 189, b: 242)

    static let red = colorWith(r: 205, g: 54, b: 54)

    static let blue = colorWith(r: 0, g: 173, b: 239)

    static let orange = colorWith(r: 238, g: 178, b: 50)

    static let green = colorWith(r: 80, g: 168, b: 6)
    
    static let white = colorWith(r: 247, g: 243, b: 235)
}

fileprivate func color(hex: String) -> UIColor {
    return UIColor(hexString: hex)
}

private func colorWith(r red: CGFloat, g green: CGFloat, b blue: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}

func randomColor() -> UIColor {
    //randomize view color
    let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
    let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
    let redValue = CGFloat(Int(arc4random() % 255)) / 255.0

    return UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
}
