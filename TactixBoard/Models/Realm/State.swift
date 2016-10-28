//
//  State.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 13/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import RealmSwift

class State: Object {
    dynamic var frame: Int = 0
    let positions = List<Position>()

    convenience init(frame: Int, positions: [Position]) {
        self.init()
        self.frame = frame
        self.positions.append(objectsIn: positions)
    }
}

class Position: Object {
    dynamic var id: Int = 0
    dynamic var centerX: Double = 0.0
    dynamic var centerY: Double = 0.0

    convenience init(id: Int, center: CGPoint) {
        self.init()
        self.id = id
        self.centerX = Double(center.x)
        self.centerY = Double(center.y)
    }
}
