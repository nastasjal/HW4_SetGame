//
//  TableView.swift
//  HW3_SetGame
//
//  Created by Анастасия Латыш on 05/12/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class Table: UIView {
    
    
    var cardViewArray = [CardView]()
    {
        willSet { removeSubviews() }
        didSet { addSubviews()
            setNeedsLayout()
            
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        var grid = Grid(layout: Grid.Layout.aspectRatio(0.7),
                        frame: bounds)
        grid.cellCount = cardViewArray.count
        for index in 0..<cardViewArray.count {
         //   self.cardViewArray[index].alpha = 1
          //  self.cardViewArray[index].isFaceUp = false
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: TimeInterval(index) * 0.2, options: [ .curveEaseOut], animations: {self.cardViewArray[index].frame =  grid[index]!.insetBy(dx: 2.0, dy: 2.0)}, completion: { position in
                if !self.cardViewArray[index].isFaceUp {
                UIView.transition(with: self.cardViewArray[index], duration: 0.5, options: .transitionFlipFromLeft, animations: {self.cardViewArray[index].isFaceUp = true})
                }
            } )
        
        }
    }
    
    
    func updateView(){
        removeSubviews()
        addSubviews()
        setNeedsLayout()
       // setNeedsDisplay()
    }
    
    
    
    private func removeSubviews() {
        for card in cardViewArray {
            card.removeFromSuperview()
        }
        print("remove all subviews")
        print (subviews)
    }
    
    private func addSubviews() {
        for card in cardViewArray.reversed() {
            addSubview(card)
        }
        print ("add all subviews")
        print (subviews)
    }
   
    
    
}

