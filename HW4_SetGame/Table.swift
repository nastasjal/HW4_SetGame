//
//  TableView.swift
//  HW3_SetGame
//
//  Created by Анастасия Латыш on 05/12/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class Table: UIView {
    
    var lastCellSize = CGSize()
    
    var cardViewArray = [CardView]()
    {
        willSet {
            if cardViewArray.count % 3 == 0 {
            var grid = Grid(layout: Grid.Layout.aspectRatio(0.7),
                            frame: bounds)
            grid.cellCount = cardViewArray.count
            self.lastCellSize = grid.cellSize
            print ("cell count = \(grid.cellCount)")
            print ("will Set size = \(self.lastCellSize)")
            removeSubviews()
            }
            
        }
        didSet {
            if cardViewArray.count % 3 == 0 {
                addSubviews()
            setNeedsLayout()
            }
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        var grid = Grid(layout: Grid.Layout.aspectRatio(0.7),
                        frame: bounds)
        grid.cellCount = cardViewArray.count
          print ("oldcell size = \(self.lastCellSize)")
          print ("currentcell size = \(grid.cellSize)")
        if self.lastCellSize != grid.cellSize {
        for index in 0..<cardViewArray.count {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: TimeInterval(index) * 0.2, options: [ .curveEaseOut], animations: {self.cardViewArray[index].frame =  grid[index]!.insetBy(dx: 2.0, dy: 2.0)}, completion: { position in
                if !self.cardViewArray[index].isFaceUp {
                UIView.transition(with: self.cardViewArray[index], duration: 0.8, options: .transitionFlipFromLeft, animations: {self.cardViewArray[index].isFaceUp = true})
                }
            } )
        
        }
        } else {
        var testArray = cardViewArray.enumerated().filter(){ !$0.element.isFaceUp}.map{ $0.offset }
        var indexTimer = 0
        for index in testArray {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: TimeInterval(indexTimer) * 0.2, options: [ .curveEaseOut], animations: {self.cardViewArray[index].frame =  grid[index]!.insetBy(dx: 2.0, dy: 2.0)}, completion: { position in
                if !self.cardViewArray[index].isFaceUp {
                    UIView.transition(with: self.cardViewArray[index], duration: 0.8, options: .transitionFlipFromLeft, animations: {self.cardViewArray[index].isFaceUp = true})
                }
            } )
            indexTimer += 1
        }
        
        print("testArray = \(testArray)")
        
        }
        self.lastCellSize = grid.cellSize
    }
    
   
    
    func visibleAll() {
        for card in cardViewArray {
            card.alpha = 1
        }
    }
    
    private func removeSubviews() {
        for card in cardViewArray {
            card.removeFromSuperview()
        }
        print("remove all subviews")
      //  print (subviews)
    }
    
    private func addSubviews() {
        for card in cardViewArray.reversed() {
            addSubview(card)
        }
        print ("add all subviews")
     //   print (subviews)
    }
   
    
    
}

