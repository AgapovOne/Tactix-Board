//
//  Views.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 05/09/15.
//  Copyright (c) 2015 agapov.one.ru. All rights reserved.
//

import Foundation
import UIKit

class PlayerView: UIView {
  var lastLocation:CGPoint = CGPointMake(0, 0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    // Initialization code
    var panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:")
    self.gestureRecognizers = [panRecognizer]
    
    self.layer.cornerRadius = frame.width / 2
    if ((UIScreen.mainScreen().bounds.height - 49) / 2 > frame.origin.y) {
      self.backgroundColor = UIColor.redColor()
    } else {
      self.backgroundColor = UIColor.blueColor()
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func detectPan(recognizer:UIPanGestureRecognizer) {
    var translation  = recognizer.translationInView(self.superview!)
    self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    // Promote the touched view
    self.superview?.bringSubviewToFront(self)
    UIView.animateWithDuration(0.1, animations: { () -> Void in
      self.transform = CGAffineTransformMakeScale(1.5, 1.5)
    })
    // Remember original location
    lastLocation = self.center
  }
  
  override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    UIView.animateWithDuration(0.1, animations: { () -> Void in
      self.transform = CGAffineTransformMakeScale(1, 1)
    })
  }
  
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    UIView.animateWithDuration(0.1, animations: { () -> Void in
      self.transform = CGAffineTransformMakeScale(1, 1)
    })
  }
  
  /*
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect)
  {
  // Drawing code
  }
  */
  
  class func createPlayers(field:UIImageView) {
    let viewsPositions = [
      playerPosition(field, 0, -400),
      playerPosition(field, 80, -200),
      playerPosition(field, -80, -200),
      playerPosition(field, 80, -100),
      playerPosition(field, -80, -100),
      playerPosition(field, 80, 100),
      playerPosition(field, -80, 100),
      playerPosition(field, 80, 200),
      playerPosition(field, -80, 200),
      playerPosition(field, 0, 400)]
    
    for pos in viewsPositions {
      field.superview?.addSubview(PlayerView(frame: pos))
    }

  }
  
}