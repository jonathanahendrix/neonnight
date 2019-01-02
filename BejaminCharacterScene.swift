//
//  BejaminCharacter.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 1/10/17.
//  Copyright © 2017 Neon Night Riders. All rights reserved.
//
import SpriteKit

class BenjaminCharacterScene: SKScene {
    let background = SKSpriteNode(imageNamed: "benjaminSelectConfirm")
    var touchLocation = CGPoint(x: 0, y: 0)
    let benjamin = SKSpriteNode(imageNamed: "benjaminSelect")
    let karate = SKSpriteNode(imageNamed: "benjaminSelect")
    let bear = SKSpriteNode(imageNamed: "benjaminSelect")
    override func didMove(to view: SKView) {
        background.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        addChild(background)
        
        
        benjamin.name = "benjamin"
        benjamin.zPosition = 1
        benjamin.alpha = 0.0
        benjamin.position = CGPoint(x: 333, y: 161)
        self.addChild(benjamin)
        
      
        karate.name = "karate"
        karate.zPosition = 1
        karate.alpha = 0.0
        karate.position = CGPoint(x: 118, y: 161)
        self.addChild(karate)
        
        bear.name = "bear"
        bear.zPosition = 1
        bear.alpha = 0.0
        bear.position = CGPoint(x: 550, y: 161)
        self.addChild(bear)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        //Choose the first touch
        touchLocation = touch.location(in: self)
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 0.02)
        transition.pausesIncomingScene = true
        transition.pausesOutgoingScene = true
        let userDefaults = UserDefaults.standard
        //Determine which button was pressed
        if benjamin.contains(touchLocation) {
            if (userDefaults.bool(forKey: "story")){
                let nextScene = BenjaminInNewYorkGameScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            } else {
                let nextScene = BenjaminInTokyoGameScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
        } else if karate.contains(touchLocation){
            if userDefaults.bool(forKey: "sound"){
            karate.run(SKAction.playSoundFileNamed("Bloop.mp3", waitForCompletion: true))
            }
            let nextScene = KarateCharacterScene(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene, transition: transition)
        } else if bear.contains(touchLocation){
            if userDefaults.bool(forKey: "sound"){
            bear.run(SKAction.playSoundFileNamed("Bloop.mp3", waitForCompletion: true))
            }
            let nextScene = BearCharacterScene(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene, transition: transition)
        } else {
            let nextScene = SelectCharacterScene(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene, transition: transition)
        }
    }
}

