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
  
  @IBOutlet weak var popAddMenu: UIView!
  
  var isDrawing = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    PlayerView.initPlayers(boardView) // FIX!
    
    boardView.addSubview(BallView(x: (self.view.frame.width) / 2 + 60, y: (self.view.frame.height / 2))) // add ball // FIX!
    
    drawView.userInteractionEnabled = false
    // Do any additional setup after loading the view, typically from a nib.
    popAddMenu.hidden = true
    
    for view in menuBar.subviews {
      print(view)
    }
  }
  
  // MARK: - Players part
  
  func addNewPlayer(sender:UIButton) {
    let newPlayer = PlayerView().createPlayer(PlayerColor.Orange, x: (self.view.frame.width) / 2 + 60, y: self.view.frame.height / 2)
    boardView.addSubview(newPlayer) // FIX!
  }
  
  @IBAction func popMenuShow(sender: UIButton) {
    sender.backgroundColor = UIColor.flatGreenColor()
    popAddMenu.hidden = false
  }
  
  // MARK: - Drawing part
  
  @IBAction func clearDrawings(sender: UIButton) {
    drawView.clear()
    DrawingView().setLineType(.Dashed)
  }
  
  @IBAction func startDrawings(sender: UIButton) {
    if isDrawing == false {
      drawView.userInteractionEnabled = true
      
      for view in self.view.subviews {
        if view.isKindOfClass(MovingView) {
          let movingView = view as! MovingView
          movingView.disableMoves()
        }
      }
      
      sender.setAttributedTitle(NSAttributedString(string: "Stop Drawing"), forState: UIControlState.Normal)
      self.isDrawing = true
    } else {
      drawView.userInteractionEnabled = false
      
      for view in self.view.subviews {
        if view.isKindOfClass(MovingView) {
          let movingView = view as! MovingView
          movingView.enableMoves()
        }
      }
      
      sender.setAttributedTitle(NSAttributedString(string: "Start Drawing"), forState: UIControlState.Normal)
      self.isDrawing = false
    }
  }
}
