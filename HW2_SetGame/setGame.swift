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
    var selectedCardsIndexes = [Int]()
    
    func chooseCard (at index: Int){
        if selectedCardsIndexes.count < 3 && selectedCardsIndexes.contains(index){
            cards[index].selectedCard = false
            print ("change selected card to \(cards[index].selectedCard)")
          //  selectedCardsIndexes = selectedCardsIndexes.filter { $0 != index }
            let indexForRemove = selectedCardsIndexes.index(of:index)
            selectedCardsIndexes.remove(at: indexForRemove!)
        }
        else
        if selectedCardsIndexes.count < 3 && !selectedCardsIndexes.contains(index) {
            cards[index].selectedCard = true
            selectedCardsIndexes.append(index)
        }
        if selectedCardsIndexes.count == 3 {
            
        }
    }
    
    init (countCards: Int, countVisibleCard: Int) {
        for _ in 0..<countCards {
            var card = Card()
            if cards.count < countVisibleCard { card.visibleCard = true }
            cards += [card]
        }
    }
}
