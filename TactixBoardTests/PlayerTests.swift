//
//  PlayerTests.swift
//  TactixBoard
//
//  Created by Alex Agapov on 10/01/2017.
//  Copyright © 2017 agapov.one.ru. All rights reserved.
//

import XCTest
@testable import TactixBoard

class PlayerTests: XCTestCase {
    var board: UIView?
    
    override func setUp() {
        board = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    }
    
    func testCreation() {
        let player = PlayerView(id: 0, color: Color.Player.red, num: "P", center: board!.center)
        
        XCTAssertNotNil(player)
    }
    
}
