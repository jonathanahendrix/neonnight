//
//  BeginningStoryScene2.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 3/14/17.
//  Copyright © 2017 Neon Night Riders. All rights reserved.
//

import SpriteKit

class BeginningStoryScene2: SKScene {
    let splashVideo = SKVideoNode(fileNamed: "BS2-Low.mp4")
    var touchLocation = CGPoint(x: 0, y: 0)
    var touchCount = 1;
    var gameBackgroundMusic: SKAudioNode = SKAudioNode(fileNamed:"intro.mp3")
    override func didMove(to view: SKView) {
        
        addChild(gameBackgroundMusic)
  

        splashVideo.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        splashVideo.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(splashVideo)
        splashVideo.play()
        let transition = SKTransition.crossFade(withDuration: 1.5)
        transition.pausesIncomingScene = false
        transition.pausesOutgoingScene = true
        let wait2 = SKAction.wait(forDuration: 4.0)
        let nextScene = BeginningStoryScene3(size: scene!.size)
        nextScene.scaleMode = .aspectFill
        let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: transition)})
        self.run(SKAction.sequence([wait2,changeScene]))
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        //Choose the first touch
        touchLocation = touch.location(in: self)
        let transition = SKTransition.crossFade(withDuration: 1.5)
        transition.pausesIncomingScene = false
        transition.pausesOutgoingScene = true
        //Determine which button was pressed
        if splashVideo.contains(touchLocation) {
            let nextScene = BeginningStoryScene3(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene)
        }
    }
    
}
