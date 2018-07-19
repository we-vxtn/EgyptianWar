//
//  NameSelectorController.swift
//  Egyptian War
//
//  Created by william sun on 7/18/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import UIKit

class NameSelectorController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        player1TextField.delegate = self
        player2TextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed() {
        let gameView  = self.storyboard!.instantiateViewController(withIdentifier: "EgyptianWarView") as! EgyptianWarViewController
        self.present(gameView, animated: true, completion: nil)
        gameView.setNames(player1: player1TextField.text, player2: player2TextField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == player2TextField {
            player1TextField.becomeFirstResponder()
        }
        else {
        textField.resignFirstResponder()
        donePressed()
        }
        return true
    }
    

}
