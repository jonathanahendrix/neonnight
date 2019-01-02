//
//  Credits.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 1/10/18.
//  Copyright © 2018 Neon Night Riders. All rights reserved.
//

import SpriteKit

class CreditsScene: SKScene {
    
    let splashVideo = SKVideoNode(fileNamed: "Credits.mp4")
    var touchLocation = CGPoint(x: 0, y: 0)
    var touchCount = 1;
    
    
    
    override func didMove(to view: SKView) {
        
        
        
        splashVideo.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        splashVideo.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(splashVideo)
        splashVideo.play()
        
        splashVideo.zPosition = 1
        let transition = SKTransition.crossFade(withDuration: 1.15)
        transition.pausesIncomingScene = true
        transition.pausesOutgoingScene = true
        let wait2 = SKAction.wait(forDuration: 69.0)
        let nextScene = InGameMenuScene(size: scene!.size)
        nextScene.scaleMode = .aspectFill
        let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: transition)})
        self.run(SKAction.sequence([wait2,changeScene]))
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        touchCount += 1
        //Choose the first touch
        touchLocation = touch.location(in: self)
              //Determine which button was pressed
        if splashVideo.contains(touchLocation) {
            splashVideo.pause()
            transitionScene()
            
        }
    }
    func transitionScene()  {
        let nextScene = InGameMenuScene(size: scene!.size)
        nextScene.scaleMode = .aspectFill
        let transition = SKTransition.crossFade(withDuration: 1.5)
        transition.pausesIncomingScene = false
        transition.pausesOutgoingScene = true
        splashVideo.removeFromParent()
        scene?.view?.presentScene(nextScene,transition: transition)
    }
    
    
}
