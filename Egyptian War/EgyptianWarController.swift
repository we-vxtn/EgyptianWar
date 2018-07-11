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
    
    @IBOutlet weak var player1CardCount: UILabel!
    @IBOutlet weak var player2CardCount: UILabel!
    @IBOutlet weak var centerStackView: CardStackView!
    
    @IBOutlet weak var player1Deal: UIButton!
    @IBOutlet weak var player2Deal: UIButton!
    
    @IBOutlet weak var player1Controls: UIStackView!
    @IBOutlet weak var player2Controls: UIStackView!
    
    var game: GameLogic = GameLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateCardCounts()
        updateDealButtons()
        updateCardImages()
        
        // rotates the 2nd players control view by pi radians
        player2Controls.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        
        // adds gesture recognizers to CardStackView so that it can move the stack when done
        let centerSwipePlayer1Recognizer = UISwipeGestureRecognizer(target: self, action: #selector(player1Swipe))
        centerSwipePlayer1Recognizer.direction = .down
        
        let centerSwipePlayer2Recognizer = UISwipeGestureRecognizer(target: self, action: #selector(player2Swipe))
        centerSwipePlayer2Recognizer.direction = .up
        
        centerStackView.addGestureRecognizer(centerSwipePlayer1Recognizer)
        centerStackView.addGestureRecognizer(centerSwipePlayer2Recognizer)
        
        centerStackView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playerAction(_ sender: UIButton) {
        let label: String = sender.titleLabel!.text!
        
        if (label == "1Slap") {
            game.playerSlap(playerNum: 1)
        } else if (label == "2Slap") {
            game.playerSlap(playerNum: 2)
        } else if (label == "1Deal") {
            game.playerDeal(playerNum: 1)
        } else if (label == "2Deal") {
            game.playerDeal(playerNum: 2)
        }
        
        updateCardCounts()
        centerStackView.stack = game.gameDecks[0]
        updateDealButtons()
        updateCardImages()
        
        if(game.checkLoss()) {
            if(game.gameDecks[1].cards.count == 0) {
                print("player 2 wins")
            }
            else {
                print("player 1 wins")
            }
            sleep(2)
            game = GameLogic()
            updateCardImages()
            updateCardCounts()
            updateDealButtons()
        }
    }
    
    @objc func player1Swipe() {
        claimPressedBy(playerNum: 1)
    }
    
    @objc func player2Swipe() {
        claimPressedBy(playerNum: 2)
    }
    
    @objc func claimPressedBy(playerNum: Int) {
        if( playerNum == game.playerToWinDeck) {
            game.claimDeck()
            updateCardImages()
            updateCardCounts()
            updateDealButtons()
        }
    }
    
    @objc func claimPressed(_ sender: UIButton) {
        game.claimDeck()
        updateCardImages()
        updateCardCounts()
        updateDealButtons()
    }
    
    func updateCardCounts() {
        player1CardCount.text = "x\(game.gameDecks[1].cards.count)"
        player2CardCount.text = "x\(game.gameDecks[2].cards.count)"
    }
    
    func updateDealButtons() {
        if(game.buttonsShouldBeHilighted == false) {
            unhilightDealButtons()
        }
        else {
            if (game.turn%2 == 1) {         //if it is player 1's turn
                player1Deal.setImage(UIImage(named: "HilightedDealButton", in: Bundle(for: type(of: self)), compatibleWith: self.traitCollection), for: .normal)
                player2Deal.setImage(UIImage(named: "DealButton", in: Bundle(for: type(of: self)), compatibleWith: self.traitCollection), for: .normal)
            }
            else {         //if it is player 2's turn
                player2Deal.setImage(UIImage(named: "HilightedDealButton", in: Bundle(for: type(of: self)), compatibleWith: self.traitCollection), for: .normal)
                player1Deal.setImage(UIImage(named: "DealButton", in: Bundle(for: type(of: self)), compatibleWith: self.traitCollection), for: .normal)
            }
        }
    }
    
    func unhilightDealButtons() {
        player1Deal.setImage(UIImage(named: "DealButton", in: Bundle(for: type(of: self)), compatibleWith: self.traitCollection), for: .normal)
        player2Deal.setImage(UIImage(named: "DealButton", in: Bundle(for: type(of: self)), compatibleWith: self.traitCollection), for: .normal)
    }
    
    func updateCardImages() {
        centerStackView.stack = game.gameDecks[0]
        centerStackView.updateImages()
    }
}

