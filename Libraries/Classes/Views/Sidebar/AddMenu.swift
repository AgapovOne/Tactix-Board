//
//  AddMenu.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 12/10/15.
//  Copyright © 2015 agapov.one.ru. All rights reserved.
//

import UIKit

@IBDesignable class AddMenu: MenuType {
  
  override func loadViewFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "AddMenu", bundle: bundle)
    
    // Assumes UIView is top level and only object in AddMenu.xib file
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
  }
  
  func addPlayerWithColor(_ color:PlayerColor, num:String) {
    guard let sup = self.superview else {return}
    for v in sup.subviews {
      if v.tag == 10 {
        let pl = PlayerView(color: color, num: num, x: 400, y: 500)
        v.superview?.addSubview(pl)
        pl.layer.zPosition = 2
      }
    }
  }
  
  @IBAction func addRedPlayer(_ sender: UIButton) {
    addPlayerWithColor(.red, num: "3")
  }
  
  @IBAction func addBluePlayer(_ sender: UIButton) {
    addPlayerWithColor(.blue, num: "2")
  }
  
  @IBAction func addBlackPlayer(_ sender: UIButton) {
    addPlayerWithColor(.black, num: "2")
  }
  
  @IBAction func addOrangeGK(_ sender: UIButton) {
    addPlayerWithColor(.orange, num: "В")
    
  }
  
  @IBAction func addGreenGK(_ sender: UIButton) {
    addPlayerWithColor(.green, num: "В")
  }
}
