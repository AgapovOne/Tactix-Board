//
//  LineTypeMenu.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 13/10/15.
//  Copyright © 2015 agapov.one.ru. All rights reserved.
//

import UIKit

@IBDesignable class LineTypeMenu: MenuType {

  override func loadViewFromNib() -> UIView {
     return super.loadView(withName: "LineType")
  }
  
  func setLineType(_ type: LineType) {
    LineView().setLineType(type)
  }
  
  @IBAction func setThinLine(_ sender: UIButton) {
    setLineType(.thin)
  }
  
  @IBAction func setThickLine(_ sender: UIButton) {
    setLineType(.thick)
  }
  
  @IBAction func setDashedLine(_ sender: UIButton) {
    setLineType(.dashed)
  }
}
