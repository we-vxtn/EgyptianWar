//
//  Card.swift
//  Egyptian War
//
//  Created by william sun on 7/3/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import Foundation

class Card {
    var rank: Int
    var suit: Character
    var fromPlayer: Int?        //1 is player 1, 2 is player 2
    
    var name: String {
        get {
            return "\(rank)\(suit)"
        }
    }
    
    init(rank: Int, suit: Character) {
        self.rank = rank
        self.suit = suit
    }
    
    func equals(other: Card) -> Bool {
        return self.rank == other.rank
    }
    
    func setFromPlayer(_ player: Int) {
        fromPlayer = player
    }
}

