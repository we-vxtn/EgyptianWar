//
//  NameSelectorController.swift
//  Egyptian War
//
//  Created by william sun on 7/18/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import UIKit

class NameSelectorController: UIViewController {

    
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(_ sender: Any) {
        let gameView  = self.storyboard!.instantiateViewController(withIdentifier: "EgyptianWarView") as! EgyptianWarViewController
        self.present(gameView, animated: true, completion: nil)
    }
    

}
