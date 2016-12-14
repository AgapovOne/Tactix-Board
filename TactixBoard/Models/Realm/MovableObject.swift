//
//  MovableObject.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 13/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import RealmSwift

class MovableObject: Object {
    dynamic var id: Int = 1
    dynamic var type = ""
    
    dynamic var number: String? = ""
    dynamic var color: String? = ""
    dynamic var image: String? = ""

    // Initial center
    dynamic var centerX: Double = 0.0
    dynamic var centerY: Double = 0.0
}
