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
                        if checkSet(for: selectedCards) { setOnTheTable = true}
                    }
                }
                
            }
        case 3:
            do { if checkSet(for: selectedCards) {
                if selectedCards.contains(card) {
                    selectedCards.removeAll()
                } else {
                    for card in selectedCards {
                        if let indexCrad = visibleCards.index(of: card) {
                            if self.deck.count > 0 {
                                visibleCards[indexCrad] = self.deck.remove(at: 0)
                                if let index = allCardsOnTheTable.index(of: card) {
                                    allCardsOnTheTable[index] = visibleCards[indexCrad]
                                }
                            } else {
                                visibleCards.remove(at: indexCrad)
                                allCardsOnTheTable.remove(at: indexCrad)
                            }
                            
                        }
                    } 
                }
                setOnTheTable = false
                }
                selectedCards.removeAll()
                selectedCards += [card]
            }
        default: break
        //    print ("tratata")
        }
    }
    
    func checkSet(for cards: [Card])-> Bool {
        if cards.count == 3 {
            return (cards.map({$0.cardAlpha.rawValue}).reduce(0, +) % 3 == 0 && cards.map({$0.cardColor.rawValue}).reduce(0, +) % 3 == 0 && cards.map({$0.cardCount.rawValue}).reduce(0, +) % 3 == 0 && cards.map({$0.cardFigure.rawValue}).reduce(0, +) % 3 == 0) ? true : false
        }
        return false
    }
    
    func deal3Card(){
        if !setOnTheTable && (deck.count > 0) {
            for _ in 0..<3 {
                let card = self.deck.remove(at: 0)
                allCardsOnTheTable.append(card)
                visibleCards.append(card)
            }
        }
        setOnTheTable = false
    }
    
    func shufleDeck() {
        allCardsOnTheTable.shuffle()
        visibleCards = allCardsOnTheTable
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
