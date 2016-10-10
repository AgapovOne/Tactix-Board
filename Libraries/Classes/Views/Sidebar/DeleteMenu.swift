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
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "DeleteMenu", bundle: bundle)
    
    // Assumes UIView is top level and only object in AddMenu.xib file
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    return view
  }
  
  func removePlayerWithColor(_ color:UIColor) {
    guard let sup = self.superview else {return}
    for v in sup.subviews {
      if v.isKind(of: PlayerView.self) {
        if v.backgroundColor == color {
          v.removeFromSuperview()
          return
        }
      }
    }
  }
  
  func removeTeamWithColor(_ color:UIColor) {
    guard let sup = self.superview else {return}
    for v in sup.subviews {
      if v.isKind(of: PlayerView.self) {
        if v.backgroundColor == color {
          v.removeFromSuperview()
        }
      }
    }
  }
  
  @IBAction func deleteRedPlayer(_ sender: UIButton) {
    removePlayerWithColor(red)
  }
  
  @IBAction func deleteBluePlayer(_ sender: UIButton) {
    removePlayerWithColor(blue)
  }
  
  @IBAction func deleteBlackPlayer(_ sender: UIButton) {
    removePlayerWithColor(black)
  }
  
  @IBAction func deleteTeam(_ sender: UIButton) {
    removeTeamWithColor(blue)
  }
  
  @IBAction func deleteOrangeGK(_ sender: UIButton) {
    removePlayerWithColor(orange)
  }
  
  @IBAction func deleteGreenGK(_ sender: UIButton) {
    removePlayerWithColor(green)
  }
}

