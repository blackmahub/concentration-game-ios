//
//  Card.swift
//  Concentration
//
//  Created by mahbub on 1/14/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import Foundation

struct Card {
    
    var identifier: Int
    
    var isFaceUp = false
    var isMatched = false
    
    static private var identifierCounter = 0
    
    static private func generateUniqueIdentifier() -> Int {
        identifierCounter += 1
        return identifierCounter
    }
    
    static func compareTwoCards(card1: Card, card2: Card) -> Bool {
        return card1.identifier == card2.identifier
    }
    
    init() {
        identifier = Card.generateUniqueIdentifier()
    }
    
}
