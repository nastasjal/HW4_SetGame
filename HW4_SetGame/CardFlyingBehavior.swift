//
//  CardFlyingBehavior.swift
//  HW4_SetGame
//
//  Created by Анастасия Латыш on 15/12/2018.
//  Copyright © 2018 Анастасия Латыш. All rights reserved.
//

import UIKit

class CardFlyingBehavior: UIDynamicBehavior {
    
    
    lazy var collisionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
 
        //    animator.addBehavior(behavior)
        return behavior
    }()
    
    
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
      //  behavior.allowsRotation = true
      //  behavior.elasticity = 1
        behavior.resistance = 0
        //       animator.addBehavior(behavior)
        return behavior
    }()
    
    func addItem(_ item: UIDynamicItem) {
       collisionBehavior.addItem(item)
     //   itemBehavior.addItem(item)
        itemBehavior.addItem(item)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            self.collisionBehavior.removeItem(item)
            self.snap(item: item)
        }
        push(item: item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        collisionBehavior.removeItem(item)
     itemBehavior.removeItem(item)
    }
    
    var snapPoint = CGPoint()
    
    private func snap(item : UIDynamicItem){
        let snap = UISnapBehavior(item: item, snapTo: snapPoint)
        snap.damping = 1
        addChildBehavior(snap)
    }
    
    private func push (item : UIDynamicItem){
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        push.angle = -(CGFloat.pi * 2 ).arc4Random
       
        push.magnitude = CGFloat(4)
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
       // animator.addBehavior(push)
    }
    
    override init() {
        super.init()
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }

}
extension CGFloat {
    var arc4Random: CGFloat {
        switch self {
        case 1...CGFloat.greatestFiniteMagnitude:
            return CGFloat(arc4random_uniform(UInt32(self)))
        case -CGFloat.greatestFiniteMagnitude..<0:
            return -CGFloat(arc4random_uniform(UInt32(self)))
        default:
            return 0
        }
        
    }
}
