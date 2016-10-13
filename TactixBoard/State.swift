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
}

class Position: Object {
    dynamic var id: Int = 0
    dynamic var centerX: Double = 0.0
    dynamic var centerY: Double = 0.0
}
