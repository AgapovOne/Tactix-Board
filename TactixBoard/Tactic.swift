//
//  Tactic.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 12/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import CoreGraphics
import RealmSwift

struct TacticStruct {
    struct State {
        var positions: [Int: CGPoint]
    }

    var states: [State]
    var movableViews: [MovableView]
}

class Tactic: Object {
    dynamic var name = ""

    let states = List<State>()
    let movableObjects = List<MovableObject>()
}
