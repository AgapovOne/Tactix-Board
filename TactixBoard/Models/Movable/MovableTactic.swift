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
                                  color: Color.color(hex: $0.color ?? Color.Player.black.hexValue())!,
                                  num: $0.number,
                                  center: CGPoint($0.center!))
            case "ball":
                return BallView(center: CGPoint($0.center!))
            default:
                return PlayerView(id: $0.id,
                                  color: Color.Player.black,
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
            BallView(center: center)
            ])
    }
}
