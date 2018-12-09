//
//  CardView.swift
//  HW3_SetGame
//
//  Created by Анастасия Латыш on 05/12/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var figureColor: UIColor = UIColor.green
    var figureCounts: Int = 2
    var figureType = figure.diamond
    var figureFill = fill.stripped
    
    enum figure: Int, CaseIterable {
        case squiggle = 1
        case round
        case diamond
    }
    enum fill: Int {
        case solid  //плотно закрашены
        case stripped  // заштрихованы
        case unfilled  // нет заливки
    }
    
    
    override func draw(_ rect: CGRect) {
        let cardRect = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        UIColor.yellow.setFill()
        cardRect.fill()
        
        for index in 0..<figureCounts {
            let currectRect = CGRect ( x: leftTopPoinOfRectangle.x, y: leftTopPoinOfRectangle.y + CGFloat(index) * (heightRect + interline), width: widthRect, height: heightRect)
            let pathFigure = drawShape(in: currectRect)
            
            switch figureFill {
            case .solid:
                figureColor.setFill()
                pathFigure.fill()
            case .stripped:
                let context = UIGraphicsGetCurrentContext()
                //save the current graphic context
                context?.saveGState()
                // clipping area
                pathFigure.addClip()
                strippedRect(in: currectRect)
                context?.restoreGState()
            default: break
            }
            
            pathFigure.lineWidth = 3.0
            let strokeColor = figureColor
            strokeColor.setStroke()
            pathFigure.stroke()
            print ("height = \(heightRect) , width = \( widthRect)")
        }
    }
    
    func strippedRect(in rect: CGRect){
        let strippedPath = UIBezierPath()
        for interval in stride(from: 0, to: rect.maxX, by: 3) {
            strippedPath.move(to: CGPoint(x: interval*2, y: rect.minY))
            strippedPath.addLine(to: CGPoint(x: interval, y: rect.maxY))
        }
        let strokeColor = figureColor
        strokeColor.setStroke()
        strippedPath.stroke()
    }
    
    
    func drawShape(in rect: CGRect) -> UIBezierPath {
        switch figureType {
        case figure.squiggle:
            return drowSquiggles(in: rect)
        case figure.diamond:
            return drowDiamonds(in: rect)
        case figure.round:
            return drowRoundRect(in: rect)
        }
        
    }
    
    func drowSquiggles(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.minY*2/5),
                      controlPoint1: CGPoint(x: rect.minX / 2, y: rect.minY/5),
                      controlPoint2: CGPoint(x: rect.maxX, y: rect.maxY))
        
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                      controlPoint1: CGPoint(x: rect.maxX + rect.midX/3, y: rect.maxY + rect.midY/2),
                      controlPoint2: CGPoint(x: rect.minX / 2 + rect.midX/2, y: rect.minY/5 + rect.midY/2))
        path.close()
        /* path.addCurve(to: CGPoint(x: rightPointX + leftPointX/2, y: topPointY * 2 / 5),
         controlPoint1: CGPoint(x: leftPointX / 2, y: topPointY/5),
         controlPoint2: CGPoint(x: rightPointX + leftPointX/2, y: topPointY))
         
         path.addCurve(to: CGPoint(x: leftPointX / 2, y: topPointY),
         controlPoint1: CGPoint(x: rightPointX + leftPointX, y: topPointY*3/2) ,
         controlPoint2: CGPoint(x: leftPointX, y: topPointY*7/10))
         */return path
    }
    
    func drowDiamonds(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.close()
        return path
    }
    
    func drowRoundRect(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: leftPointX/2)
        return path
    }
    
    override init ( frame: CGRect) {
        super.init ( frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension CardView {
    
    var leftPointX: CGFloat {
        return (bounds.width / 4)
    }
    
    var rightPointX: CGFloat {
        return (bounds.width * 3 / 4)
    }
    
    var topPointY: CGFloat {
        return (bounds.height / 4)
    }
    
    var bottomPointY: CGFloat {
        return (bounds.height * 3 / 4)
    }
    
    var leftTopPoinOfRectangle: CGPoint {
        get {
            let yPoint = bounds.height - heightRect * CGFloat(figureCounts) - interline * (CGFloat(figureCounts)-1)
            return CGPoint(x: (bounds.width - widthRect)/2, y: yPoint / 2)
        }
    }
    
    var widthRect: CGFloat {
        get {
            return bounds.width * 9 / 10
        }
    }
    
    var heightRect: CGFloat {
        get {
            return bounds.height / 4
        }
    }
    
    var interline: CGFloat {
        return heightRect/8
    }
    
}
