//
//  Stack.swift
//  Egyptian War
//
//  Created by william sun on 7/3/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import UIKit

@IBDesignable class CardStackView: UIStackView {
    
    //MARK: Logic related Variables
    var stack: Stack!
    var cardViews: [UIImageView]!       //0 is the bottom, count-1 is top
    
    //MARK: Display parameter related Variables
    var numberOfCards: Int = 5
    var cardOffset: Int = 30 {
        didSet {
            setImageConstraints()
            updateImages()
        }
    }
    
    //MARK: Variables needed for animation
    var topCardFrame: CGRect {          // returns the top card's frame
        get {
            return cardViews[cardViews.count-1].superview!.convert(cardViews[cardViews.count-1].frame, to: nil)
        }
    }
    var bottomCardFrame: CGRect {       // returns the bottom card's frame
        get {
            if (stack.cards.count < numberOfCards) {
                return cardViews[0].superview!.convert(cardViews[cardViews.count - stack.cards.count].frame, to: nil)
            }
            else {
                return cardViews[0].superview!.convert(cardViews[0].frame, to: nil)
            }
        }
    }
    var cardFrames: [CGRect] {
        get {
            var frames: [CGRect] = [CGRect]()
            for cardView in cardViews {
                frames.append(cardView.superview!.convert(cardView.frame, to: nil))
            }
            return frames
        }
    }
    
    //MARK: Initializers
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
    
    //MARK: Update Methods
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
            cardView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }
    
    func updateImages() {
        for index in -numberOfCards..<0 {
            // gets the card view
            let cardView = cardViews[numberOfCards+index]
                
            // sets the image of the card, or hides the card
            if(stack.cards.count+index >= 0) {
                //sets the image and unhides the view
                cardView.isHidden = false
                let cardName = stack.cards[stack.cards.count + index].name
                cardView.image = UIImage(named: cardName, in: Bundle(for: type(of: self)), compatibleWith: self.traitCollection)
            }
            else {
                cardView.isHidden = true
            }
        }
    }
    
}
