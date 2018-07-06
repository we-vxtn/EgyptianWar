//
//  Stack.swift
//  Egyptian War
//
//  Created by william sun on 7/3/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import UIKit

@IBDesignable class CardStackView: UIStackView {
    
    var stack: Stack!
    var cardViews: [UIImageView]!
    
    var numberOfCards: Int = 5
    var cardOffset: Int = 30 {
        didSet {
            setImageConstraints()
            updateImages()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // initializes the stack
        stack = Stack()
        
        // initializes the cardViews
        cardViews = [UIImageView]()
        for _ in 0..<numberOfCards {
            cardViews.append(UIImageView())
        }
        cardOffset = Int(0.1*self.frame.width)
        
        // updates the cardViews locations and images
        setImageConstraints()
        updateImages()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // initializes the stack
        stack = Stack()
        
        // initializes the cardViews
        cardViews = [UIImageView]()
        for _ in 0..<self.numberOfCards {
            cardViews.append(UIImageView())
        }
        cardOffset = Int(0.1*self.frame.width)
        
        // updates the cardViews locations and images
        setImageConstraints()
        updateImages()
    }
    
    func setStack(_ stack: Stack) {
        self.stack = stack
        updateImages()
    }
    
    func setImageConstraints() {
        for index in -numberOfCards..<0 {
            // gets the card view
            let cardView = cardViews[numberOfCards+index]
            
            // programmatically sets the constraints of the card
            cardView.translatesAutoresizingMaskIntoConstraints = false
            cardView.contentMode = .scaleAspectFit
            addSubview(cardView)
            cardView.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: CGFloat(index*cardOffset)).isActive = true
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(index*cardOffset)).isActive = true
            cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
        
    }
    
    func updateImages() {
        for index in -numberOfCards..<0 {
            // gets the card view
            let cardView = cardViews[numberOfCards+index]
                
            // sets the image of the card and shifts the view, or hides the card
            if(stack.cards.count+index >= 0) {
                //sets the image and unhides the view
                cardView.isHidden = false
                let cardName = stack.cards[stack.cards.count + index].name
                cardView.image = UIImage(named: cardName, in: Bundle(for: type(of: self)), compatibleWith: self.traitCollection)
                
                /*
                print(stack.cardFromPlayer)
                //shifts the y position of the view
                if(stack.cardFromPlayer[stack.cardFromPlayer.count + index]==1) {
                    cardView.topAnchor.constraint(equalTo: self.topAnchor).isActive = false
                    cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = false
                    cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                    print("constraint1 is in place")
                }
                else if(stack.cardFromPlayer[stack.cardFromPlayer.count + index]==2) {
                    cardView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                    cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = false
                    cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = false
                    print("constraint2 is in place")
                }
                else {
                    cardView.topAnchor.constraint(equalTo: self.topAnchor).isActive = false
                    cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                    cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = false
                    print("constraint3 is in place")
                }*/
            }
            else {
                cardView.isHidden = true
            }
        }
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
