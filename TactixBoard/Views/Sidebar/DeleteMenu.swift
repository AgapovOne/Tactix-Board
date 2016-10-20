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
    return super.loadView(withName: "DeleteMenu")
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
    removePlayerWithColor(Color.red)
  }
  
  @IBAction func deleteBluePlayer(_ sender: UIButton) {
    removePlayerWithColor(Color.blue)
  }
  
  @IBAction func deleteBlackPlayer(_ sender: UIButton) {
    removePlayerWithColor(Color.black)
  }
  
  @IBAction func deleteTeam(_ sender: UIButton) {
    removeTeamWithColor(Color.blue)
  }
  
  @IBAction func deleteOrangeGK(_ sender: UIButton) {
    removePlayerWithColor(Color.orange)
  }
  
  @IBAction func deleteGreenGK(_ sender: UIButton) {
    removePlayerWithColor(Color.green)
  }
}

