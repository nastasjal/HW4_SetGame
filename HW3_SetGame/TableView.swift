//
//  TableView.swift
//  HW3_SetGame
//
//  Created by Анастасия Латыш on 05/12/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class TableView: UIView {
    
    
    var cardsCountOnTheTable: Int = 3 {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var visibleCards = [Card]()
    
    
    override func draw(_ rect: CGRect) {
        
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
    
    
    
    
}

extension TableView {
    
    var cardWidth: CGFloat {
        return cardHeight * 5 / 8
    }
    
    var cardHeight: CGFloat {
        return  (bounds.height - CGFloat(rowCount * 5))/CGFloat(rowCount)
    }
    
    var rowCount: Int {
        return (cardsCountOnTheTable / 3)
    }
    
}
