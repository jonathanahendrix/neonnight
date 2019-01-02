//
//  Menu.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 12/30/16.
//  Copyright © 2016 Neon Night Riders. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
   
    let background = SKSpriteNode(imageNamed: "menu")
    var touchLocation = CGPoint(x: 0, y: 0)
    let storyModeButton = SKSpriteNode(imageNamed: "storyMode")
    let arcadeModeButton = SKSpriteNode(imageNamed: "arcadeMode")
    let menuButton = SKSpriteNode(imageNamed: "btnMenu")
    var gameBackgroundMusic: SKAudioNode = SKAudioNode(fileNamed:"Title.m4a")
    
    override func didMove(to view: SKView) {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "music"){
        gameBackgroundMusic.run(SKAction.changeVolume(to: 0.50, duration: 0))
        addChild(gameBackgroundMusic)
        }
        background.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        
        background.zPosition = -1
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        // Add the background
        addChild(background)
        
        storyModeButton.position = CGPoint(x: size.width * 0.34, y: size.height * 0.107)
       // addChild(storyModeButton)
        
        menuButton.position = CGPoint(x: size.width * 0.50, y: size.height * 0.107)
        //addChild(menuButton)
        
        arcadeModeButton.position = CGPoint(x: size.width * 0.664, y: size.height * 0.106)
        //addChild(arcadeModeButton)
        
    }
    
    func storySelect(){
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "story"){
            print("Already true")
        }else {
            
            userDefaults.set(true, forKey: "story")
            userDefaults.synchronize()
        }
    }
    
    func arcadeSelect(){
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "story"){
            userDefaults.set(false, forKey: "story")
            userDefaults.synchronize()
        } else {
            print("Already false")
        }
        
    }
    func menuSelect(){
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let userDefaults = UserDefaults.standard
        let touch = touches.first!
        //Choose the first touch
        touchLocation = touch.location(in: self)
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.5)
        transition.pausesOutgoingScene = true
        transition.pausesIncomingScene = false
        //Determine which button was pressed
        if storyModeButton.contains(touchLocation) {
            if userDefaults.bool(forKey: "sound"){
                storyModeButton.run(SKAction.playSoundFileNamed("Bloop.mp3", waitForCompletion: true))}
            addChild(storyModeButton)
            storySelect()
            let nextScene = BeginningStoryScene(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene, transition: transition)
        } else if arcadeModeButton.contains(touchLocation){
            if userDefaults.bool(forKey: "sound"){
            arcadeModeButton.run(SKAction.playSoundFileNamed("Bloop.mp3", waitForCompletion: true))
            }
            addChild(arcadeModeButton)
            arcadeSelect()
            let nextScene = SelectCharacterScene(size: scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene, transition: transition)
        } else if menuButton.contains(touchLocation){
            if userDefaults.bool(forKey: "sound"){
                menuButton.run(SKAction.playSoundFileNamed("Bloop.mp3", waitForCompletion: true))
            }
            addChild(menuButton)
            let nextScene = InGameMenuScene(size:scene!.size)
            nextScene.scaleMode = .aspectFill
            scene?.view?.presentScene(nextScene, transition: transition)
        }
        
        else {
            print("Nothing was selected")
        }

    }

}
