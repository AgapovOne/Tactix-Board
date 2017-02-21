//
//  DrawManager.swift
//  TactixBoard
//
//  Created by Aleksey Agapov on 13/10/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import Foundation

enum LineType {
    case dashed,
    thin,
    thick
}

class DrawManager {
    static let shared = DrawManager()
    private init() {}

    var lineType: LineType = .thin
}
