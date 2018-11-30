//
//  deck.swift
//  HW2_SetGame
//
//  Created by Анастасия Латыш on 29/11/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import Foundation

struct deck {
    enum color: CaseIterable {
        case red
        case green
        case blue
    }
    
    enum figure: String, CaseIterable {
        case treug = "▲"
        case round = "●"
        case rectangle = "■"
    }
    
    enum countFigure: Int, CaseIterable {
        case one = 1
        case two
        case three
    }
    
    enum alphaFigure: CaseIterable {
        case stripped
        case filled
        case outline
    }
    
    struct oneCard {
        var cardColor: color
        var cardFigure: figure
        var cardCount: countFigure
        var cardAlpha: alphaFigure
    }
    
    static var deckOfCards = [oneCard]()
    
    static func createDeck()-> [oneCard] {
        for indexColor in color.allCases {
            for indexFigure in figure.allCases {
                for indexCountFigure in countFigure.allCases {
                    for indexAlpha in alphaFigure.allCases {
                        let newCard = oneCard(cardColor: indexColor, cardFigure: indexFigure, cardCount: indexCountFigure, cardAlpha: indexAlpha)
                        deckOfCards += [newCard]
                    }
                }
            }
        }
        deckOfCards.shuffle()
        return deckOfCards
        
    }
}
