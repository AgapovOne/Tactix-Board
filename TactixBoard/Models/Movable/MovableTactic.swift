//
//  MovableTactic.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 21/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

struct MovableState {
    var frame: Int
    var positions: [MovableView: CGPoint]

    func toState() -> State {
        let state = State()
        state.frame = self.frame
        let positions = self.positions.map {
            Position(id: $0.key.id, center: $0.value)
        }
        state.positions.append(objectsIn: positions)
        return state
    }
}

struct MovableTactic {
    var states: [MovableState]
    var movableViews: [MovableView]

    func toTactic(name: String) -> Tactic {
        let states = self.states.map { $0.toState() }
        let movableObjects: [MovableObject] = self.movableViews.map {
            if let view = $0 as? PlayerView {
                return view.toMovableObject()
            }
            if let view = $0 as? BallView {
                return view.toMovableObject()
            }
            return $0.toMovableObject()
        }
        return Tactic(name: name, states: states, movableObjects: movableObjects)
    }
}

// MARK: Defaults
extension MovableTactic {
    static func defaultTactic(for center: CGPoint) -> MovableTactic {
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
