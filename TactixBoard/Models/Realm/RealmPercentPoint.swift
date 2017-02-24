//
//  RealmPercentPoint.swift
//  TactixBoard
//
//  Created by Alex Agapov on 23/02/2017.
//  Copyright © 2017 agapov.one.ru. All rights reserved.
//

import RealmSwift

class RealmPercentPoint: Object {
    dynamic var x: Float = 0.0
    dynamic var y: Float = 0.0

    convenience init(_ point: CGPoint) {
        self.init()
        self.x = Float(point.x) / Float(PercentPointManager.shared.maximumX) * 100.0
        self.y = Float(point.y) / Float(PercentPointManager.shared.maximumY) * 100.0
    }
}

extension CGPoint {
    init(_ point: RealmPercentPoint) {
        let x = CGFloat(point.x * Float(PercentPointManager.shared.maximumX)) / 100.0
        let y = CGFloat(point.y * Float(PercentPointManager.shared.maximumY)) / 100.0

        self.init(x: x, y: y)
    }
}
