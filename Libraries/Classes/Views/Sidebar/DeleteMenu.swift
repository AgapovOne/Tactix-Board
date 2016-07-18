//
//  DeleteMenu.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 13/10/15.
//  Copyright © 2015 agapov.one.ru. All rights reserved.
//

import UIKit

@IBDesignable class DeleteMenu: MenuType {
  
  override func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: "DeleteMenu", bundle: bundle)
    
    // Assumes UIView is top level and only object in AddMenu.xib file
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    return view
  }
  
  func removePlayerWithColor(color:UIColor) {
    guard let sup = self.superview else {return}
    for v in sup.subviews {
      if v.isKindOfClass(PlayerView) {
        if v.backgroundColor == color {
          v.removeFromSuperview()
          return
        }
      }
    }
  }
  
  func removeTeamWithColor(color:UIColor) {
    guard let sup = self.superview else {return}
    for v in sup.subviews {
      if v.isKindOfClass(PlayerView) {
        if v.backgroundColor == color {
          v.removeFromSuperview()
        }
      }
    }
  }
  
  @IBAction func deleteRedPlayer(sender: UIButton) {
    removePlayerWithColor(red)
  }
  
  @IBAction func deleteBluePlayer(sender: UIButton) {
    removePlayerWithColor(blue)
  }
  
  @IBAction func deleteBlackPlayer(sender: UIButton) {
    removePlayerWithColor(black)
  }
  
  @IBAction func deleteTeam(sender: UIButton) {
    removeTeamWithColor(blue)
  }
  
  @IBAction func deleteOrangeGK(sender: UIButton) {
    removePlayerWithColor(orange)
  }
  
  @IBAction func deleteGreenGK(sender: UIButton) {
    removePlayerWithColor(green)
  }
}

