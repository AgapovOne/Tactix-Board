//
//  State.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 13/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import RealmSwift

class RealmState: Object {
    dynamic var frame: Int = 0
    let positions = List<RealmPosition>()

    convenience init(frame: Int, positions: [RealmPosition]) {
        self.init()
        self.frame = frame
        self.positions.append(objectsIn: positions)
    }

    convenience init(state: MovableState) {
        let frame = state.frame
        let positions = state.positions.map {
            RealmPosition(id: $0.key.id, center: $0.value)
        }

        self.init(frame: frame, positions: positions)
    }
}
