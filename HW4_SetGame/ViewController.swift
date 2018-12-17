//
//  ViewController.swift
//  HW2_SetGame
//
//  Created by Анастасия Латыш on 27/11/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var deckLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var addMoreButton: UIButton!
    @IBOutlet weak var allTableView: Table! {
        didSet{
          let swipeCard = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(moreCards))
            swipeCard.direction = .down
            allTableView.addGestureRecognizer(swipeCard)
            
        }
    }
    

   
    
    @IBAction func shuffleDeck(_ sender: UIRotationGestureRecognizer) {
        game.shufleDeck()
        updateViewFromModel()
    }
    
    
    @IBAction func moreCards() {
        game.deal3Card()
        updateViewFromModel()
        deckLabel.text = "Deck: \(game.deck.count)"
    }
    
    
    var countVisibleCards = 12
    
    var deckCenter = CGPoint(x: 250  , y: 530)
    lazy var deckRect = CGRect(origin: deckCenter, size: CGSize(width: 50, height: 80))
    
    

    
    var setsCount = 0
    
    
    lazy var game = SetGame(countVisibleCard: countVisibleCards, countCardsOnTheTable: countVisibleCards)

    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var cardBehavior = CardFlyingBehavior(in: animator)
    
    func deal(card: CardView) {   //func to move card with alpha = 0 to deck
        card.center = deckCenter
        card.frame = deckRect
        card.isFaceUp = false
        card.alpha = 1
        
    }
    
    func flyaway(cardView: CardView, for card: Card) {
        let tempCard = CardView()
        updateCardView(cardView: tempCard, for: card)
        tempCard.center = cardView.center
        tempCard.frame = cardView.frame
        tempCard.alpha = 1
        tempCard.isFaceUp = true
        view.addSubview(tempCard)
    }
    
    
    func updateViewFromModel() {
        if allTableView.cardViewArray.count > game.allCardsOnTheTable.count {
         let neeedRemoveCardCount = allTableView.cardViewArray.count - game.allCardsOnTheTable.count
        allTableView.visibleAll()
        allTableView.cardViewArray.removeLast(neeedRemoveCardCount)
        }
        for index in game.allCardsOnTheTable.indices {
            let card = game.allCardsOnTheTable[index]
            if allTableView.cardViewArray.count <= index {  //add new card from deck
                let cardView = CardView()
                allTableView.cardViewArray.append(cardView)
                addTapGestureRecognizer(for: cardView)
                updateCardView(cardView: cardView, for: card)
                deal(card: cardView)
            } else {
            let cardView = allTableView.cardViewArray[index]
                updateCardView(cardView: cardView, for: card)
                cardView.layer.borderWidth = 1.0
                cardView.layer.borderColor = nil
                if game.selectedCards.contains(card) && !game.setOnTheTable { //select choosen cards to blue bordercolor
                    cardView.layer.borderWidth = 3.0
                    cardView.layer.borderColor = UIColor.blue.cgColor
                }
                if game.selectedCards.contains(card) && game.setOnTheTable { //selectSET cards to green bordercolor
                    cardView.layer.borderWidth = 3.0
                    cardView.layer.borderColor = UIColor.green.cgColor
                  //  flyaway(cardView: cardView, for: card)
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0, options: [ .allowAnimatedContent], animations: {cardView.alpha = 0  })
                }
                if !game.setOnTheTable && cardView.alpha == 0 && game.deck.count > 0 {
                    deal(card: cardView)
                  //  UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0, options: [.layoutSubviews, .allowAnimatedContent], animations: {cardView.alpha = 1 })
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
            let index = allTableView.cardViewArray.index(of:cardView)!
            let card = game.allCardsOnTheTable[index]
            game.chooseCard(for: card)
            if game.setOnTheTable {
                setsCount += 1
                setsLabel.text = "Sets: \(setsCount)"
            }
            updateViewFromModel()
            deckLabel.text = "Deck: \(game.deck.count)"
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
    
    override func viewDidLoad() {
        super.viewDidLoad ()
         updateViewFromModel()
    }
    
}

