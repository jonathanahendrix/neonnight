//
//  BeginningStoryScene4.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 3/20/17.
//  Copyright © 2017 Neon Night Riders. All rights reserved.
//


import SpriteKit

class BeginningStoryScene4: SKScene {
    let splashVideo = SKVideoNode(fileNamed: "BS4-Low.mp4")
    let poster = SKSpriteNode(imageNamed: "kobePoster")
    var touchLocation = CGPoint(x: 0, y: 0)
    var touchCount = 1;
    var gameBackgroundMusic: SKAudioNode = SKAudioNode(fileNamed:"track4.mp3")
    override func didMove(to view: SKView) {
        addChild(gameBackgroundMusic)
       
        splashVideo.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        splashVideo.position = CGPoint(x: size.width/2, y: size.height/2)
        splashVideo.zPosition = 1
        addChild(splashVideo)
        splashVideo.play()
        
        poster.position = CGPoint(x: size.width * 0.864, y: size.height * 0.725)
        poster.zPosition = 2
        poster.alpha = 0.0
        addChild(poster)
        let transition = SKTransition.crossFade(withDuration: 1.5)
        transition.pausesIncomingScene = false
        transition.pausesOutgoingScene = true
        let wait2 = SKAction.wait(forDuration: 4.5)
        let nextScene = BeginningStoryScene5(size: scene!.size)
        nextScene.scaleMode = .aspectFill
        let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: transition)})
        self.run(SKAction.sequence([wait2,changeScene]))
        kobeNotSelect()
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        //Choose the first touch
        touchLocation = touch.location(in: self)
        let transition = SKTransition.crossFade(withDuration: 1.5)
        transition.pausesIncomingScene = false
        transition.pausesOutgoingScene = true
        //Determine which button was pressed
        if poster.contains(touchLocation) {
            kobeSelect()
            print("Kobe Selected")
            let nextScene = KobeStoryScene(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene)
        }else {
            kobeNotSelect()
            let nextScene = BeginningStoryScene5(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene,transition: transition)
        }
    }
    func kobeSelect(){
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "kobe"){
            print("Already true")
        }else {
        
        userDefaults.set(true, forKey: "kobe")
        userDefaults.synchronize()
        }
    }
    func kobeNotSelect(){
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "kobe"){
        userDefaults.set(false, forKey: "kobe")
        userDefaults.synchronize()
        } else {
            print("Already false")
        }
        
    }
        
}
