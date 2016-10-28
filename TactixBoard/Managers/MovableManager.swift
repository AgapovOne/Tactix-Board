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
    private init() {
    }
    var movableZone: CGRect = .zero

    func defaultTactic(for center: CGPoint) -> MovableTactic {
        return MovableTactic(states: [], movableViews: [
            PlayerView(id: 1, color: Color.Player.orange, num: "G", center: CGPoint(x: center.x, y: center.y - 420)),
            PlayerView(id: 2, color:Color.Player.red, num:"1", center: CGPoint(x: center.x + 80, y: center.y - 200)),
            PlayerView(id: 3, color:Color.Player.red, num:"3", center: CGPoint(x: center.x - 80, y: center.y - 200)),
            PlayerView(id: 4, color:Color.Player.red, num:"5", center: CGPoint(x: center.x + 80, y: center.y - 100)),
            PlayerView(id: 5, color:Color.Player.red, num:"7", center: CGPoint(x: center.x - 80, y: center.y - 100)),
            PlayerView(id: 6, color:Color.Player.blue, num:"2", center: CGPoint(x: center.x + 80, y: center.y + 100)),
            PlayerView(id: 7, color:Color.Player.blue, num:"4", center: CGPoint(x: center.x - 80, y: center.y + 100)),
            PlayerView(id: 8, color:Color.Player.blue, num:"6", center: CGPoint(x: center.x + 80, y: center.y + 200)),
            PlayerView(id: 9, color:Color.Player.blue, num:"8", center: CGPoint(x: center.x - 80, y: center.y + 200)),
            PlayerView(id: 10, color:Color.Player.green, num:"G", center: CGPoint(x: center.x, y: center.y + 420)),
            BallView(centerX: center.x, centerY: center.y)
            ])
    }
}
