//
//  Extensions.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 08/09/15.
//  Copyright (c) 2015 agapov.one.ru. All rights reserved.
//

import Foundation
import UIKit

func randomColor() -> UIColor {
  //randomize view color
  let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
  let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
  let redValue = CGFloat(Int(arc4random() % 255)) / 255.0
  
  return UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
}