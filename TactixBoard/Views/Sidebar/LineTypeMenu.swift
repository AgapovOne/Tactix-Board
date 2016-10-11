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
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "LineType", bundle: bundle)
    
    // Assumes UIView is top level and only object in AddMenu.xib file
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
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
