//
//  Tactic.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 12/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import CoreGraphics

struct Tactic {

    struct State {
        var positions: [CGPoint]
    }
    var states: [State]
    var movableViews: [MovableView]

}
