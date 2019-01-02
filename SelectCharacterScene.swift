//
//  SelectCharacter.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 12/30/16.
//  Copyright © 2016 Neon Night Riders. All rights reserved.
//

import SpriteKit

class SelectCharacterScene: SKScene {
    let background = SKSpriteNode(imageNamed: "selectCharacter")
    let benjaminSelect = SKSpriteNode(imageNamed: "benjaminSelect")
    let karateSelect = SKSpriteNode(imageNamed: "benjaminSelect")
    let bearSelect = SKSpriteNode(imageNamed: "benjaminSelect")
    
    var touchLocation = CGPoint(x: 0, y: 0)
    
    override func didMove(to view: SKView) {
    background.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
    background.position = CGPoint(x: size.width/2, y: size.height/2)
    background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    background.zPosition = -1
    addChild(background)
   
    
    karateSelect.zPosition = 1
    karateSelect.alpha = 0
    karateSelect.position = CGPoint(x: size.width * 0.175, y: size.height * 0.43)
    addChild(karateSelect)
        
   
    benjaminSelect.zPosition = 1
    benjaminSelect.position = CGPoint(x: size.width/2, y: size.height * 0.43)
    benjaminSelect.alpha = 0
    addChild(benjaminSelect)
    
    bearSelect.zPosition = 1
    
    bearSelect.alpha = 0
    bearSelect.position = CGPoint(x: size.width * 0.825, y: size.height * 0.43)
    addChild(bearSelect)
    
    
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        //Choose the first touch
        touchLocation = touch.location(in: self)
        let transition = SKTransition.fade(withDuration: 0.02)
        let userDefaults = UserDefaults.standard
        
        //Determine which button was pressed
            if benjaminSelect.contains(touchLocation) {
                if userDefaults.bool(forKey: "sound"){
                benjaminSelect.run(SKAction.playSoundFileNamed("Bloop.mp3", waitForCompletion: true))
                }
                let nextScene = BenjaminCharacterScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            } else if karateSelect.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                karateSelect.run(SKAction.playSoundFileNamed("Bloop.mp3", waitForCompletion: true))
                }
                let nextScene = KarateCharacterScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            } else if bearSelect.contains(touchLocation){
                if userDefaults.bool(forKey: "music"){
                bearSelect.run(SKAction.playSoundFileNamed("Bloop.mp3", waitForCompletion: true))
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
