//
//  MovableTactic.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 21/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import CoreGraphics

struct MovableTactic {
    var states: [MovableState]
    var movableViews: [BMovable]

    init(states: [MovableState], movableViews: [BMovable]) {
        self.states = states
        self.movableViews = movableViews
    }

    init(_ tactic: RealmTactic) {
        let movableViews: [BMovable] = tactic.movableObjects.map {
            switch $0.type {
            case "player":
                return PlayerView(id: $0.id,
                                  color: .color(for: $0.color!),
                                  num: $0.number,
                                  center: CGPoint($0.center!))
            case "ball":
                return BallView(center: CGPoint($0.center!))
            default:
                return PlayerView(id: $0.id,
                                  color: .black,
                                  num: "?",
                                  center: CGPoint($0.center!))
            }
        }

        let states: [MovableState] = tactic.states.map { state in
            var positions: [BMovable: CGPoint] = [:]
            state.positions.forEach { position in
                if let key = movableViews.first(where: { $0.id == position.id }),
                    let center = position.center {
                    positions[key] = CGPoint(center)
                }
            }
            return MovableState(frame: state.frame, positions: positions)
        }

        self.init(states: states, movableViews: movableViews)
    }
}

// MARK: Defaults
extension MovableTactic {
    static func defaultTactic(for center: CGPoint) -> MovableTactic {
        return MovableTactic(states: [], movableViews: [
            PlayerView(id: 1, color: .orange, num: "G", center: CGPoint(x: center.x, y: center.y - 420)),
            PlayerView(id: 2, color: .red, num:"1", center: CGPoint(x: center.x + 80, y: center.y - 200)),
            PlayerView(id: 3, color: .red, num:"3", center: CGPoint(x: center.x - 80, y: center.y - 200)),
            PlayerView(id: 4, color: .red, num:"5", center: CGPoint(x: center.x + 80, y: center.y - 100)),
            PlayerView(id: 5, color: .red, num:"7", center: CGPoint(x: center.x - 80, y: center.y - 100)),
            PlayerView(id: 6, color: .blue, num:"2", center: CGPoint(x: center.x + 80, y: center.y + 100)),
            PlayerView(id: 7, color: .blue, num:"4", center: CGPoint(x: center.x - 80, y: center.y + 100)),
            PlayerView(id: 8, color: .blue, num:"6", center: CGPoint(x: center.x + 80, y: center.y + 200)),
            PlayerView(id: 9, color: .blue, num:"8", center: CGPoint(x: center.x - 80, y: center.y + 200)),
            PlayerView(id: 10, color: .green, num:"G", center: CGPoint(x: center.x, y: center.y + 420)),
            BallView(center: center)
            ])
    }
}
