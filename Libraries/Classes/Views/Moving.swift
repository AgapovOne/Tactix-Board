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
  var lastLocation:CGPoint = CGPoint(x: 0, y: 0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    // Initialization code
    let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(MovingView.detectPan(_:)))
    self.gestureRecognizers = [panRecognizer]
    
    self.layer.cornerRadius = frame.width / 2
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func detectPan(_ recognizer:UIPanGestureRecognizer) {
    let translation  = recognizer.translation(in: self.superview!)
    self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    // Promote the touched view
    if (self.gestureRecognizers?.isEmpty == false) {
      self.superview?.bringSubview(toFront: self)
      lastLocation = self.center
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    /*
    if (self.gestureRecognizers?.isEmpty == false) {
      UIView.animateWithDuration(0.1, animations: { () -> Void in
        self.transform = CGAffineTransformMakeScale(1, 1)
      })
    }
    */
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    /*
    if (self.gestureRecognizers?.isEmpty == false) {
      UIView.animateWithDuration(0.1, animations: { () -> Void in
        self.transform = CGAffineTransformMakeScale(1, 1)
      })
    }
    */
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    if (self.gestureRecognizers?.isEmpty == false) {
      let frame = self.bounds.insetBy(dx: -15, dy: -15) // enlarge touch area for 15 px around
      return frame.contains(point) ? self : nil
    } else {
      let frame = self.bounds.insetBy(dx: self.bounds.size.width, dy: self.bounds.size.height) // enlarge touch area for 10 px around
      return frame.contains(point) ? self : nil
    }
  }
  
  func setBackgroundImage(_ imgName:String) {
    UIGraphicsBeginImageContext(self.frame.size)
    UIImage(named: imgName)?.draw(in: self.bounds)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    self.backgroundColor = UIColor(patternImage: image!)
  }
    func disableMoves() {
    self.gestureRecognizers = []
    self.isUserInteractionEnabled = false
  }
  
  func enableMoves() {
    let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(MovingView.detectPan(_:)))
    self.gestureRecognizers = [panRecognizer]
    self.isUserInteractionEnabled = true
  }
}

// TODO: - Ball

class BallView:MovingView {
  
  convenience init(x:CGFloat,y:CGFloat) {
    self.init(frame: CGRect(x: x - 18,y: y - 18,width: 36.0,height: 36.0))
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
  case red, blue, black, green, orange
  func getColor() -> UIColor {
    switch self {
    case .red: return UIColor.red
    case .blue: return UIColor.blue
    case .black: return UIColor.black
    case .green: return UIColor.green
    case .orange: return UIColor.orange
    }
  }
}

class PlayerView:MovingView {
  
  convenience init(x:CGFloat,y:CGFloat) {
    self.init(frame: CGRect(x: x - 22,y: y - 22,width: 44.0,height: 44.0))
  }
  
  convenience init(color: PlayerColor, num: String, x:CGFloat, y:CGFloat) {
    self.init(frame: CGRect(x: x - 22,y: y - 22,width: 44.0,height: 44.0))
    self.backgroundColor = color.getColor()
    
    self.layer.borderColor = white.cgColor
    self.layer.borderWidth = 2.0
    
    let number = UILabel(frame:CGRect(x: 0,y: 0,width: 44,height: 44))
    number.text = num
    number.font = numberFont
    number.textAlignment = .center
    number.center = CGPoint(x: 22, y: 22)
    number.textColor = white
    //number.sizeToFit()
    
    self.addSubview(number)
  }
  
  func createPlayer(_ color: PlayerColor, num: String, x:CGFloat, y:CGFloat) -> PlayerView {
    let newPlayer = PlayerView(x: x, y: y)
    newPlayer.backgroundColor = color.getColor()
    let number = UILabel()
    number.text = num
    number.font = numberFont
    number.center = newPlayer.center
    newPlayer.addSubview(number)
    return newPlayer
  }
  
  class func initPlayers(_ field:UIImageView) {
    let playersAtPositions: [PlayerView] = [
      self.createPlayerAtPosition(field, color:.orange, num:"В", x: 0, y: -420),
      self.createPlayerAtPosition(field, color:.red, num:"1", x: 80, y: -200),
      self.createPlayerAtPosition(field, color:.red, num:"3", x: -80, y: -200),
      self.createPlayerAtPosition(field, color:.red, num:"5", x: 80, y: -100),
      self.createPlayerAtPosition(field, color:.red, num:"7", x: -80, y: -100),
      self.createPlayerAtPosition(field, color:.blue, num:"2", x: 80, y: 100),
      self.createPlayerAtPosition(field, color:.blue, num:"4", x: -80, y: 100),
      self.createPlayerAtPosition(field, color:.blue, num:"6", x: 80, y: 200),
      self.createPlayerAtPosition(field, color:.blue, num:"8", x: -80, y: 200),
      self.createPlayerAtPosition(field, color:.green, num:"В", x: 0, y: 420)]
    for player in playersAtPositions {
      field.superview?.addSubview(player)
    }
  }
  
  class func fieldCenter(_ field:UIImageView) -> (x:CGFloat,y:CGFloat) {
    let x = field.frame.width / 2 + 60
    let y = field.frame.height / 2
    return (x,y)
  }
  
  class func createPlayerAtPosition(_ field:UIImageView, color:PlayerColor, num:String, x:CGFloat, y:CGFloat) -> PlayerView {
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
