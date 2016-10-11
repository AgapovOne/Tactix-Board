//
//  PlayerView.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 11/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class PlayerView: MovingView {
    convenience init(x: CGFloat, y: CGFloat) {
        self.init(frame: CGRect(x: x - 22,y: y - 22,width: 44.0,height: 44.0))
    }

    convenience init(color: UIColor, num: String, x: CGFloat, y: CGFloat) {
        self.init(frame: CGRect(x: x - 22,y: y - 22,width: 44.0,height: 44.0))
        self.backgroundColor = color

        self.layer.borderColor = Color.white.cgColor
        self.layer.borderWidth = 2.0

        let number = UILabel(frame:CGRect(x: 0,y: 0,width: 44,height: 44))
        number.text = num
        number.font = numberFont
        number.textAlignment = .center
        number.center = CGPoint(x: 22, y: 22)
        number.textColor = Color.white
        //number.sizeToFit()

        self.addSubview(number)
    }

    func createPlayer(_ color: UIColor, num: String, x: CGFloat, y: CGFloat) -> PlayerView {
        let newPlayer = PlayerView(x: x, y: y)
        newPlayer.backgroundColor = color
        let number = UILabel()
        number.text = num
        number.font = numberFont
        number.center = newPlayer.center
        newPlayer.addSubview(number)
        return newPlayer
    }

    class func initPlayers(_ field: UIView) {
        let playersAtPositions: [PlayerView] = [
            self.createPlayer(field, color:.orange, num:"В", x: 0, y: -420),
            self.createPlayer(field, color:.red, num:"1", x: 80, y: -200),
            self.createPlayer(field, color:.red, num:"3", x: -80, y: -200),
            self.createPlayer(field, color:.red, num:"5", x: 80, y: -100),
            self.createPlayer(field, color:.red, num:"7", x: -80, y: -100),
            self.createPlayer(field, color:.blue, num:"2", x: 80, y: 100),
            self.createPlayer(field, color:.blue, num:"4", x: -80, y: 100),
            self.createPlayer(field, color:.blue, num:"6", x: 80, y: 200),
            self.createPlayer(field, color:.blue, num:"8", x: -80, y: 200),
            self.createPlayer(field, color:.green, num:"В", x: 0, y: 420)]
        for player in playersAtPositions {
            field.superview?.addSubview(player)
        }
    }

    class func fieldCenter(_ field: UIView) -> (x: CGFloat, y: CGFloat) {
        let x = field.frame.width / 2 + 60
        let y = field.frame.height / 2
        return (x,y)
    }

    class func createPlayer(_ field: UIView, color: UIColor, num: String, x: CGFloat, y: CGFloat) -> PlayerView {
        let center = self.fieldCenter(field)
        return PlayerView(color:color, num:num, x: center.x + x, y: center.y + y)
    }
}

/*class Number {
    
    static let sharedInstance = Number()
    
    var numbersArray: [Int] = []
    
    func red() -> String {
        var newNumber = ""
        for number in numbersArray {
            if number % 2 == 0 {
                newNumber = "\(number)"
            }
        }
        return newNumber
    }
}*/
