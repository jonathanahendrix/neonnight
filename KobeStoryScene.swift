//
//  KobeStoryScene.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 4/19/17.
//  Copyright © 2017 Neon Night Riders. All rights reserved.
//



import SpriteKit

class KobeStoryScene: SKScene {
    let playerSelect = "Kobe"
    let splashVideo = SKVideoNode(fileNamed: "KobeIntro.mp4")
    
    var touchLocation = CGPoint(x: 0, y: 0)
    var touchCount = 1;
    override func didMove(to view: SKView) {
       
        splashVideo.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        splashVideo.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(splashVideo)
        splashVideo.play()
        
       
        
        
        
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
            let nextScene = BeginningStoryScene5(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene,transition: transition)
        }
    }
    
    
    
}
