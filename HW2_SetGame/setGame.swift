//
//  setGame.swift
//  HW2_SetGame
//
//  Created by Анастасия Латыш on 27/11/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import Foundation

class SetGame {
    var visibleCards = [Card]()
    var selectedCards = [Card]()
    var allCardsOnTheTable = [Card]()
    var setOnTheTable: Bool = false
    var deck = [Card]()

    
    static func createDeck()-> [Card] {
        var arrayDeck = [Card]()
        for indexColor in Card.color.allCases {
            for indexFigure in Card.figure.allCases {
                for indexCountFigure in Card.countFigure.allCases {
                    for indexAlpha in Card.alphaFigure.allCases {
                        let newCard = Card(cardColor: indexColor, cardFigure: indexFigure, cardCount: indexCountFigure, cardAlpha: indexAlpha )
                        arrayDeck.append(newCard)
                    }
                }
            }
        }
        arrayDeck.shuffle()
        return arrayDeck
        
    }
    func chooseCard (for card: Card){
        
        switch selectedCards.count {
        case 0..<3:
            do {
                if selectedCards.contains(card) {
                    let indexForRemove = selectedCards.index(of:card)
                    selectedCards.remove(at: indexForRemove!)
                } else {
                     selectedCards += [card]
                    if selectedCards.count == 3 {
                        
                    }
                }
                
            }
        case 3:
            do { if checkSet(for: selectedCards) { setOnTheTable = true
                for card in selectedCards {
                    if let indexCrad = visibleCards.index(of: card) {
                        visibleCards[indexCrad] = self.deck.remove(at: 1)
                        if let index = allCardsOnTheTable.index(of: card) {
                            allCardsOnTheTable[index] = visibleCards[indexCrad]
                        }
                    }
                }
        } else {selectedCards.removeAll()}}
        default:
            print ("tratata")
        }
      /*  if selectedCards.count < 3 && selectedCards.contains(card){
            let indexForRemove = selectedCards.index(of:card)
            selectedCards.remove(at: indexForRemove!)
        }
        else
        if selectedCards.count < 3 && !selectedCards.contains(card) {
            selectedCards += [card]

        }
        if selectedCards.count == 3 {
            if checkSet(for: selectedCards) { setOnTheTable = true
                for card in selectedCards {
                    if let indexCrad = visibleCards.index(of: card) {
                        visibleCards[indexCrad] = self.deck.remove(at: 1)
                        if let index = allCardsOnTheTable.index(of: card) {
                            allCardsOnTheTable[index] = visibleCards[indexCrad]
                        }
                    }
                }
            } else {selectedCards.removeAll()}
        }
*/
    }
    
    func checkSet(for cards: [Card])-> Bool {
        if cards.count == 3 {
            let sum = cards.map({$0.cardAlpha.rawValue}).reduce(0, +) + cards.map({$0.cardColor.rawValue}).reduce(0, +) + cards.map({$0.cardCount.rawValue}).reduce(0, +) + cards.map({$0.cardFigure.rawValue}).reduce(0, +)
            return sum % 3 == 0 ? true : false
        }
        return false
    }
    
    
    init (countVisibleCard: Int, countCardsOnTheTable: Int) {
        self.deck = SetGame.createDeck()
        for index in 0..<countCardsOnTheTable {
            let card = deck.remove(at: index)
            allCardsOnTheTable += [card]
            if index <  countVisibleCard {visibleCards += [card]}
        }
 }
}
