//
//  SplashScene.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 1/14/17.
//  Copyright © 2017 Neon Night Riders. All rights reserved.
//

import SpriteKit

class SplashScene: SKScene {
    
    let splashVideo = SKVideoNode(fileNamed: "NNRA.mp4")
   var touchLocation = CGPoint(x: 0, y: 0)
    
    override func didMove(to view: SKView) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "sound")
        userDefaults.set(true, forKey: "music")
        userDefaults.synchronize()
        splashVideo.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        splashVideo.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(splashVideo)
        splashVideo.play()
    
        let transition = SKTransition.crossFade(withDuration: 0.3)
        transition.pausesOutgoingScene = true
        transition.pausesIncomingScene = false
        let wait2 = SKAction.wait(forDuration: 5.0)
        let nextScene = MenuScene(size: scene!.size)
        nextScene.scaleMode = .aspectFill
        let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: transition)})
        self.run(SKAction.sequence([wait2,changeScene]))
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        //Choose the first touch
        touchLocation = touch.location(in: self)
        let transition = SKTransition.crossFade(withDuration: 0.3)
        transition.pausesOutgoingScene = true
        transition.pausesIncomingScene = false
        //Determine which button was pressed
        if self.contains(touchLocation) {
            splashVideo.pause()
            splashVideo.removeFromParent()
            let nextScene = MenuScene(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene, transition: transition)
        }
    }
    
}
