//
//  BoardVC.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 07/09/15.
//  Copyright (c) 2015 agapov.one.ru. All rights reserved.
//

import UIKit
import SnapKit
import ChameleonFramework

class BoardVC: UIViewController {
  
  @IBOutlet weak var boardView: UIImageView!
  @IBOutlet weak var drawView: DrawingView!
  
  @IBOutlet weak var menuBar: UIView!
  
  @IBOutlet weak var popAddMenu: AddMenu!
  @IBOutlet weak var popDeleteMenu: DeleteMenu!
  @IBOutlet weak var popLineTypeMenu: LineTypeMenu!
  
  var isDrawing = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadPlayers()
    
    drawView.userInteractionEnabled = false
    // Do any additional setup after loading the view, typically from a nib.
    menuBar.layer.zPosition = 3
    popAddMenu.layer.zPosition = 3
    popDeleteMenu.layer.zPosition = 3
    DrawingView().setLineType(.Thin)
  }
  
  // MARK: - Players part
  
  func loadPlayers() {
    PlayerView.initPlayers(boardView) // FIX!
    for v in self.view.subviews {
      if v.isKindOfClass(PlayerView) {
        v.layer.zPosition = 2
      }
    }
    let ball = BallView(x: self.boardView.frame.width / 2 + 60, y: self.boardView.frame.height / 2)
    boardView.superview?.addSubview(ball) // add ball // FIX!
    ball.layer.zPosition = 2
    //boardView.userInteractionEnabled == false
  }
  
  // MARK: - Drawing part
  
  @IBAction func clearDrawings(sender: UIButton) {
    drawView.clear()
    DrawingView().setLineType(.Thick)
  }
  
  @IBAction func popLineTypeMenuShow(sender: UIButton) {
    let menu = popLineTypeMenu
    showHide(menu,sender: sender)
  }
  
  @IBAction func startDrawings(sender: UIButton) {
    if isDrawing == false {
      drawView.userInteractionEnabled = true
      sender.backgroundColor = UIColor.flatGreenColor()
      
      for view in self.view.subviews {
        if view.isKindOfClass(MovingView) {
          let movingView = view as! MovingView
          movingView.disableMoves()
        }
      }
      self.isDrawing = true
    } else {
      drawView.userInteractionEnabled = false
      sender.backgroundColor = sidebarColor
      
      for view in self.view.subviews {
        if view.isKindOfClass(MovingView) {
          let movingView = view as! MovingView
          movingView.enableMoves()
        }
      }
      self.isDrawing = false
    }
  }
  
  // MARK: - Sidebar Menu
  func showHide(menu:UIView,sender:UIButton) {
    if menu.hidden == true {
      menu.hidden = false
      sender.backgroundColor = UIColor.flatGreenColor()
    } else {
      menu.hidden = true
      sender.backgroundColor = sidebarColor
    }
  }
  @IBAction func popAddMenuShow(sender: UIButton) {
    let menu = popAddMenu
    showHide(menu,sender: sender)
  }
  
  @IBAction func popDeleteMenuShow(sender: UIButton) {
    let menu = popDeleteMenu
    showHide(menu,sender: sender)
  }
}
