//
//  ViewController.swift
//  HW2_SetGame
//
//  Created by Анастасия Латыш on 27/11/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardBackstage: UIView!
    
    @IBOutlet weak var TableView: TableView! {
        didSet{
          let swipeCard = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(moreCards))
            swipeCard.direction = .down
            TableView.addGestureRecognizer(swipeCard)
            
        }
    }
    

   
    
    @IBAction func shuffleDeck(_ sender: UIRotationGestureRecognizer) {
        game.shufleDeck()
        updateViewFromModel()
    }
    
    @IBOutlet weak var AddCardsOnTheTable: UIButton!
    
    @IBAction func moreCards() {
    //    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 1, options: [.layoutSubviews, .allowAnimatedContent], animations: {self.game.deal3Card()})
        game.deal3Card()
        countVisibleCards = game.visibleCards.count
    }
    
    
    var countVisibleCards = 12 {
        didSet {
            if countVisibleCards == game.deck.count{
                AddCardsOnTheTable.isHidden = true
            }
            updateViewFromModel()
        }
    }
    
    var deckCenter = CGPoint(x: 250  , y: 530)
    lazy var deckRect = CGRect(origin: deckCenter, size: CGSize(width: 50, height: 80))
    
    
    //TODO: delete countCardsOnTheTable
    var countCardsOnTheTable: Int  = 12 //{
    /* get {
     return cardButton.count
     }*/
    //  }
    
    
    
    lazy var game = SetGame(countVisibleCard: countVisibleCards, countCardsOnTheTable: countCardsOnTheTable)

    func deal(card: CardView) {
    //    let temporaryCardView = temporaryDecs()
        card.center = deckCenter
        card.frame = deckRect
        card.isFaceUp = false
        card.alpha = 1
        
   /*     let temporaryCardView = temporaryDecs()
        print ("old = \(temporaryCardView.frame)")
        let rect = card.frame
        print ("rect = \(rect)")
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0, options: [.layoutSubviews, .allowAnimatedContent, .transitionCrossDissolve], animations: {temporaryCardView.frame = card.frame})
        
        print ("new = \(temporaryCardView.frame)")
card.alpha = 1*/
        
    }
    
    
    func updateViewFromModel() {
        if TableView.cardViewArray.count > game.allCardsOnTheTable.count {
        TableView.cardViewArray.removeLast(3)
        }
        for index in game.allCardsOnTheTable.indices {
            let card = game.allCardsOnTheTable[index]
            if TableView.cardViewArray.count <= index {  //add new card from deck
                let cardView = CardView()
                TableView.cardViewArray.append(cardView)
                addTapGestureRecognizer(for: cardView)
                updateCardView(cardView: cardView, for: card)
                deal(card: cardView)
               // cardView.alpha = 0
            } else {
            let cardView = TableView.cardViewArray[index]
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
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0, options: [.layoutSubviews, .allowAnimatedContent], animations: {cardView.alpha = 0  })
                }
                if !game.setOnTheTable && cardView.alpha == 0 {
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
    
   

    
  /*  @IBAction func moreCardss() {
        game.deal3Card()
        countVisibleCards = game.visibleCards.count
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad ()
         updateViewFromModel()
    }
    
}

