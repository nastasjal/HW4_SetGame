//
//  Card.swift
//  HW2_SetGame
//
//  Created by Анастасия Латыш on 27/11/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import Foundation
struct Card: Equatable {
    
    enum color:Int, CaseIterable {
        case green = 1
        case red
        case blue
    }
    
    enum figure: Int, CaseIterable {
        case squiggle = 1
        case round
        case diamond
    }
    
    enum countFigure: Int, CaseIterable {
        case one = 1
        case two
        case three
    }
    
    enum alphaFigure: Int, CaseIterable {
        case stripped = 1
        case solid
        case unfilled
    }
    
    var cardColor: color
    var cardFigure: figure
    var cardCount: countFigure
    var cardAlpha: alphaFigure
    
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.cardAlpha == rhs.cardAlpha) && (lhs.cardColor == rhs.cardColor) && (lhs.cardCount == rhs.cardCount ) && (lhs.cardFigure == rhs.cardFigure)
    }
   
    init (cardColor: color, cardFigure: figure, cardCount: countFigure,  cardAlpha: alphaFigure) {
        self.cardAlpha = cardAlpha
        self.cardColor = cardColor
        self.cardCount = cardCount
        self.cardFigure = cardFigure
    }

}
