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
//        state.
        return state
    }
}

struct MovableTactic {
    var states: [MovableState]
    var movableViews: [MovableView]
}
