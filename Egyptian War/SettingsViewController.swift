//
//  SettingsViewController.swift
//  Egyptian War
//
//  Created by william sun on 7/12/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController {
    
    //MARK: Sound Toggles
    @IBOutlet weak var slapSoundToggle: UISwitch!
    @IBOutlet weak var dealSoundToggle: UISwitch!
    @IBOutlet weak var burnSoundToggle: UISwitch!
    
    //MARK: Game Logic Toggles
    @IBOutlet weak var sandwichSlapToggle: UISwitch!
    @IBOutlet weak var doubleSlapToggle: UISwitch!
    @IBOutlet weak var marriageSlapToggle: UISwitch!
    
    //MARK: ViewController Functions
    override func viewDidLoad() {
        if(Settings.slapSound) {
            slapSoundToggle.setOn(true, animated: true)}
        else { slapSoundToggle.setOn(false, animated: true) }
        
        if(Settings.dealSound) {
            dealSoundToggle.setOn(true, animated: true)}
        else { dealSoundToggle.setOn(false, animated: true)}
        
        if(Settings.burnSound) {
            burnSoundToggle.setOn(true, animated: true)}
        else { burnSoundToggle.setOn(false, animated: true)}
        
        if(Settings.sandwichSlap) {
            sandwichSlapToggle.setOn(true, animated: true)}
        else { sandwichSlapToggle.setOn(false, animated: true)}
        
        if(Settings.doubleSlap) {
            doubleSlapToggle.setOn(true, animated: true)}
        else { doubleSlapToggle.setOn(false, animated: true)}
        
        if(Settings.marriageSlap) {
            marriageSlapToggle.setOn(true, animated: true)}
        else { marriageSlapToggle.setOn(false, animated: true)}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Settings.slapSound = slapSoundToggle.isOn
        Settings.dealSound = dealSoundToggle.isOn
        Settings.burnSound = burnSoundToggle.isOn
        
        Settings.sandwichSlap = sandwichSlapToggle.isOn
        Settings.doubleSlap = doubleSlapToggle.isOn
        Settings.marriageSlap = marriageSlapToggle.isOn
        
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
