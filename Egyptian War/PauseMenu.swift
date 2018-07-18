//
//  PauseMenu.swift
//  Egyptian War
//
//  Created by william sun on 7/15/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import UIKit

class PauseMenu: UIView {
    
    let borderSpacing: CGFloat = 0.075       //ratio of the pausemenu's dimension that should be the border
    let stackViewSpacing: CGFloat = 10
    let elementHeight: CGFloat = 35
    
    var stackView: UIStackView!
    var delegates: [MenuDelegate]
    
    var slapSoundToggle: UISwitch!
    var dealSoundToggle: UISwitch!
    var burnSoundToggle: UISwitch!

    override init(frame: CGRect) {
        delegates = [MenuDelegate]()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        delegates = [MenuDelegate]()
        super.init(coder: aDecoder)
    }
    
    func addMenuDelegate(_ newDelegate: MenuDelegate) {
        for addedDelegate in delegates {
            if ((addedDelegate as AnyObject) === (newDelegate as AnyObject)) { return }   //makes sure delegates arent added twice
        }
        delegates.append(newDelegate)
    }
    
    func setupSubviews() {
        if (stackView != nil) {return}      //prevents setup from being called multiple times
        
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
        pausedLabel.text = "paused"
        pausedLabel.textColor = .white
        pausedLabel.font = UIFont.boldSystemFont(ofSize: 40)
        pausedLabel.textAlignment = .center
        pausedLabel.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        stackView.addArrangedSubview(pausedLabel)
        
        // create unpause and home menu buttons
        let barStackView = UIStackView()
        barStackView.axis = .horizontal
        barStackView.distribution = .fillEqually
        barStackView.spacing = stackViewSpacing
        barStackView.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        stackView.addArrangedSubview(barStackView)
        
        let unpauseButton = UIButton()
        unpauseButton.setTitle("unpause", for: .normal)
        unpauseButton.setTitleColor(.white, for: .normal)
        unpauseButton.addTarget(self, action: #selector(unpausePressed), for: .touchUpInside)
        barStackView.addArrangedSubview(unpauseButton)
        
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
        
        // creates the settings stack
        let settingsStack = UIStackView()
        settingsStack.axis = .vertical
        settingsStack.distribution = .fill
        stackView.addArrangedSubview(settingsStack)
        
        // create the slap sound setting
        let settings1 = UIStackView()
        settings1.axis = .horizontal
        settings1.distribution = .fill
        settings1.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        settingsStack.addArrangedSubview(settings1)
        
        let label1 = UILabel()
        label1.text = "slap sound"
        settings1.addArrangedSubview(label1)
        label1.textColor = .white
        
        slapSoundToggle = UISwitch()
        slapSoundToggle.isOn = Settings.slapSound
        settings1.addArrangedSubview(slapSoundToggle)
        
        // create the deal sound setting
        let settings2 = UIStackView()
        settings2.axis = .horizontal
        settings2.distribution = .fill
        settings2.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        settingsStack.addArrangedSubview(settings2)
        
        let label2 = UILabel()
        label2.text = "deal sound"
        settings2.addArrangedSubview(label2)
        label2.textColor = .white
        
        dealSoundToggle = UISwitch()
        dealSoundToggle.isOn = Settings.dealSound
        settings2.addArrangedSubview(dealSoundToggle)
        
        // create the burn sound setting
        let settings3 = UIStackView()
        settings3.axis = .horizontal
        settings3.distribution = .fill
        settings3.heightAnchor.constraint(equalToConstant: elementHeight).isActive = true
        settingsStack.addArrangedSubview(settings3)
        
        let label3 = UILabel()
        label3.text = "burn sound"
        settings3.addArrangedSubview(label3)
        label3.textColor = .white
        
        burnSoundToggle = UISwitch()
        burnSoundToggle.isOn = Settings.burnSound
        settings3.addArrangedSubview(burnSoundToggle)
        
        // creates a space taker
        let spaceTaker = UIView()
        stackView.addArrangedSubview(spaceTaker)
        let heightConstraint = spaceTaker.heightAnchor.constraint(equalToConstant: spaceTaker.superview!.frame.height)
        heightConstraint.priority = UILayoutPriority(rawValue: 1)
        heightConstraint.isActive = true
        
    }
    
    func tearDownSubviews() {
        Settings.slapSound = slapSoundToggle.isOn
        Settings.dealSound = dealSoundToggle.isOn
        Settings.burnSound = burnSoundToggle.isOn
        
        for subview in stackView.subviews {
            subview.removeFromSuperview()
        }
        stackView = nil
    }
    
    @objc func unpausePressed() {
        for delegate in delegates {
            delegate.dismissPauseMenu?()
        }
    }
    
    @objc func homePressed() {
        for delegate in delegates {
            delegate.dismissPauseMenu?()
            delegate.homePressed()
        }
    }
    
    @objc func restartPressed() {
        for delegate in delegates {
            delegate.dismissPauseMenu?()
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
