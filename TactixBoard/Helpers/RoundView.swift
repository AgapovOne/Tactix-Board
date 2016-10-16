//
//  RoundView.swift
//  TactixBoard
//
//  Created by Alex Agapov on 16/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {
    @IBInspectable var cornerRadius: Int = 0 {
        didSet {
            self.layer.cornerRadius = CGFloat(cornerRadius)
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
}
