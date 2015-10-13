//
//  Buttons.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 07/09/15.
//  Copyright (c) 2015 agapov.one.ru. All rights reserved.
//

import Foundation
import UIKit

class BorderButton:UIButton {
  
  let borderWidth:CGFloat = 2
  let borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.4).CGColor // CGColor!
  let cornerRadius:CGFloat = 44
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.layer.cornerRadius = self.cornerRadius
    self.layer.borderColor = self.borderColor
    self.layer.borderWidth = self.borderWidth
  }
  
}