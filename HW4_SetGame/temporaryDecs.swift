//
//  temporaryDecs.swift
//  HW4_SetGame
//
//  Created by Анастасия Латыш on 13/12/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class temporaryDecs: UIView {

 //   var backStageCard = UIView(frame: CGRect(x:  , y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: bounds.height ))
  //  var deck = [UIView]()
    
  //  var Sets = [UIView]()
    
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
     //   let tempCard = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        if let cardBackImage = UIImage(named: "card") {
            cardBackImage.draw(in: bounds)
        }
    }
    

}
