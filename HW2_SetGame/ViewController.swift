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
    
    // allDeck is array af all deck (81 card)
    var allDeck = deck.createDeck()
    
    lazy var game = SetGame(countCards: countCardsOnTheTable, countVisibleCard: countVisibleCards)
    
    func updateViewFromModel() {
        for index in cardButton.indices {
            var button = cardButton[index]
            var card = game.cards[index]
            if card.visibleCard {
              var currentTitle = getTitle(for: card)
                var text = getTitleProperties(titleFor: currentTitle)
              button.setAttributedTitle(text, for: .normal)
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
        var (alpha, color) = (titleFor.cardAlpha,titleFor.cardColor)
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
            attributedWidth = -8
        case .outline:
            attributedAlpha = 0.5
            attributedWidth = 8
        case .stripped: attributedAlpha = 0.3
            attributedWidth = -8
        }
        
        let myAttribute:[NSAttributedString.Key : Any] = [ .foregroundColor: attributedColor.withAlphaComponent(CGFloat(attributedAlpha)), .strokeColor: attributedColor, .strokeWidth: attributedWidth ]
      /*  let attributes:[NSAttributedString.Key : Any] = [
            .strokeColor: colors[card.color.idx],
            .strokeWidth: strokeWidths[card.fill.idx],
            .foregroundColor: colors[card.color.idx].withAlphaComponent(alphas[card.fill.idx])
        ]*/
        
        var str = String(repeating: titleFor.cardFigure.rawValue, count: titleFor.cardCount.rawValue)
        let myAttrString = NSAttributedString(string: str, attributes: myAttribute)
        return myAttrString
    }
    
    @IBOutlet var cardButton: [UIButton]!
    @IBAction func moreCards() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad ()
        updateViewFromModel()
    }
    
}

