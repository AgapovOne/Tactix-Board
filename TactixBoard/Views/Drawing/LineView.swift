//
//  LineView.swift
//  TactixBoard
//
//  Created by Алексей Агапов on 28/09/15.
//  Copyright © 2015 agapov.one.ru. All rights reserved.
//

import UIKit

class LineView: UIView {

    var drawColor = Color.white
    var lineWidth: CGFloat = 3

    fileprivate var firstPoint = CGPoint(x: 0,y: 0)
    fileprivate var endPoint = CGPoint(x: 0,y: 0)

    fileprivate struct ContextLine {
        var lineType = LineType.thin
        var firstPoint:CGPoint = CGPoint(x: 0,y: 0)
        var endPoint = CGPoint(x: 0,y: 0)
    }

    fileprivate var pointsArray: [ContextLine] = []
    var isClearing = false
    var isArrows = true

    // MARK: - Touch handling

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first
        firstPoint = touch!.location(in: self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first
        let newPoint = touch!.location(in: self)

        endPoint = newPoint

        setNeedsDisplay()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: AnyObject? = touches.first
        let newPoint = touch!.location(in: self)

        endPoint = newPoint

        setNeedsDisplay()

        pointsArray.append(ContextLine(lineType: DrawManager.shared.lineType, firstPoint: firstPoint, endPoint: endPoint))
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }

    // MARK: - Render

    func distanceBetweenPoints(_ f:CGPoint,e:CGPoint) -> CGFloat {
        return hypot(f.x - e.x, f.y - e.y)
    }

    func drawLine(_ type: LineType, first: CGPoint, end: CGPoint) {
        if !(first == CGPoint(x: 0,y: 0) && end == CGPoint(x: 0, y: 0)) {
            let ctx = UIGraphicsGetCurrentContext()
            ctx?.setLineDash(phase: 0, lengths: [])
            switch type {
            case .dashed:
//                let parts = distanceBetweenPoints(first, e: end)
//                ctx?.setLineDash(phase: 0, lengths: [parts/6, parts/12])
                ctx?.setLineWidth(lineWidth)
            case .thick:
                ctx?.setLineWidth(lineWidth * 2)
            case .thin:
                ctx?.setLineWidth(lineWidth)
            }

            ctx?.setLineJoin(.round)
            ctx?.setLineCap(.round)
            ctx?.setStrokeColor(drawColor.cgColor)

            ctx?.move(to: CGPoint(x: first.x, y: first.y))
            ctx?.addLine(to: CGPoint(x: end.x, y: end.y))

            ctx?.closePath()
            ctx?.strokePath()
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

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        for contextLine in pointsArray {
            drawLine(contextLine.lineType, first: contextLine.firstPoint, end: contextLine.endPoint)
        }
        if isClearing == false {
            drawLine(DrawManager.shared.lineType, first: self.firstPoint, end: self.endPoint)
        } else {
            isClearing = false
        }
    }
    
    // MARK: - Clearing
    
    func clear() {
        self.pointsArray.removeAll(keepingCapacity: false)
        isClearing = true
        setNeedsDisplay()
    }
}
