//
//  LineTypeMenu.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 13/10/15.
//  Copyright © 2015 agapov.one.ru. All rights reserved.
//

import UIKit

@IBDesignable class LineTypeMenu: MenuType {
  
  //var mainPic:UIImage = UIImage(named: "ThinLine.png")!
  
  override func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: "LineType", bundle: bundle)
    
    // Assumes UIView is top level and only object in AddMenu.xib file
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    return view
  }
  
  func setLineType(type: LineType) {
    DrawingView().setLineType(type)
  }
  
  @IBAction func setThinLine(sender: UIButton) {
    setLineType(.Thin)
  }
  
  @IBAction func setThickLine(sender: UIButton) {
    setLineType(.Thick)
  }
  
  @IBAction func setDashedLine(sender: UIButton) {
    setLineType(.Dashed)
  }
}