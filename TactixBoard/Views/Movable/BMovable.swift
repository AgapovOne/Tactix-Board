//
//  BMovable.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 28/09/15.
//  Copyright © 2015 agapov.one.ru. All rights reserved.
//

import UIKit

class BMovable: UIView {
    var id: Int = 0
    private var lastLocation: CGPoint = CGPoint(x: 0, y: 0)

    private var currentPosition: CGPoint = CGPoint.zero {
        didSet {
            self.center = currentPosition
        }
    }

    convenience init(id: Int, frame: CGRect) {
        self.init(frame: frame)
        self.id = id
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(BMovable.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]

        self.layer.shadowOpacity = 0.7
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 7
        self.layer.shadowOffset = CGSize(width: 0, height: 1)

        self.layer.cornerRadius = frame.width / 2

        self.layer.zPosition = 10
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func detectPan(_ recognizer: UIPanGestureRecognizer) {
        let translation  = recognizer.translation(in: self.superview!)
        var x = lastLocation.x + translation.x
        var y = lastLocation.y + translation.y

        let movableZone = MovableManager.shared.movableZone
        if x < movableZone.minX {
            x = movableZone.minX
        } else if x > movableZone.maxX {
            x = movableZone.maxX
        }
        if y < movableZone.minY {
            y = movableZone.minY
        } else if y > movableZone.maxY {
            y = movableZone.maxY
        }

        self.currentPosition = CGPoint(x: x, y: y)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.gestureRecognizers?.isEmpty == false {
            self.superview?.bringSubview(toFront: self)
            lastLocation = self.center
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.gestureRecognizers?.isEmpty == false {
            let frame = self.bounds.insetBy(dx: -15, dy: -15) // enlarge touch area for 15 px around
            return frame.contains(point) ? self : nil
        } else {
            let frame = self.bounds.insetBy(dx: self.bounds.size.width, dy: self.bounds.size.height)
            return frame.contains(point) ? self : nil
        }
    }

    func setBackgroundImage(_ imgName: String) {
        UIGraphicsBeginImageContext(self.frame.size)
        UIImage(named: imgName)?.draw(in: self.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.backgroundColor = UIColor(patternImage: image!)
    }

    func toggleMoves(enabled: Bool) {
        self.gestureRecognizers = enabled == true
            ? [UIPanGestureRecognizer(target:self, action:#selector(BMovable.detectPan(_:)))]
            : []

        self.isUserInteractionEnabled = enabled
    }
}

extension BMovable {
    var realmMovable: RealmMovable {
        get {
            let object = RealmMovable()
            object.color = self.backgroundColor?.hexValue()
            object.id = self.id
            object.type = "default"

            object.center = RealmPercentPoint(self.center)

            return object
        }
    }
}
