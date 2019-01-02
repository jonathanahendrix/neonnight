//
//  BeginningStoryScene5.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 3/20/17.
//  Copyright © 2017 Neon Night Riders. All rights reserved.
//


import SpriteKit

class BeginningStoryScene5: SKScene {
    
    let splashVideo = SKVideoNode(fileNamed: "BS5-Low.mp4")
    
    var touchLocation = CGPoint(x: 0, y: 0)
    var touchCount = 1;
    
    let transition = SKTransition.crossFade(withDuration: 0.50)
    
    
    // var playerSelect = playerDefault.valueForKey("playerSelect")
    override func didMove(to view: SKView) {
      

        splashVideo.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        splashVideo.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(splashVideo)
        splashVideo.play()
        transition.pausesIncomingScene = false
        transition.pausesOutgoingScene = false
        let wait2 = SKAction.wait(forDuration: 3.0)
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "kobe"){
            let nextScene = KobeInNewYorkGameScene(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            
            let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: self.transition)})
            self.run(SKAction.sequence([wait2,changeScene]))
        }else {
            let nextScene = SelectCharacterScene(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            
            let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: self.transition)})
            self.run(SKAction.sequence([wait2,changeScene]))
        }
       
        
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
            let userDefaults = UserDefaults.standard
            if userDefaults.bool(forKey: "kobe"){
                let nextScene = KobeInNewYorkGameScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                
                let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: self.transition)})
                self.run(SKAction.sequence([changeScene]))
            }else {
                let nextScene = SelectCharacterScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                
                let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: self.transition)})
                self.run(SKAction.sequence([changeScene]))
            }

           
        }
    }
    
}
