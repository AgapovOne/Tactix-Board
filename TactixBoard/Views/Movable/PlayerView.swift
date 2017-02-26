//
//  PlayerView.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 11/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class PlayerView: BMovable {
    enum PlayerColor {
        case
        red,
        blue,
        black,
        orange,
        green

        var uiColor: UIColor {
            switch self {
            case .red:
                return Color.Player.red
            case .blue:
                return Color.Player.blue
            case .black:
                return Color.Player.black
            case .orange:
                return Color.Player.orange
            case .green:
                return Color.Player.green
            }
        }

        var hexValue: String {
            return uiColor.hexValue()
        }

        static func color(for hexValue: String) -> PlayerColor {
            var color: PlayerColor = PlayerColor.black
            switch hexValue {
            case Color.Player.red.hexValue():
                color = PlayerColor.red
            case Color.Player.blue.hexValue():
                color = PlayerColor.blue
            case Color.Player.black.hexValue():
                color = PlayerColor.black
            case Color.Player.orange.hexValue():
                color = PlayerColor.orange
            case Color.Player.green.hexValue():
                color = PlayerColor.green
            default:
                break
            }
            return color
        }
    }

    fileprivate static let size: CGSize = CGSize(width: 44, height: 44)

    var num: String?
    var color: PlayerColor! {
        didSet {
            self.backgroundColor = color.uiColor
        }
    }

    convenience init(id: Int,
                     color: PlayerColor,
                     num: String?,
                     center: CGPoint) {
        self.init(frame: CGRect(x: center.x - PlayerView.size.width / 2,
                                y: center.y - PlayerView.size.height / 2,
                                width: PlayerView.size.width,
                                height: PlayerView.size.height))
        self.id = id
        self.color = color
        self.backgroundColor = color.uiColor

        self.layer.borderColor = Color.white.cgColor
        self.layer.borderWidth = 2.0

        let number = UILabel(frame:CGRect(x: 0, y: 0, width: PlayerView.size.width, height: PlayerView.size.height))
        number.text = num
        number.font = Fonts.numberFont
        number.textAlignment = .center
        number.center = CGPoint(x: PlayerView.size.width / 2, y: PlayerView.size.height / 2)
        number.textColor = Color.white
        self.num = num

        self.addSubview(number)
    }

    convenience init(movableObject: RealmMovable) {
        self.init(id: movableObject.id,
                  color: .color(for: movableObject.color!),
                  num: movableObject.number,
                  center: CGPoint(movableObject.center!))
    }

    convenience init() {
        self.init(id: 0, color: .black, num: nil, center: CGPoint(x: PercentPointManager.shared.maximumX / 2, y: PercentPointManager.shared.maximumY / 2))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlayerView {
    override var realmMovable: RealmMovable {
        let object = RealmMovable()
        object.color = self.backgroundColor?.hexValue()
        object.id = self.id
        object.type = "player"
        object.number = self.num

        object.center = RealmPercentPoint(self.center)

        return object
    }
}
