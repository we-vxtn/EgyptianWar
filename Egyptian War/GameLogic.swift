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
    
    var playerToWinDeck: Int
    var stackSlapped: Bool
    
    var buttonsShouldBeHilighted: Bool {     //while no player should claim the deck, the buttons should be hilighted
        get {
            return (playerToWinDeck == 0)
        }
    }
    
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
        
        playerToWinDeck = 0
        stackSlapped = false
    }
    
    
    func playerDeal(playerNum: Int) {
        if (turn%2 == playerNum%2) && (playerToWinDeck == 0) {          // if it is playerNum's turn
            //Should play sound
            SoundController.cardDeal()
            

 
 
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
                    playerToWinDeck = 2
                }
                else if ( playerNum == 2 ) {       //if player 2 dealt the last number card
                   playerToWinDeck = 1
                }
            }
        }
        else {                                // if it is not playerNum's turn
            //burns a card
            burnCard(playerNum)
        }
    }
    
    func playerSlap(playerNum: Int) {
        SoundController.slap()
        if (gameDecks[0].slappable) {       //if the slap was correct
            SoundController.slap()
            if(!stackSlapped) {                 //if stack hasn't been slapped before
                playerToWinDeck = playerNum
                stackSlapped = true
            }
        }
        else {                              //if the slap was wrong
            //burns a card
            burnCard(playerNum)
        }
    }
    
    func claimDeck() {
        if( playerToWinDeck != 0 ) {
            print("cards go to \(playerToWinDeck)")
            gameDecks[playerToWinDeck].cards.append(contentsOf: gameDecks[0].cards)
            gameDecks[0].cards.removeAll()
            
            turn = playerToWinDeck                //sets the turn to the one who won the stack
            
            faceCardDealt = false
            cardsDealtThisTurn = 0
            cardsToNextTurn = 1
            playerToWinDeck = 0
            stackSlapped = false
        }
    }
    
    func burnCard(_ playerNum: Int){
        // plays the burn sound
        SoundController.cardBurn()
        
        // moves the card over
        let burntCard = gameDecks[playerNum].cards.remove(at: 0)
        gameDecks[0].cards.insert(burntCard, at: 0)
        gameDecks[0].cardFromPlayer.insert(playerNum, at: 0)
        print("player \(playerNum) burnt a \(burntCard.name)")
    }
    
    func checkLoss() -> Bool {
        return (gameDecks[1].cards.count == 0 || gameDecks[2].cards.count==0)
    }
}
