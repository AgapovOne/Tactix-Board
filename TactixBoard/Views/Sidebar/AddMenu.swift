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
    return super.loadView(withName: "AddMenu")
  }
  
  func addPlayerWithColor(_ color: UIColor, num: String) {
    guard let sup = self.superview else {return}
    for v in sup.subviews {
      if v.tag == 10 {
        let pl = PlayerView(id: 0, color: color, num: num, center: CGPoint(x: 400, y: 500))
        v.superview?.addSubview(pl)
      }
    }
  }
  
  @IBAction func addRedPlayer(_ sender: UIButton) {
    addPlayerWithColor(Color.red, num: "3")
  }
  
  @IBAction func addBluePlayer(_ sender: UIButton) {
    addPlayerWithColor(Color.blue, num: "2")
  }
  
  @IBAction func addBlackPlayer(_ sender: UIButton) {
    addPlayerWithColor(Color.black, num: "2")
  }
  
  @IBAction func addOrangeGK(_ sender: UIButton) {
    addPlayerWithColor(Color.orange, num: "В")
    
  }
  
  @IBAction func addGreenGK(_ sender: UIButton) {
    addPlayerWithColor(Color.green, num: "В")
  }
}
