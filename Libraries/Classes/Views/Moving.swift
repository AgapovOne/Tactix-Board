//
//  Moving.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 28/09/15.
//  Copyright © 2015 agapov.one.ru. All rights reserved.
//

import UIKit

// MARK: - Moving view w/o sizes

class MovingView: UIView {
  var lastLocation:CGPoint = CGPointMake(0, 0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    // Initialization code
    let panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:")
    self.gestureRecognizers = [panRecognizer]
    
    self.layer.cornerRadius = frame.width / 2
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func detectPan(recognizer:UIPanGestureRecognizer) {
    let translation  = recognizer.translationInView(self.superview!)
    self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    // Promote the touched view
    if (self.gestureRecognizers?.isEmpty == false) {
      self.superview?.bringSubviewToFront(self)
      lastLocation = self.center
    }
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /*
    if (self.gestureRecognizers?.isEmpty == false) {
      UIView.animateWithDuration(0.1, animations: { () -> Void in
        self.transform = CGAffineTransformMakeScale(1, 1)
      })
    }
    */
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /*
    if (self.gestureRecognizers?.isEmpty == false) {
      UIView.animateWithDuration(0.1, animations: { () -> Void in
        self.transform = CGAffineTransformMakeScale(1, 1)
      })
    }
    */
  }
  
  override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
    if (self.gestureRecognizers?.isEmpty == false) {
      let frame = CGRectInset(self.bounds, -15, -15) // enlarge touch area for 15 px around
      return CGRectContainsPoint(frame, point) ? self : nil
    } else {
      let frame = CGRectInset(self.bounds, self.bounds.size.width, self.bounds.size.height) // enlarge touch area for 10 px around
      return CGRectContainsPoint(frame, point) ? self : nil
    }
  }
  
  func setBackgroundImage(imgName:String) {
    UIGraphicsBeginImageContext(self.frame.size)
    UIImage(named: imgName)?.drawInRect(self.bounds)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    self.backgroundColor = UIColor(patternImage: image)
  }
    func disableMoves() {
    self.gestureRecognizers = []
    self.userInteractionEnabled = false
  }
  
  func enableMoves() {
    let panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:")
    self.gestureRecognizers = [panRecognizer]
    self.userInteractionEnabled = true
  }
}

// TODO: - Ball

class BallView:MovingView {
  
  convenience init(x:CGFloat,y:CGFloat) {
    self.init(frame: CGRectMake(x - 18,y - 18,36.0,36.0))
    /*
    UIGraphicsBeginImageContext(self.frame.size)
    UIImage(named: "ball.png")?.drawInRect(self.bounds)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    */
    self.backgroundColor = UIColor(patternImage: UIImage(named: "ball.png")!)
  }
}

// TODO: - Player with custom color and letter/number on top

enum PlayerColor {
  case Red, Blue, Black, Green, Orange
  func getColor() -> UIColor {
    switch self {
    case .Red: return red
    case .Blue: return blue
    case .Black: return black
    case .Green: return green
    case .Orange: return orange
    }
  }
}

class PlayerView:MovingView {
  
  convenience init(x:CGFloat,y:CGFloat) {
    self.init(frame: CGRectMake(x - 22,y - 22,44.0,44.0))
  }
  
  convenience init(color: PlayerColor, num: String, x:CGFloat, y:CGFloat) {
    self.init(frame: CGRectMake(x - 22,y - 22,44.0,44.0))
    self.backgroundColor = color.getColor()
    
    self.layer.borderColor = white.CGColor
    self.layer.borderWidth = 2.0
    
    let number = UILabel(frame:CGRectMake(0,0,44,44))
    number.text = num
    number.font = numberFont
    number.textAlignment = .Center
    number.center = CGPointMake(22, 22)
    number.textColor = white
    //number.sizeToFit()
    
    self.addSubview(number)
  }
  
  func createPlayer(color: PlayerColor, num: String, x:CGFloat, y:CGFloat) -> PlayerView {
    let newPlayer = PlayerView(x: x, y: y)
    newPlayer.backgroundColor = color.getColor()
    let number = UILabel()
    number.text = num
    number.font = numberFont
    number.center = newPlayer.center
    newPlayer.addSubview(number)
    return newPlayer
  }
  
  class func initPlayers(field:UIImageView) {
    let playersAtPositions: [PlayerView] = [
      self.createPlayerAtPosition(field, color:.Orange, num:"В", x: 0, y: -420),
      self.createPlayerAtPosition(field, color:.Red, num:"1", x: 80, y: -200),
      self.createPlayerAtPosition(field, color:.Red, num:"3", x: -80, y: -200),
      self.createPlayerAtPosition(field, color:.Red, num:"5", x: 80, y: -100),
      self.createPlayerAtPosition(field, color:.Red, num:"7", x: -80, y: -100),
      self.createPlayerAtPosition(field, color:.Blue, num:"2", x: 80, y: 100),
      self.createPlayerAtPosition(field, color:.Blue, num:"4", x: -80, y: 100),
      self.createPlayerAtPosition(field, color:.Blue, num:"6", x: 80, y: 200),
      self.createPlayerAtPosition(field, color:.Blue, num:"8", x: -80, y: 200),
      self.createPlayerAtPosition(field, color:.Green, num:"В", x: 0, y: 420)]
    for player in playersAtPositions {
      field.superview?.addSubview(player)
    }
  }
  
  class func fieldCenter(field:UIImageView) -> (x:CGFloat,y:CGFloat) {
    let x = field.frame.width / 2 + 60
    let y = field.frame.height / 2
    return (x,y)
  }
  
  class func createPlayerAtPosition(field:UIImageView, color:PlayerColor, num:String, x:CGFloat, y:CGFloat) -> PlayerView {
    let center = self.fieldCenter(field)
    
    return PlayerView(color:color, num:num, x: center.x + x, y: center.y + y)
  }
}

class Number {
  
  static let sharedInstance = Number()
  
  var numbersArray: [Int] = []
  
  func red() -> String {
    var newNumber = ""
    for number in numbersArray {
      if number % 2 == 0 {
        newNumber = "\(number)"
      }
    }
    return newNumber
  }
}