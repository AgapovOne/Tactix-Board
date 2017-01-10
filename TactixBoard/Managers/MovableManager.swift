//
//  MovableManager.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 11/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import UIKit

class MovableManager {
    static let shared = MovableManager()
    private init() {
    }
    var movableZone: CGRect = .zero

}
