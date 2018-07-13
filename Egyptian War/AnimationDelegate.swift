//
//  AnimationDelegate.swift
//  Egyptian War
//
//  Created by william sun on 7/12/18.
//  Copyright © 2018 w|e.vxtn. All rights reserved.
//

import Foundation

protocol AnimationDelegate {
    func cardDealt(card: Card, fromPlayer: Int) -> Void
    func cardBurned(card: Card, fromPlayer: Int) -> Void
    func claimCards(toPlayer: Int) -> Void
}
