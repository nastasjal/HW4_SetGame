//
//  ViewController.swift
//  HW2_SetGame
//
//  Created by Анастасия Латыш on 27/11/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var countVisibleCards = 22 {
        didSet {
           // (cardButton.count > countVisibleCards) ? cardButton.count : countVisibleCards
            updateViewFromModel()
        }
    }
 
    var symbols:[String] = ["▲", "●", "■"]
    
    var countCardsOnTheTable: Int {
        get {
            return cardButton.count
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
       if let cardNumber = cardButton.index(of: sender) {
        let card = buttonTitles[cardNumber]
        game.chooseCard(for: card!)
        updateViewFromModel()
        }
    }
    
    
    lazy var game = SetGame(countVisibleCard: countVisibleCards, countCardsOnTheTable: countCardsOnTheTable)
    
    func updateViewFromModel() {
        for index in cardButton.indices {
            let button = cardButton[index]
            let card = game.allCardsOnTheTable[index]
            linkCardsWithButton(for: card, with: index)
            if game.visibleCards.contains(card) {
                let text = getTitleProperties(titleFor: card)
                button.setAttributedTitle(text, for: .normal)
                button.layer.borderWidth = 1.0
                button.layer.borderColor = nil
                if game.selectedCards.contains(card) && !game.setOnTheTable {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.blue.cgColor
                }
                if game.selectedCards.contains(card) && game.setOnTheTable {
                    button.layer.borderWidth = 3.0
                    button.layer.borderColor = UIColor.green.cgColor
                 //   buttonTitles.removeValue(forKey: index)
                 //   game.allCardsOnTheTable[index] = game.deck.remove(at: 1)
                }
            } else {
                button.isHidden = true
            }
   }
        if game.setOnTheTable {
            game.selectedCards.removeAll()
            game.setOnTheTable = false
        }
    }
    
    var buttonTitles=[Int:Card]()
    
    func linkCardsWithButton(for card: Card, with indexButton: Int){
        buttonTitles.updateValue(card, forKey: indexButton)
      /* if buttonTitles[indexButton] != card {
        buttonTitles[indexButton] = card
        }*/
    }
    
    func getTitleProperties (titleFor: Card)-> NSAttributedString{
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
        let str = String(repeating: symbols[titleFor.cardFigure.rawValue - 1], count: titleFor.cardCount.rawValue)
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

