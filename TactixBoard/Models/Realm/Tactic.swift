//
//  Tactic.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 12/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

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
}
