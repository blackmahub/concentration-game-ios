//
//  Concentration.swift
//  Concentration
//
//  Created by mahbub on 1/14/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import Foundation

class Concentration {
    
    var alreadyOneCardFacedUp = false
    private var alreadyOneFacedUpCardIndex: Int?
    
    var cards = [Card]()
    
    static func generateRandomIndex(cardsCount: Int, tempCards: [Card?]) -> Int {
        
        var randomIndex = Int(arc4random_uniform(UInt32(cardsCount)))
        
        while tempCards[randomIndex] != nil {
            randomIndex = Int(arc4random_uniform(UInt32(cardsCount)))
        }
        
        return randomIndex
    }
    
    init(cardsCount: Int) {

        let pairsCount = cardsCount / 2
        
        var tempCards = [Card?]()
        
        for _ in 1 ... pairsCount {
            tempCards += [nil, nil]
        }
        
        for _ in 1 ... pairsCount {
            let card = Card()
            tempCards[Concentration.generateRandomIndex(cardsCount: cardsCount, tempCards: tempCards)] = card
            tempCards[Concentration.generateRandomIndex(cardsCount: cardsCount, tempCards: tempCards)] = card
        }
        
        for index in 0 ..< cardsCount {
            cards += [tempCards[index]!]
        }
    }
    
    func chooseCard(at index: Int) -> Int? {
        
        var previousFacedUpCardIndex: Int? = nil
        
        cards[index].isFaceUp = !cards[index].isFaceUp
        
        if alreadyOneCardFacedUp {
            if index != alreadyOneFacedUpCardIndex! {
                let isMatched = Card.compareTwoCards(card1: cards[alreadyOneFacedUpCardIndex!], card2: cards[index])
                
                cards[index].isMatched = isMatched
                cards[alreadyOneFacedUpCardIndex!].isMatched = isMatched
                
                previousFacedUpCardIndex = alreadyOneFacedUpCardIndex
            }
            
            alreadyOneCardFacedUp = false
            alreadyOneFacedUpCardIndex = nil
        } else {
            alreadyOneCardFacedUp = true
            alreadyOneFacedUpCardIndex = index
        }
        
        return previousFacedUpCardIndex
    }
    
}
