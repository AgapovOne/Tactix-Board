//
//  RealmPosition.swift
//  TactixBoard
//
//  Created by Alex Agapov on 23/02/2017.
//  Copyright © 2017 agapov.one.ru. All rights reserved.
//

import RealmSwift

class RealmPosition: Object {
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
