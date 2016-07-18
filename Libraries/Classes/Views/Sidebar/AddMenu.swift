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
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: "AddMenu", bundle: bundle)
    
    // Assumes UIView is top level and only object in AddMenu.xib file
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    return view
  }
  
  func addPlayerWithColor(color:PlayerColor, num:String) {
    guard let sup = self.superview else {return}
    for v in sup.subviews {
      if v.tag == 10 {
        let pl = PlayerView(color: color, num: num, x: 400, y: 500)
        v.superview?.addSubview(pl)
        pl.layer.zPosition = 2
      }
    }
  }
  
  @IBAction func addRedPlayer(sender: UIButton) {
    addPlayerWithColor(.Red, num: "3")
  }
  
  @IBAction func addBluePlayer(sender: UIButton) {
    addPlayerWithColor(.Blue, num: "2")
  }
  
  @IBAction func addBlackPlayer(sender: UIButton) {
    addPlayerWithColor(.Black, num: "2")
  }
  
  @IBAction func addOrangeGK(sender: UIButton) {
    addPlayerWithColor(.Orange, num: "В")
    
  }
  
  @IBAction func addGreenGK(sender: UIButton) {
    addPlayerWithColor(.Green, num: "В")
  }
}
