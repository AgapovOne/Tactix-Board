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
    dynamic var center: RealmPercentPoint?

    convenience init(id: Int, center: CGPoint) {
        self.init()
        self.id = id
        self.center = RealmPercentPoint(center)
    }
}
