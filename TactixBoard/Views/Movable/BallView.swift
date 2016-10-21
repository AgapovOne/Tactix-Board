//
//  BallView.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 11/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class BallView: MovableView {
    convenience init(x: CGFloat, y: CGFloat) {
        self.init(frame: CGRect(x: x - 18,y: y - 18,width: 36.0,height: 36.0))
        self.backgroundColor = UIColor(patternImage: UIImage(named: "ball.png")!)
        self.layer.zPosition = 11
    }

    // MARK: Public methods
    func toMovableObject() -> MovableObject {
        let object = MovableObject()
        object.color = self.backgroundColor?.hexValue()
        object.id = self.id
        object.type = "ball"

        object.centerX = Double(self.center.x)
        object.centerY = Double(self.center.y)

        return object
    }
}
