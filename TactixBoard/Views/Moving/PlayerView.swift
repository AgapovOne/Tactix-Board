//
//  PlayerView.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 11/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class PlayerView: MovableView {
    private static let size: CGSize = CGSize(width: 44, height: 44)

    convenience init(color: UIColor, num: String?, center: CGPoint) {
        self.init(frame: CGRect(x: center.x - PlayerView.size.width / 2, y: center.y - PlayerView.size.height / 2, width: PlayerView.size.width, height: PlayerView.size.height))

        self.layer.borderColor = Color.white.cgColor
        self.layer.borderWidth = 2.0


        self.backgroundColor = color

        let number = UILabel(frame:CGRect(x: 0,y: 0,width: PlayerView.size.width, height: PlayerView.size.height))
        number.text = num
        number.font = numberFont
        number.textAlignment = .center
        number.center = CGPoint(x: PlayerView.size.width / 2, y: PlayerView.size.height / 2)
        number.textColor = Color.white

        self.addSubview(number)
    }

    convenience init() {
        self.init(color: Color.black, num: nil, center: CGPoint(x: 400, y: 400))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
