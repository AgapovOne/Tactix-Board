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
