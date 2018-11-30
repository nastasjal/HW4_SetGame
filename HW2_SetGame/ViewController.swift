//
//  ViewController.swift
//  HW2_SetGame
//
//  Created by Анастасия Латыш on 27/11/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var countVisibleCards = 12 {
        didSet {
           // (cardButton.count > countVisibleCards) ? cardButton.count : countVisibleCards
            updateViewFromModel()
        }
    }
 
    var countCardsOnTheTable: Int {
        get {
            return cardButton.count
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButton.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    // allDeck is array af all deck (81 card)
    var allDeck = deck.createDeck()
    
    lazy var game = SetGame(countCards: countCardsOnTheTable, countVisibleCard: countVisibleCards)
    
    func updateViewFromModel() {
        for index in cardButton.indices {
            let button = cardButton[index]
            let card = game.cards[index]
            if card.visibleCard {
                let currentTitle = getTitle(for: card)
                let text = getTitleProperties(titleFor: currentTitle)
                 button.setAttributedTitle(text, for: .normal)
                 button.layer.borderWidth = 3.0
                 button.layer.borderColor = UIColor.green.cgColor
                print ("index Card= \(index) selected = \(card.selectedCard)")
                if card.selectedCard {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.blue.cgColor
                }
            } else {
                button.isHidden = true
            }
        }
        
    }
    
    var cardTitles=[Card:deck.oneCard]()
    
    func getTitle(for card: Card) -> deck.oneCard {
        if cardTitles[card] == nil {
        cardTitles[card] = allDeck.remove(at: 1)
        }
        return cardTitles[card]!
        
    }
    
    func getTitleProperties (titleFor: deck.oneCard)-> NSAttributedString{
        let (alpha, color) = (titleFor.cardAlpha,titleFor.cardColor)
        var attributedColor = UIColor()
        var attributedAlpha = Float()
        var attributedWidth = Int()
        
        switch color {
        case .red:
            attributedColor = UIColor.red
        case .green:
            attributedColor = UIColor.green
        case .blue:
            attributedColor = UIColor.blue
        }
        
        switch alpha {
        case .filled:
            attributedAlpha = 1
            attributedWidth = -5
        case .outline:
            attributedAlpha = 0.5
            attributedWidth = 5
        case .stripped: attributedAlpha = 0.3
            attributedWidth = -5
        }
        
        let myAttribute:[NSAttributedString.Key : Any] = [ .foregroundColor: attributedColor.withAlphaComponent(CGFloat(attributedAlpha)), .strokeColor: attributedColor, .strokeWidth: attributedWidth ]
        let str = String(repeating: titleFor.cardFigure.rawValue, count: titleFor.cardCount.rawValue)
        let myAttrString = NSAttributedString(string: str, attributes: myAttribute)
        return myAttrString
    }
    
  /*  func checkSet(for candidateCards: [deck.oneCard]) -> Bool {
        if candidateCards.count == 3 {
            let sum1 = candidateCards.reduce(0, {$0 + $1.cardAlpha.hashValue})
             return sum1 % 3 == 0 ? true : false
        }
        return false
    }*/
    
    @IBOutlet var cardButton: [UIButton]!
    @IBAction func moreCards() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad ()
        updateViewFromModel()
    }
    
}

