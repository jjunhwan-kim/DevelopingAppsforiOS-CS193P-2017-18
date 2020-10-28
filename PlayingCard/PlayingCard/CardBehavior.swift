//
//  CardBehavior.swift
//  PlayingCard
//
//  Created by 김준환 on 2020/10/23.
//

import UIKit

class CardBehavior: UIDynamicBehavior {
    lazy var collisionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true   // make boundaries of reference view
        return behavior
    }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = false
        behavior.elasticity = 1.0 // 탄성, 충돌로 인해 에너지를 얻거나 잃지 않도록 함.
        behavior.resistance = 0
        return behavior
    }()
    
    private func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        if let referenceBounds = dynamicAnimator?.referenceView?.bounds {
            let center = CGPoint(x: referenceBounds.midX, y: referenceBounds.midY)
            switch (item.center.x, item.center.y) {
            case let (x, y) where x < center.x && y < center.y:
                push.angle = CGFloat.random(in: 0...(CGFloat.pi/2))
            case let (x, y) where x > center.x && y < center.y:
                push.angle = CGFloat.pi - CGFloat.random(in: 0...(CGFloat.pi/2))
            case let (x, y) where x < center.x && y > center.y:
                push.angle = -CGFloat.random(in: 0...(CGFloat.pi/2))
            case let (x, y) where x > center.x && y > center.y:
                push.angle = CGFloat.pi + CGFloat.random(in: 0...(CGFloat.pi/2))
            default:
                push.angle = CGFloat.random(in: 0...2*CGFloat.pi)
            }
        }
        push.magnitude = CGFloat(1.0) + CGFloat.random(in: 0...2.0)
        push.action = { [unowned push, weak self] in   // To remove memory cycle, unowned is necessary
            self?.removeChildBehavior(push) // once pushed, it is removed
        }
        addChildBehavior(push)
    }
    
    func addItem(_ item: UIDynamicItem) {
        collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
        push(item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
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
