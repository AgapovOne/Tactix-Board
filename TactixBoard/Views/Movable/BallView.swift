//
//  BallView.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 11/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class BallView: BMovable {
    convenience init(center: CGPoint) {
        self.init(frame: CGRect(x: center.x - 18, y: center.y - 18, width: 36.0, height: 36.0))
        self.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "ball"))
        self.layer.zPosition = 11
    }
}

extension BallView {
    override var realmMovable: RealmMovable {
        get {
            let object = RealmMovable()
            object.color = self.backgroundColor?.hexValue()
            object.id = self.id
            object.type = "ball"

            object.center = RealmPercentPoint(self.center)

            return object
        }
    }
}
