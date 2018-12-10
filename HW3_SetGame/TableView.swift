//
//  TableView.swift
//  HW3_SetGame
//
//  Created by Анастасия Латыш on 05/12/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class TableView: UIView {
    
    
    var cardViewArray = [CardView]()
    {
        willSet { removeSubviews() }
        didSet { addSubviews()
            setNeedsDisplay()
            setNeedsLayout() }
    }
   

    
    override func draw(_ rect: CGRect) {
        var grid = Grid(layout: Grid.Layout.aspectRatio(0.7),
                        frame: bounds)
        grid.cellCount = cardViewArray.count
        for index in 0..<cardViewArray.count {
            cardViewArray[index].frame =  grid[index]!
        }
    }
    
    
    func updateView(){
        removeSubviews()
        addSubviews()
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    
    
    private func removeSubviews() {
        for card in cardViewArray {
            card.removeFromSuperview()
        }
        print("remove all subviews")
        print (subviews)
    }
    
    private func addSubviews() {
        for card in cardViewArray {
            addSubview(card)
        }
        print ("add all subviews")
        print (subviews)
    }
   
    
    
}

