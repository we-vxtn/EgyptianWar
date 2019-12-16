//
//  MainMenuViewController.swift
//  Egyptian War
//
//  Created by william sun on 7/12/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import UIKit
import AVFoundation

class MainMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.modalPresentationStyle = .fullScreen;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
