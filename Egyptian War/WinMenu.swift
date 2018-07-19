//
//  WinMenu.swift
//  Egyptian War
//
//  Created by william sun on 7/18/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import UIKit

class WinMenu: UIView {
    
    let borderSpacing: CGFloat = 0.075       //ratio of the pausemenu's dimension that should be the border
    let stackViewSpacing: CGFloat = 10
    let elementHeight: CGFloat = 35
    
    var stackView: UIStackView!
    var delegates: [MenuDelegate]
    var winnerName: String
    
    init(frame: CGRect, winner: String) {
        delegates = [MenuDelegate]()
        winnerName = winner
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        delegates = [MenuDelegate]()
        winnerName = "player -1"
        super.init(coder: aDecoder)
    }
    
    func addMenuDelegate(_ newDelegate: MenuDelegate) {
        for addedDelegate in delegates {
            if ((addedDelegate as AnyObject) === (newDelegate as AnyObject)) { return }   //makes sure delegates arent added twice
        }
        delegates.append(newDelegate)
    }
    
    func setupSubviews() {
        // create the stack view
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = stackViewSpacing
        self.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: stackView.superview!.leadingAnchor, constant: borderSpacing*self.frame.width).isActive = true
        stackView.trailingAnchor.constraint(equalTo: stackView.superview!.trailingAnchor, constant: -borderSpacing*self.frame.width).isActive = true
        stackView.topAnchor.constraint(equalTo: stackView.superview!.topAnchor, constant: borderSpacing*self.frame.height).isActive = true
        stackView.bottomAnchor.constraint(equalTo: stackView.superview!.bottomAnchor, constant: -borderSpacing*self.frame.height).isActive = true
        
        // create the top label
        let pausedLabel = UILabel()
        pausedLabel.text = "Game Over"
        pausedLabel.textColor = .white
        pausedLabel.font = UIFont.boldSystemFont(ofSize: 40)
        pausedLabel.textAlignment = .center
        pausedLabel.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        stackView.addArrangedSubview(pausedLabel)
        
        // create the winner label
        let winnerLabel = UILabel()
        winnerLabel.text = "\(winnerName) has won!"
        winnerLabel.textColor = .white
        winnerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        winnerLabel.textAlignment = .center
        winnerLabel.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        stackView.addArrangedSubview(winnerLabel)
        
        // create unpause and home menu buttons
        let barStackView = UIStackView()
        barStackView.axis = .horizontal
        barStackView.distribution = .fillEqually
        barStackView.spacing = stackViewSpacing
        barStackView.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        stackView.addArrangedSubview(barStackView)
        
        let homeButton = UIButton()
        homeButton.setTitle("home", for: .normal)
        homeButton.setTitleColor(.white, for: .normal)
        homeButton.addTarget(self, action: #selector(homePressed), for: .touchUpInside)
        barStackView.addArrangedSubview(homeButton)
        
        let restartButton = UIButton()
        restartButton.setTitle("restart", for: .normal)
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.addTarget(self, action: #selector(restartPressed), for: .touchUpInside)
        barStackView.addArrangedSubview(restartButton)
        
        // creates a space taker
        let spaceTaker = UIView()
        stackView.addArrangedSubview(spaceTaker)
        let heightConstraint = spaceTaker.heightAnchor.constraint(equalToConstant: spaceTaker.superview!.frame.height)
        heightConstraint.priority = UILayoutPriority(rawValue: 1)
        heightConstraint.isActive = true
    }
    
    func tearDownSubviews() {
        for subview in stackView.subviews {
            subview.removeFromSuperview()
        }
        stackView = nil
    }
    
    @objc func homePressed() {
        for delegate in delegates {
            delegate.dismissWinMenu?()
            delegate.homePressed()
        }
    }
    
    @objc func restartPressed() {
        for delegate in delegates {
            delegate.dismissWinMenu?()
            delegate.restartPressed()
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
