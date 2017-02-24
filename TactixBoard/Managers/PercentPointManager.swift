//
//  PercentPointManager.swift
//  TactixBoard
//
//  Created by Alex Agapov on 22/02/2017.
//  Copyright © 2017 agapov.one.ru. All rights reserved.
//

import UIKit
import CoreGraphics

class PercentPointManager {
    static let shared = PercentPointManager()
    private init() {
        let size = UIScreen.main.bounds.size
        boardSize = size
        maximumX = size.width
        maximumY = size.height
    }

    var boardSize: CGSize {
        didSet {
            self.maximumX = boardSize.width
            self.maximumY = boardSize.height
        }
    }

    var maximumX: CGFloat
    var maximumY: CGFloat
}
