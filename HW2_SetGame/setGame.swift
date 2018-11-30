//
//  setGame.swift
//  HW2_SetGame
//
//  Created by Анастасия Латыш on 27/11/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import Foundation

class SetGame {
    var cards = [Card]()
    
    init (countCards: Int, countVisibleCard: Int) {
        for _ in 0..<countCards {
            var card = Card()
            if cards.count < countVisibleCard { card.visibleCard = true }
            cards += [card]
        }
    }
}
