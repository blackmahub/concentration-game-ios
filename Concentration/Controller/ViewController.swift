//
//  ViewController.swift
//  Concentration
//
//  Created by mahbub on 1/13/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = Concentration(cardsCount: cardButtons.count)
    private lazy var matchCount = cardButtons.count
    
    private var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    private var emojis = ["👻", "🎃", "🦇", "🦉", "🍭", "🍬", "👹", "💀", "☃️", "🍪", "🎭", "🍇", "🍓", "🥑", "🧀", "🦅", "🦋", "🕷", "🐲", "🐅"]
    private var emojiCards = [Int : String]()
    
    private func updatePreCardsIfAny() {
        
        for (index, card) in game.cards.enumerated() {
            
            if card.isMatched {
                
                cardButtons[index].setTitle(nil, for: UIControlState.normal)
                cardButtons[index].backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
                cardButtons[index].isEnabled = false
            
            } else if !game.alreadyOneCardFacedUp {
                
                game.cards[index].isFaceUp = false
                cardButtons[index].isEnabled = true
                updateCardView(of: index, previousCardIndex: nil)
            }
        }
    }
    
    private func getEmoji(at index: Int) -> String {
        
        if let emoji = emojiCards[game.cards[index].identifier] {
             return emoji
        }
        
        let randomEmoji = emojis.remove(at: Int(arc4random_uniform(UInt32(emojis.count))))
        emojiCards[game.cards[index].identifier] = randomEmoji
        return randomEmoji
    }
    
    private func updateCardView(of index: Int, previousCardIndex preIdx: Int?) {
        
        if (game.cards[index].isFaceUp) {
            
            cardButtons[index].setTitle(getEmoji(at: index), for: UIControlState.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        } else {
        
            cardButtons[index].setTitle(nil, for: UIControlState.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        
        }
        
        if let preIdx = preIdx {
            
            cardButtons[index].isEnabled = false
            cardButtons[preIdx].isEnabled = false
        }
    }
    
    private func updateMatchCounter(for index: Int) {
        
        if game.cards[index].isMatched {
            
            matchCount -= 2
        }
    }
    
    private func checkGameOver(at index: Int, and pairedIndex: Int? ) {
        
        if 0 == matchCount {
            
            flipCountLabel.text = "Flips: 0"
            flipCountLabel.isHidden = true
            
            gameOverLabel.isHidden = false
            self.view.bringSubview(toFront: gameOverLabel)
            
            totalFlipsLabel.text = "Total Flips: \(flipCount)"
            totalFlipsLabel.isHidden = false
            
            var successRate = Double(cardButtons.count) / Double(flipCount) * 100.00
            successRate = (successRate * 100.00).rounded() / 100.00
            successRateLabel.text = "Success Rate: \(successRate)%"
            successRateLabel.isHidden = false
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var totalFlipsLabel: UILabel!
    @IBOutlet weak var successRateLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        flipCount = flipCount + 1
        
        updatePreCardsIfAny()
        
        if let cardNumber = cardButtons.index(of: sender) {
            
            let previousCardIndex = game.chooseCard(at: cardNumber)
            updateCardView(of: cardNumber, previousCardIndex: previousCardIndex)
            updateMatchCounter(for: cardNumber)
            checkGameOver(at: cardNumber, and: previousCardIndex)
            
        } else {
            print("Card is not added in the Buttons List")
        }
    }
    
}
