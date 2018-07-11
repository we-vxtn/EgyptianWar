//
//  ViewController.swift
//  Egyptian War
//
//  Created by william sun on 7/3/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import UIKit
import AVFoundation

class EgyptianWarViewController: UIViewController {
    
    //MARK: IBOutlet Variables
    @IBOutlet weak var player1CardStack: UIStackView!
    @IBOutlet weak var player2CardStack: UIStackView!
    
    @IBOutlet weak var player1CardCount: UILabel!
    @IBOutlet weak var player2CardCount: UILabel!
    
    @IBOutlet weak var player1CardBack: UIImageView!
    @IBOutlet weak var player2CardBack: UIImageView!
    
    @IBOutlet weak var centerStackView: CardStackView!
    
    @IBOutlet weak var player1Controls: UIStackView!
    @IBOutlet weak var player2Controls: UIStackView!
    
    //MARK: Variables
    var game: GameLogic!
    
    //MARK: UIViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newGame()
        
        // rotates the 2nd players control view by pi radians
        player2Controls.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        
        // adds swiping gesture recognizers to centerStackView so that it can move the stack when done
        let centerSwipePlayer1Recognizer = UISwipeGestureRecognizer(target: self, action: #selector(player1Claim))
        centerSwipePlayer1Recognizer.direction = .down
        
        let centerSwipePlayer2Recognizer = UISwipeGestureRecognizer(target: self, action: #selector(player2Claim))
        centerSwipePlayer2Recognizer.direction = .up
        
        centerStackView.addGestureRecognizer(centerSwipePlayer1Recognizer)
        centerStackView.addGestureRecognizer(centerSwipePlayer2Recognizer)
        
        centerStackView.isUserInteractionEnabled = true
        
        // add gesture recognizers to the player stacks so that it will deal
        let player1DealRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(player1Deal))
        player1DealRecognizer.direction = .up
        player1CardStack.addGestureRecognizer(player1DealRecognizer)
        player1CardStack.isUserInteractionEnabled = true
        
        let player2DealRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(player2Deal))
        player2DealRecognizer.direction = .up
        player2CardStack.addGestureRecognizer(player2DealRecognizer)
        player2CardStack.isUserInteractionEnabled = true
        
        // add tap gesture recognizer to centerStackView so that it can detect slaps
        let slapRecognizer = UITapGestureRecognizer(target: self, action: #selector(slap(sender:)))
        centerStackView.addGestureRecognizer(slapRecognizer)
        centerStackView.isUserInteractionEnabled = true                 //this line is redundant, it's already true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Deal Functions
    @objc func player1Deal() {
        playerDeal(playerNum: 1)
    }
    
    @objc func player2Deal() {
        playerDeal(playerNum: 2)
    }
    
    func playerDeal(playerNum: Int){
        game.playerDeal(playerNum: playerNum)
        updateView()
        checkLoss()
    }
    
    //MARK: Slap Functions
    @objc func slap(sender: UITapGestureRecognizer) {
        print("center tapped")
    }
    
    @IBAction func playerAction(_ sender: UIButton) {
        let label: String = sender.titleLabel!.text!
        
        if (label == "1Slap") {
            game.playerSlap(playerNum: 1)
        } else if (label == "2Slap") {
            game.playerSlap(playerNum: 2)
        }
        
        updateView()
        checkLoss()
    }
    
    //MARK: Claim Functions
    @objc func player1Claim() {
        claimedBy(playerNum: 1)
    }
    
    @objc func player2Claim() {
        claimedBy(playerNum: 2)
    }
    
    func claimedBy(playerNum: Int) {
        if( playerNum == game.playerToWinDeck) {
            game.claimDeck()
            updateView()
        }
    }
    
    //MARK: Update State Functions
    func updateView() {
        updateCardCounts()
        updateStackImages()
        updateCardImages()
    }
    
    func updateCardCounts() {
        //updates card counts
        player1CardCount.text = "x\(game.gameDecks[1].cards.count)"
        player2CardCount.text = "x\(game.gameDecks[2].cards.count)"
    }
    
    func updateStackImages() {
        //changes the images based on who's turn it is to deal
        let unhilightedBack = UIImage(named: "back")
        let hilightedBack = UIImage(named: "backHilighted")
        
        if(game.buttonsShouldBeHilighted == false) {    //if the stack should be claimed, and no cards should be dealt
            player1CardBack.image = unhilightedBack
            player2CardBack.image = unhilightedBack
        }
        else {
            if (game.turn%2 == 1) {         //if it is player 1's turn
                player1CardBack.image = hilightedBack
                player2CardBack.image = unhilightedBack
            }
            else {         //if it is player 2's turn
                player1CardBack.image = unhilightedBack
                player2CardBack.image = hilightedBack
            }
        }
    }
    
    func updateCardImages() {
        centerStackView.stack = game.gameDecks[0]
        centerStackView.updateImages()
    }
    
    func checkLoss() {
        if(game.checkLoss()) {
            if(game.gameDecks[1].cards.count == 0) {
                print("player 2 wins")
            }
            else {
                print("player 1 wins")
            }
            sleep(2)
            newGame()
        }
    }
    
    func newGame() {
        game = GameLogic()
        centerStackView.stack = game.gameDecks[0]
        updateView()
    }
}

