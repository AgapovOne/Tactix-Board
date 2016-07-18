//
//  Drawing.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 28/09/15.
//  Copyright © 2015 agapov.one.ru. All rights reserved.
//

import UIKit

enum LineType {
  case Dashed,
  Thin,
  Thick
}

class DrawingView: UIView {
  
  var drawColor = white
  var lineWidth: CGFloat = 3
  
  private var firstPoint = CGPointMake(0,0)
  private var endPoint = CGPointMake(0,0)
  
  private struct ContextLine {
    var lineType = LineType.Thin
    var firstPoint:CGPoint = CGPointMake(0,0)
    var endPoint = CGPointMake(0,0)
  }
  
  private var pointsArray: [ContextLine] = []
  var isClearing = false
  var isArrows = true
  
  // MARK: - Touch handling
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touch: AnyObject? = touches.first
    firstPoint = touch!.locationInView(self)
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touch: AnyObject? = touches.first
    let newPoint = touch!.locationInView(self)
    
    endPoint = newPoint
    
    setNeedsDisplay()
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touch: AnyObject? = touches.first
    let newPoint = touch!.locationInView(self)
    
    endPoint = newPoint
    
    setNeedsDisplay()
    
    let currentLineType:LineType = getLineTypeFromString(NSUserDefaults.standardUserDefaults().stringForKey("currentLineType")!)
    pointsArray.append(ContextLine(lineType: currentLineType, firstPoint: firstPoint, endPoint: endPoint))
  }
  
  override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
    touchesEnded(touches!, withEvent: event)
  }
  
  // MARK: - Render
  
  func distanceBetweenPoints(f:CGPoint,e:CGPoint) -> CGFloat {
    return hypot(f.x - e.x, f.y - e.y)
  }
  
  func drawLine(type:LineType, first:CGPoint, end:CGPoint) {
    if !(first == CGPointMake(0,0) && end == CGPointMake(0, 0)) {
      let ctx = UIGraphicsGetCurrentContext()
      switch type {
      case .Dashed:
        /*
        let lengths = [
        32, 16,
        ].map { CGFloat($0) }
        
        CGContextSetLineDash (ctx, 0, lengths, lengths.count)
        */
        let parts = distanceBetweenPoints(first, e: end)
        
        let dashes: [CGFloat] = [parts/6, parts/12] // FIX!
        CGContextSetLineDash(ctx, 0, dashes, dashes.count)
        CGContextSetLineWidth(ctx, lineWidth)
      case .Thick:
        CGContextSetLineWidth(ctx, lineWidth * 2)
      case .Thin:
        CGContextSetLineWidth(ctx, lineWidth)
      }
      
      CGContextSetLineJoin(ctx, .Round)
      CGContextSetLineCap(ctx, .Round)
      CGContextSetStrokeColorWithColor(ctx, drawColor.CGColor)
      
      CGContextMoveToPoint(ctx, first.x, first.y)
      CGContextAddLineToPoint(ctx, end.x, end.y)
      
      CGContextClosePath(ctx)
      CGContextStrokePath(ctx)
    }
    /*
    if isArrows {
    let ax1 = ((cx+end.x)/2) + arrowWidth * ((-1*(end.y-cy)/length))
    let ax2 = ((cx+end.x)/2) - arrowWidth * ((-1*(end.y-cy)/length))
    let ay1 = ((cy+end.y)/2) + arrowWidth * (((end.x-cx)/length))
    let ay2 = ((cy+end.y)/2) - arrowWidth * (((end.x-cx)/length))
    
    let ctx2 = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(ctx2, drawColor.CGColor)
    CGContextSetLineJoin(ctx, .Round)
    CGContextSetLineCap(ctx, .Round)
    
    CGContextMoveToPoint(ctx2, end.x, end.y)
    CGContextAddLineToPoint(ctx2, ax1, ay1)
    CGContextAddLineToPoint(ctx2, ax2, ay2)
    
    CGContextClosePath(ctx2)
    CGContextFillPath(ctx2)
    /*
    lengthOfArrow = 2;
    widthOfArrow = 1;
    length = sqrt((x2-x1)^2+(y2-y2)^2);
    cx = x2-((x2-x1)/length)*2*lengthOfArrow;
    cy = y2-((y2-y1)/length)*2*lengthOfArrow;
    
    ax1 = ((cx+x2)/2)+(widthOfArrow*((-1*(y2-cy))/length));
    ax2 = ((cx+x2)/2)-(widthOfArrow*((-1*(y2-cy))/length));
    ay1 = ((cy+y2)/2)+(widthOfArrow*(((x2-cx))/length));
    ay2 = ((cy+y2)/2)-(widthOfArrow*(((x2-cx))/length));
    */
    }
    */
  }
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    for contextLine in pointsArray {
      drawLine(contextLine.lineType, first: contextLine.firstPoint, end: contextLine.endPoint)
    }
    if isClearing == false {
      let currentLineType:LineType = getLineTypeFromString(NSUserDefaults.standardUserDefaults().stringForKey("currentLineType")!)
      drawLine(currentLineType, first: self.firstPoint, end: self.endPoint)
    } else {
      isClearing = false
    }
  }
  
  // MARK: - Clearing
  
  func clear() {
    self.pointsArray.removeAll(keepCapacity: false)
    isClearing = true
    setNeedsDisplay()
  }
  
  // MARK: - Settings
  
  func setLineType(lineType:LineType) {
    NSUserDefaults.standardUserDefaults().setValue(getStringFromLineType(lineType), forKey: "currentLineType")
  }
  
  func getStringFromLineType(lineType: LineType) -> String {
    switch lineType {
    case .Dashed:
      return "dashed"
    case .Thick:
      return "thick"
    case .Thin:
      return "thin"
    }
  }
  
  func getLineTypeFromString(str:String) -> LineType {
    switch str {
    case "dashed":
      return .Dashed
    case "thick":
      return .Thick
    case "thin":
      return .Thin
    default:
      return .Thin
    }
  }
}