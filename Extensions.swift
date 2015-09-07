//
//  Extensions.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 08/09/15.
//  Copyright (c) 2015 agapov.one.ru. All rights reserved.
//

import Foundation
import UIKit

func playerPosition(field:UIImageView, x:CGFloat, y:CGFloat) -> CGRect {
  return CGRectMake((field.frame.width / 2) - 22 + x, ((field.frame.height - 49) / 2) - 22 + y, 44.0, 44.0)
}

func randomColor() -> UIColor {
  //randomize view color
  let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
  let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
  let redValue = CGFloat(Int(arc4random() % 255)) / 255.0
  
  return UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
}