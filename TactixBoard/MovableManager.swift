//
//  MovableManager.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 11/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class MovableManager {
    static let shared = MovableManager()

    var movableZone: CGRect = .zero

    func defaultTactic(for center: CGPoint) -> Tactic {
        return Tactic(states: [], movableViews: [
            PlayerView(color: Color.orange, num: "G", center: CGPoint(x: center.x, y: center.y - 420)),
            PlayerView(color:Color.red, num:"1", center: CGPoint(x: center.x + 80, y: center.y - 200)),
            PlayerView(color:Color.red, num:"3", center: CGPoint(x: center.x - 80, y: center.y - 200)),
            PlayerView(color:Color.red, num:"5", center: CGPoint(x: center.x + 80, y: center.y - 100)),
            PlayerView(color:Color.red, num:"7", center: CGPoint(x: center.x - 80, y: center.y - 100)),
            PlayerView(color:Color.blue, num:"2", center: CGPoint(x: center.x + 80, y: center.y + 100)),
            PlayerView(color:Color.blue, num:"4", center: CGPoint(x: center.x - 80, y: center.y + 100)),
            PlayerView(color:Color.blue, num:"6", center: CGPoint(x: center.x + 80, y: center.y + 200)),
            PlayerView(color:Color.blue, num:"8", center: CGPoint(x: center.x - 80, y: center.y + 200)),
            PlayerView(color:Color.green, num:"G", center: CGPoint(x: center.x, y: center.y + 420)),
            BallView(x: center.x, y: center.y)
            ])
    }

}
