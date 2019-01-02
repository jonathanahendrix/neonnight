//
//  GameControls.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 12/16/17.
//  Copyright © 2017 Neon Night Riders. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameControls: SKSpriteNode {
//Variables
    var leftPunchButton = SKSpriteNode(imageNamed: "btnPunch")
    var rightPunchButton = SKSpriteNode(imageNamed: "btnPunch")
    var rightDodgeButton = SKSpriteNode(imageNamed: "btnRightDodge")
    var leftDodgeButton = SKSpriteNode(imageNamed: "btnLeftDodge")
    var exitButton = SKSpriteNode(imageNamed:"btnExit")
    var pauseButton = SKSpriteNode(imageNamed:"btnPause")
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
