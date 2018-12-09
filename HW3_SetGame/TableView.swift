//
//  TableView.swift
//  HW3_SetGame
//
//  Created by Анастасия Латыш on 05/12/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class TableView: UIView {
    
    
    var cardViewArray = [CardView]()
    {
        willSet { removeSubviews() }
        didSet { addSubviews()
            setNeedsDisplay()
            setNeedsLayout() }
    }
    
 /*  var cardsCountOnTheTable: Int = 15 {
        didSet {
            grid.cellCount = cardsCountOnTheTable
        //   cardViewArray.removeAll()
            for index in 0..<cardsCountOnTheTable {
                cardViewArray.append(CardView(frame: grid[index]! ))
            }
            setNeedsDisplay()
            setNeedsLayout()
        }
    }*/
   
  /*  override func layoutSubviews() {
        super.layoutSubviews()
        var grid = Grid(layout: Grid.Layout.aspectRatio(0.7),
                        frame: bounds)
         grid.cellCount = cardViewArray.count
        for index in 0..<cardViewArray.count {
            cardViewArray[index].frame =  grid[index]!
        }
      print (subviews)
      
    }*/
    
    override func draw(_ rect: CGRect) {
        var grid = Grid(layout: Grid.Layout.aspectRatio(0.7),
                        frame: bounds)
        grid.cellCount = cardViewArray.count
        for index in 0..<cardViewArray.count {
            cardViewArray[index].frame =  grid[index]!
        }
    }
    
    
    func updateView(){
        removeSubviews()
        addSubviews()
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    
    
    private func removeSubviews() {
        for card in cardViewArray {
            card.removeFromSuperview()
        }
        print("remove all subviews")
        print (subviews)
    }
    
    private func addSubviews() {
        for card in cardViewArray {
            addSubview(card)
        }
        print ("add all subviews")
        print (subviews)
    }
    
  /*  override func draw(_ rect: CGRect) {
        
        var grid = Grid(layout: Grid.Layout.aspectRatio(0.7),
                        frame: bounds)
        grid.cellCount = visibleCards.count
        
        for i in 0..<visibleCards.count {
            
            let addCard = CardView(frame: grid[i]! )
            
            switch visibleCards[i].cardColor{
            case .blue:
                addCard.figureColor = UIColor.blue
            case .green:
                addCard.figureColor = UIColor.green
            case .red:
                addCard.figureColor = UIColor.red
            }
            switch visibleCards[i].cardFigure{
            case .rectangle:
                addCard.figureType = .diamond
            case .round:
                addCard.figureType = .round
            case .treug:
                addCard.figureType = .squiggle
            }
            switch visibleCards[i].cardCount {
            case .one:
                addCard.figureCounts = 1
            case .two:
                addCard.figureCounts = 2
            case .three:
                addCard.figureCounts = 3
            }
            
            switch visibleCards[i].cardAlpha {
            case .filled:
                addCard.figureFill = .solid
            case .outline:
                addCard.figureFill = .unfilled
            case .stripped:
                addCard.figureFill = .stripped
            }
            
            addSubview(addCard)
        }
        
    }
    */
   
    
    
}

