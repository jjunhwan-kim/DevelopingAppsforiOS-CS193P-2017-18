//
//  ViewController.swift
//  PlayingCard
//
//  Created by 김준환 on 2020/10/17.
//

import UIKit

class ViewController: UIViewController {
    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }
}

