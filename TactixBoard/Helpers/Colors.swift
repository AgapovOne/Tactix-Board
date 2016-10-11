//
//  Colors.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 11/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

struct Color {
    static let sidebarColor = colorWith(r: 25, g: 41, b: 52)

    static let mainBgColor = colorWith(r: 38, g: 58, b: 71)

    static let black = colorWith(r: 75, g: 80, b: 85)

    static let bgColor = colorWith(r: 25, g: 41, b: 52)

    static let lightBlue = colorWith(r: 51, g: 189, b: 242)

    static let red = colorWith(r: 205, g: 54, b: 54)

    static let blue = colorWith(r: 0, g: 173, b: 239)

    static let orange = colorWith(r: 238, g: 178, b: 50)

    static let green = colorWith(r: 80, g: 168, b: 6)
    
    static let white = colorWith(r: 247, g: 243, b: 235)
}

private func colorWith(r red: CGFloat, g green: CGFloat, b blue: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
}
