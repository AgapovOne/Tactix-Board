//
//  PlayerView.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 11/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class PlayerView: MovableView {
    fileprivate static let size: CGSize = CGSize(width: 44, height: 44)

    var num: String?

    convenience init(id: Int,
                     color: UIColor,
                     num: String?,
                     center: CGPoint) {
        self.init(frame: CGRect(x: center.x - PlayerView.size.width / 2,
                                y: center.y - PlayerView.size.height / 2,
                                width: PlayerView.size.width,
                                height: PlayerView.size.height))
        self.id = id

        self.layer.borderColor = Color.white.cgColor
        self.layer.borderWidth = 2.0

        self.backgroundColor = color

        let number = UILabel(frame:CGRect(x: 0, y: 0, width: PlayerView.size.width, height: PlayerView.size.height))
        number.text = num
        number.font = Fonts.numberFont
        number.textAlignment = .center
        number.center = CGPoint(x: PlayerView.size.width / 2, y: PlayerView.size.height / 2)
        number.textColor = Color.white
        self.num = num

        self.addSubview(number)
    }

    convenience init(movableObject: MovableObject) {
        self.init(id: movableObject.id,
                  color: UIColor(hexString: movableObject.color!)!,
                  num: movableObject.number,
                  center: CGPoint(x: movableObject.centerX, y: movableObject.centerY))
    }

    convenience init() {
        self.init(id: 0, color: Color.Player.black, num: nil, center: CGPoint(x: 400, y: 400))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public methods
    override func toMovableObject() -> MovableObject {
        let object = MovableObject()
        object.color = self.backgroundColor?.hexValue()
        object.id = self.id
        object.type = "player"
        object.number = self.num

        object.centerX = Double(self.center.x)
        object.centerY = Double(self.center.y)

        return object
    }
}
