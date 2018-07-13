//
//  Stack.swift
//  Egyptian War
//
//  Created by william sun on 7/3/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import Foundation

class Stack {
    
    var cards: [Card]
    
    var slappable: Bool {
        get {
            if (cards.count-2 >= 0) && (cards[cards.count-1].rank == cards[cards.count-2].rank) {
                return true
            }
            else if (cards.count-3 >= 0) && (cards[cards.count-1].rank == cards[cards.count-3].rank) {
                return true
            }
            else {
                return false
            }
        }
    }
    
    init() {
        cards = [Card]()
    }
    
    func setFullDeck() {
        for i in 2...14 {
            cards.append(Card(rank: i, suit: "S"))
            cards.append(Card(rank: i, suit: "H"))
            cards.append(Card(rank: i, suit: "D"))
            cards.append(Card(rank: i, suit: "C"))
        }
    }
    
    func shuffleStack() {
        for _ in 1...100 {
            switchCards(index1: Int(arc4random_uniform(UInt32(cards.count))), index2: Int( arc4random_uniform(UInt32(cards.count))))
        }
    }
    
    func switchCards(index1: Int, index2: Int) {
        let temp = cards[index1]
        cards[index1] = cards[index2]
        cards[index2] = temp
    }
    
    func distributeStack() -> (stack1: Stack, stack2: Stack) {
        let stack1 = Stack()
        let stack2 = Stack()
        for index in 0..<cards.count {
            if(index%2==0){
                stack1.cards.append(cards[index])
            }
            else {
                stack2.cards.append(cards[index])
            }
        }
        return( stack1: stack1, stack2: stack2)
    }
    
    func printStack() {
        print("\(cards.count) cards:")
        for card in cards {
            print(card.name)
        }
    }
}
