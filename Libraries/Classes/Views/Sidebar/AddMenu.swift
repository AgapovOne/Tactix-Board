//
//  AddMenu.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 12/10/15.
//  Copyright © 2015 agapov.one.ru. All rights reserved.
//

import UIKit

@IBDesignable class AddMenu: UIView {
  
  // Our custom view from the XIB file
  var view: UIView!
  
  override init(frame: CGRect) {
    // 1. setup any properties here
    
    // 2. call super.init(frame:)
    super.init(frame: frame)
    
    // 3. Setup view from .xib file
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    // 1. setup any properties here
    
    // 2. call super.init(coder:)
    super.init(coder: aDecoder)
    
    // 3. Setup view from .xib file
    xibSetup()
  }
  
  func xibSetup() {
    view = loadViewFromNib()
    
    // use bounds not frame or it'll be offset
    view.frame = bounds
    
    // Make the view stretch with containing view
    view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
    
    // Adding custom subview on top of our view (over any custom drawing > see note below)
    addSubview(view)
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: "AddMenu", bundle: bundle)
    
    // Assumes UIView is top level and only object in AddMenu.xib file
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    return view
  }
  
  @IBAction func addRedPlayer(sender: UIButton) {
    
  }
  
  @IBAction func addBluePlayer(sender: UIButton) {
    
  }
  
  @IBAction func addBlackPlayer(sender: UIButton) {
    
  }
  
  @IBAction func addOrangeGK(sender: UIButton) {
    
  }
  
  @IBAction func addGreenGK(sender: UIButton) {
    
  }
}
