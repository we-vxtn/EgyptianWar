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
    
    @IBOutlet weak var slapSoundToggle: UISwitch!
    @IBOutlet weak var dealSoundToggle: UISwitch!
    @IBOutlet weak var burnSoundToggle: UISwitch!
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Settings.slapSound = slapSoundToggle.isOn
        Settings.dealSound = dealSoundToggle.isOn
        Settings.burnSound = burnSoundToggle.isOn
        
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
