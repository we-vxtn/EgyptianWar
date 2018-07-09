//
//  GameLogic.swift
//  Egyptian War
//
//  Created by william sun on 7/3/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import Foundation

class GameLogic {
    
    var gameDecks: [Stack]!
    
    var turn: Int
    var cardsToNextTurn: Int
    var cardsDealtThisTurn: Int
    var faceCardDealt: Bool
    
    init() {
        let fullDeck = Stack()
        fullDeck.setFullDeck()
        fullDeck.shuffleStack()
        let stacks = fullDeck.distributeStack()
        
        gameDecks = [Stack]()
        
        gameDecks.append(Stack())             //this stack is center deck
        gameDecks.append(stacks.stack1)
        gameDecks.append(stacks.stack2)
        
        turn = 1
        cardsToNextTurn = 1
        cardsDealtThisTurn = 0
        faceCardDealt = false
    }
    
    //
    func playerDeal(playerNum: Int) {
        if (turn%2 == playerNum%2) {          // if it is playerNum's turn
            let dealtCard = gameDecks[playerNum].cards.remove(at: 0)
            gameDecks[0].cards.append(dealtCard)
            gameDecks[0].cardFromPlayer.append(playerNum)
            
            cardsDealtThisTurn += 1
            
            if(dealtCard.rank > 10) {                   //if a face card is played
                turn += 1
                cardsDealtThisTurn = 0
                cardsToNextTurn = dealtCard.rank - 10
                faceCardDealt = true
            }
            else if(!faceCardDealt && cardsDealtThisTurn >= cardsToNextTurn) {  //if no more cards need to be dealt, and there is no face card dealt this round
                turn += 1
                cardsDealtThisTurn = 0
            }
            else if(faceCardDealt && cardsDealtThisTurn >= cardsToNextTurn) {   //if no more cards need to be dealt, and there was a face card dealt this round
                if( playerNum == 1 ) {         //if player 1 dealt the last number card
                    gameDecks[2].cards.append(contentsOf: gameDecks[0].cards)
                    turn = 2
                }
                else if ( playerNum == 2 ) {       //if player 2 dealt the last number card
                    gameDecks[1].cards.append(contentsOf: gameDecks[0].cards)
                    turn = 1
                }
                gameDecks[0].cards.removeAll()
                faceCardDealt = false
                cardsDealtThisTurn = 0
                cardsToNextTurn = 1
            }
        }
        else {                                // if it is not playerNum's turn
            //burns a card
            let burntCard = gameDecks[playerNum].cards.remove(at: 0)
            gameDecks[0].cards.insert(burntCard, at: 0)
            gameDecks[0].cardFromPlayer.insert(playerNum, at: 0)
            print("player \(playerNum) burnt a \(burntCard.name)")
        }
    }
    
    //I'll be adding sound to this (ethan)
    func playerSlap(playerNum: Int) {
        if (gameDecks[0].slappable) {       //if the slap was correct
            gameDecks[playerNum].cards.append(contentsOf: gameDecks[0].cards)
            gameDecks[0].cards.removeAll()
            
            turn = playerNum                //sets the turn to the one who won the stack
            faceCardDealt = false
            cardsDealtThisTurn = 0
            cardsToNextTurn = 1
        }
        else {                              //if the slap was wrong
            //burns a card
            let burntCard = gameDecks[playerNum].cards.remove(at: 0)
            gameDecks[0].cards.insert(burntCard, at: 0)
            gameDecks[0].cardFromPlayer.insert(playerNum, at: 0)
            print("player \(playerNum) burnt a \(burntCard.name)")
        }
    }
    
    func checkLoss() -> Bool {
        return (gameDecks[1].cards.count == 0 || gameDecks[2].cards.count==0)
    }
}
