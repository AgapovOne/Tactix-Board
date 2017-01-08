//
//  Tactic.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 12/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import Foundation
import CoreGraphics
import RealmSwift

class Tactic: Object {
    dynamic var name = ""

    let states = List<State>()
    let movableObjects = List<MovableObject>()

    convenience init(name: String, states: [State], movableObjects: [MovableObject]) {
        self.init()
        self.name = name
        self.states.append(objectsIn: states)
        self.movableObjects.append(objectsIn: movableObjects)
    }

    convenience init(name: String, tactic: MovableTactic) {
        self.init()
        self.name = name

        var movableObjects: [MovableObject] = []
        for view in tactic.movableViews {
            if let player = view as? PlayerView {
                movableObjects.append(player.toMovableObject())
            } else if let ball = view as? BallView {
                movableObjects.append(ball.toMovableObject())
            }
        }
        self.movableObjects.append(objectsIn: movableObjects)

        let states = tactic.states.map {
            $0.toState()
        }
        self.states.append(objectsIn: states)
    }

    func toMovableTactic() -> MovableTactic {
        let movableViews: [MovableView] = self.movableObjects.map {
            switch $0.type {
            case "player":
                return PlayerView(id: $0.id, color: Color.color(hex: $0.color ?? Color.Player.black.hexValue())!, num: $0.number, center: CGPoint(x: $0.centerX, y: $0.centerY))
            case "ball":
                return BallView(centerX: CGFloat($0.centerX), centerY: CGFloat($0.centerY))
            default:
                return PlayerView(id: $0.id, color: Color.Player.black, num: "?", center: CGPoint(x: $0.centerX, y: $0.centerY))
            }
        }

        let states: [MovableState] = self.states.map {
            var positions: [MovableView: CGPoint] = [:]
            for position in Array($0.positions) {
                let key = movableViews.filter { $0.id == position.id }[0]
                positions[key] = CGPoint(x: position.centerX, y: position.centerY)
            }
            return MovableState(frame: $0.frame, positions: positions)
        }

        let tactic = MovableTactic(states: states, movableViews: movableViews)
        return tactic
    }
}
