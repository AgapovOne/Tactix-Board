//
//  RealmTactic.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 12/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import Foundation
import CoreGraphics
import RealmSwift

class RealmTactic: Object {
    dynamic var name = ""

    let states = List<RealmState>()
    let movableObjects = List<RealmMovable>()

    convenience init(name: String, states: [RealmState], movableObjects: [RealmMovable]) {
        self.init()
        self.name = name
        self.states.append(objectsIn: states)
        self.movableObjects.append(objectsIn: movableObjects)
    }

    convenience init(name: String, tactic: MovableTactic) {
        self.init()
        self.name = name

        var movableObjects: [RealmMovable] = []
        for view in tactic.movableViews {
            if let player = view as? PlayerView {
                movableObjects.append(player.realmMovable)
            } else if let ball = view as? BallView {
                movableObjects.append(ball.realmMovable)
            }
        }
        self.movableObjects.append(objectsIn: movableObjects)

        let states = tactic.states.map {
            RealmState(state: $0)
        }
        self.states.append(objectsIn: states)
    }

    convenience init(tactic: MovableTactic, name: String) {
        let states = tactic.states.map { RealmState(state: $0) }
        let movableObjects: [RealmMovable] = tactic.movableViews.map {
            if let view = $0 as? PlayerView {
                return view.realmMovable
            }
            if let view = $0 as? BallView {
                return view.realmMovable
            }
            return $0.realmMovable
        }
        self.init(name: name, states: states, movableObjects: movableObjects)
    }
}
