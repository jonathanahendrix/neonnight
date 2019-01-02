//
//  GameViewController.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 10/18/16.
//  Copyright (c) 2016 Neon Night Riders. All rights reserved.
//

import UIKit
import SpriteKit

enum BodyType:UInt32 {
    case playerBody = 1
    case playerArm = 2
    
    case enemyBody = 4
    case enemyArm = 8
    
}
class GameViewController: UIViewController {
 
    var currentGame: SplashScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SplashScene(size: view.bounds.size)
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.showsPhysics = false
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFit
        skView.presentScene(scene)//present scene
      
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
