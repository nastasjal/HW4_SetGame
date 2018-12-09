//
//  ViewController.swift
//  HW2_SetGame
//
//  Created by Анастасия Латыш on 27/11/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TableView: TableView! 
    
    @IBOutlet weak var dealCardsButton: UIButton!
    

    @IBAction func moreCards() {
        game.deal3Card()
        countVisibleCards = game.visibleCards.count
    }
    
    
    var countVisibleCards = 12 {
        didSet {
            if countVisibleCards == game.deck.count{
               // dealCardsButton.isHidden = true
            }
            updateViewFromModel()
        }
    }
    
    
    //TODO: delete countCardsOnTheTable
    var countCardsOnTheTable: Int  = 15 //{
    /* get {
     return cardButton.count
     }*/
    //  }
    
    
    //TODO: replace function to gesture TAP
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButton.index(of: sender) {
            let card = buttonTitles[cardNumber]
            game.chooseCard(for: card!)
            updateViewFromModel()
        }
    }
    
    
    lazy var game = SetGame(countVisibleCard: countVisibleCards, countCardsOnTheTable: countCardsOnTheTable)
    
    
    
    
    
 /*   func updateViewFromModel() {
        for index in cardButton.indices {
            let button = cardButton[index]
            let card = game.allCardsOnTheTable[index]
            linkCardsWithButton(for: card, with: index)
            if game.visibleCards.contains(card) {
                button.isHidden = false
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
                }
            } else {
                button.isHidden = true
                
            }
        }
    }*/
    
    func updateViewFromModel() {
        for index in game.allCardsOnTheTable.indices {
            let card = game.allCardsOnTheTable[index]
            if TableView.cardViewArray.count <= index {
                let cardView = CardView()
                TableView.cardViewArray.append(cardView)
                addTapGestureRecognizer(for: cardView)
                updateCardView(cardView: cardView, for: card)
            } else {
              //  let cardNewView = CardView()
               // TableView.cardViewArray[index] = cardNewView
            let cardView = TableView.cardViewArray[index]
                updateCardView(cardView: cardView, for: card)
                cardView.layer.borderWidth = 1.0
                cardView.layer.borderColor = nil
                if game.selectedCards.contains(card) && !game.setOnTheTable {
                    cardView.layer.borderWidth = 3.0
                    cardView.layer.borderColor = UIColor.blue.cgColor
                }
                if game.selectedCards.contains(card) && game.setOnTheTable {
                    cardView.layer.borderWidth = 3.0
                    cardView.layer.borderColor = UIColor.green.cgColor
                }
                
            }
            
            
        }
        
    }
    
    func addTapGestureRecognizer(for cardView: CardView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapCard(recognizedBy: )))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        cardView.addGestureRecognizer(tap)
    }
    
    @objc func tapCard(recognizedBy recognizer: UITapGestureRecognizer){
        if let cardView = recognizer.view as? CardView{
            let index = TableView.cardViewArray.index(of:cardView)!
            let card = game.allCardsOnTheTable[index]
            game.chooseCard(for: card)
            updateViewFromModel()
        }
        
    }
    
    func updateCardView(cardView: CardView, for card: Card){
        let addCard = cardView
        
        switch card.cardColor{
        case .blue:
            addCard.figureColor = UIColor.blue
        case .green:
            addCard.figureColor = UIColor.green
        case .red:
            addCard.figureColor = UIColor.red
        }
        switch card.cardFigure{
        case .diamond:
            addCard.figureType = .diamond
        case .round:
            addCard.figureType = .round
        case .squiggle:
            addCard.figureType = .squiggle
        }
        switch card.cardCount {
        case .one:
            addCard.figureCounts = 1
        case .two:
            addCard.figureCounts = 2
        case .three:
            addCard.figureCounts = 3
        }
        
        switch card.cardAlpha {
        case .solid:
            addCard.figureFill = .solid
        case .unfilled:
            addCard.figureFill = .unfilled
        case .stripped:
            addCard.figureFill = .stripped
        }
    }
    
    var buttonTitles=[Int:Card]()
    
  /*  func linkCardsWithButton(for card: Card, with indexButton: Int){
       if TableView.cardViewArray.count < indexButton {
            let cardView = CardView()
            TableView.cardViewArray.append(cardView)
          //  updateCardView(cardView: cardView, for: card)
        }
      //  buttonTitles.updateValue(card, forKey: indexButton)
    }*/
    
  /*  func getTitleProperties (titleFor: Card)-> NSAttributedString{
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
    */
    
    
    //TODO: remove
    @IBOutlet var cardButton: [UIButton]!
    
    @IBAction func moreCardss() {
        game.deal3Card()
        countVisibleCards = game.visibleCards.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad ()
       // TableView.cardsCountOnTheTable = 18
      //  TableView.visibleCards = game.visibleCards
         updateViewFromModel()
    }
    
}

