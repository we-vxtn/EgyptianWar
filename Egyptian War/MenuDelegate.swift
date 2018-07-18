//
//  PauseMenuDelegate.swift
//  Egyptian War
//
//  Created by william sun on 7/16/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import Foundation

@objc protocol MenuDelegate: AnyObject {
    @objc optional func dismissWinMenu()
    @objc optional func dismissPauseMenu()
    func homePressed()
    func restartPressed()
}
