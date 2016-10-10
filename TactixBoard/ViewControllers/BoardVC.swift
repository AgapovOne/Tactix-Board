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
    
    drawView.isUserInteractionEnabled = false
    // Do any additional setup after loading the view, typically from a nib.
    menuBar.layer.zPosition = 3
    popAddMenu.layer.zPosition = 3
    popDeleteMenu.layer.zPosition = 3
    DrawingView().setLineType(.thin)
  }
  
  // MARK: - Players part
  
  func loadPlayers() {
    PlayerView.initPlayers(boardView) // FIX!
    for v in self.view.subviews {
      if v.isKind(of: PlayerView.self) {
        v.layer.zPosition = 2
      }
    }
    let ball = BallView(x: self.boardView.frame.width / 2 + 60, y: self.boardView.frame.height / 2)
    boardView.superview?.addSubview(ball) // add ball // FIX!
    ball.layer.zPosition = 2
    //boardView.userInteractionEnabled == false
  }
  
  // MARK: - Drawing part
  
  @IBAction func clearDrawings(_ sender: UIButton) {
    drawView.clear()
    DrawingView().setLineType(.thick)
  }
  
  @IBAction func popLineTypeMenuShow(_ sender: UIButton) {
    let menu = popLineTypeMenu
    showHide(menu!,sender: sender)
  }
  
  @IBAction func startDrawings(_ sender: UIButton) {
    if isDrawing == false {
      drawView.isUserInteractionEnabled = true
      sender.backgroundColor = UIColor.flatGreen()
      
      for view in self.view.subviews {
        if view.isKind(of: MovingView.self) {
          let movingView = view as! MovingView
          movingView.disableMoves()
        }
      }
      self.isDrawing = true
    } else {
      drawView.isUserInteractionEnabled = false
      sender.backgroundColor = sidebarColor
      
      for view in self.view.subviews {
        if view.isKind(of: MovingView.self) {
          let movingView = view as! MovingView
          movingView.enableMoves()
        }
      }
      self.isDrawing = false
    }
  }
  
  // MARK: - Sidebar Menu
  func showHide(_ menu:UIView,sender:UIButton) {
    if menu.isHidden == true {
      menu.isHidden = false
      sender.backgroundColor = UIColor.flatGreen()
    } else {
      menu.isHidden = true
      sender.backgroundColor = sidebarColor
    }
  }
  @IBAction func popAddMenuShow(_ sender: UIButton) {
    let menu = popAddMenu
    showHide(menu!,sender: sender)
  }
  
  @IBAction func popDeleteMenuShow(_ sender: UIButton) {
    let menu = popDeleteMenu
    showHide(menu!,sender: sender)
  }
}
