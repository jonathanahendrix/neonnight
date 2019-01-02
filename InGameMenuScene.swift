//
//  InGameMenuScene.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 2/7/17.
//  Copyright © 2017 Neon Night Riders. All rights reserved.
//

import SpriteKit

class InGameMenuScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "pauseMenu")
    var touchLocation = CGPoint(x: 0, y: 0)
    let biosButton = SKSpriteNode(imageNamed: "Bios")
    let soundEffectsButton = SKSpriteNode(imageNamed: "SoundEffects")
    let backGameButton = SKSpriteNode(imageNamed: "BackToGame")
    let highScoresButton = SKSpriteNode (imageNamed: "HighScores")
    let gameCreditsButton = SKSpriteNode (imageNamed: "GameCredits")
    let titleScreenButton = SKSpriteNode (imageNamed: "TitleScreen")
    let controllers = SKSpriteNode(imageNamed: "controllerBackground")
    let benBioButton = SKSpriteNode(imageNamed: "BenjaminBios")
    let croganBioButton = SKSpriteNode(imageNamed: "CroganBios")
    let karateBioButton = SKSpriteNode(imageNamed: "KarateBios")
    let echoBioButton = SKSpriteNode(imageNamed: "EchoBios")
    let bearBioButton = SKSpriteNode(imageNamed: "BearBios")
    let queenBioButton = SKSpriteNode(imageNamed: "MachineBios")
    let kobeBioButton = SKSpriteNode(imageNamed: "KobeBios")
    let roboBioButton = SKSpriteNode(imageNamed: "RoboBios")
    let goBackToBios = SKSpriteNode(imageNamed: "GoBack")
    let goBackToMenu = SKSpriteNode (imageNamed:"GoBack")
    let soundsOnButton = SKSpriteNode(imageNamed: "onButton")
    let soundsOffButton = SKSpriteNode(imageNamed: "offButton")
    let musicOnButton = SKSpriteNode(imageNamed: "onButton")
    let musicOffButton = SKSpriteNode(imageNamed: "offButton")
    var topScore = SKLabelNode(fontNamed: "DS-Digital")
    var currentBackground = "pauseMenu"
    let bloopSound = SKAction.playSoundFileNamed("Bloop.mp3", waitForCompletion: false)
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.black
    
        
        
        
        
        //Controllers
        controllers.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        controllers.position = CGPoint(x: size.width/2, y: size.height/2)
        controllers.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        controllers.zPosition = -1
        addChild(controllers)
        
        background.position = CGPoint(x: size.width/2, y: size.height * 0.565)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = 0
        addChild(background)
        
        backGameButton.position = CGPoint(x: size.width * 0.364, y: size.height * 0.804)
        backGameButton.zPosition = 1
        //addChild(backGameButton)
        soundEffectsButton.position = CGPoint(x: size.width * 0.364, y: size.height * 0.564)
        soundEffectsButton.zPosition = 1
        addChild(soundEffectsButton)
        
        biosButton.position = CGPoint(x: size.width * 0.364, y: size.height * 0.323 )
        biosButton.zPosition = 1
        addChild(biosButton)
        
        highScoresButton.position = CGPoint(x: size.width * 0.637, y: size.height * 0.804 )
        highScoresButton.zPosition = 1
        addChild(highScoresButton)
        
        gameCreditsButton.position = CGPoint(x: size.width * 0.637, y: size.height * 0.564 )
        gameCreditsButton.zPosition = 1
        addChild(gameCreditsButton)
        
        titleScreenButton.position = CGPoint(x: size.width * 0.364, y: size.height * 0.804)
        titleScreenButton.zPosition = 1
        addChild(titleScreenButton)
        
        topScore.position = CGPoint(x: size.width/2, y: size.height/2)
        topScore.fontSize = 100
        topScore.fontColor = SKColor.black
        topScore.zPosition = 1
        
        ///////Bios
        
        benBioButton.position = CGPoint(x: size.width * 0.362, y: size.height * 0.855)
        benBioButton.zPosition = 1
        
        croganBioButton.position = CGPoint(x: size.width * 0.638, y: size.height * 0.855)
        croganBioButton.zPosition = 1
        
        karateBioButton.position = CGPoint(x: size.width * 0.362, y: size.height * 0.71)
        karateBioButton.zPosition = 1
        
        echoBioButton.position = CGPoint(x: size.width * 0.638, y: size.height * 0.71)
        echoBioButton.zPosition = 1
        
        bearBioButton.position = CGPoint(x: size.width * 0.362, y: size.height * 0.565)
        bearBioButton.zPosition = 1
        
        queenBioButton.position = CGPoint(x: size.width * 0.638, y: size.height * 0.565)
        queenBioButton.zPosition = 1
        
        roboBioButton.position = CGPoint(x: size.width * 0.638, y: size.height * 0.42)
        roboBioButton.zPosition = 1
        
        kobeBioButton.position = CGPoint(x: size.width * 0.362, y: size.height * 0.42)
        kobeBioButton.zPosition = 1
        
        goBackToMenu.position = CGPoint(x: size.width * 0.50, y: size.height * 0.275)
        goBackToMenu.zPosition = 1
        
        goBackToBios.position = CGPoint(x:size.width/2,  y:size.height * 0.27)
        goBackToBios.zPosition = 2
        
        soundsOnButton.position = CGPoint(x:size.width * 0.55,  y:size.height * 0.566)
        soundsOnButton.zPosition = 2
        soundsOffButton.position = CGPoint(x:size.width * 0.705,  y:size.height * 0.566)
        soundsOffButton.zPosition = 2
        
        musicOnButton.position = CGPoint(x:size.width * 0.55,  y:size.height * 0.711)
        musicOnButton.zPosition = 2
        musicOffButton.position = CGPoint(x:size.width * 0.705,  y:size.height * 0.711)
        musicOffButton.zPosition = 2
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        //Choose the first touch
        touchLocation = touch.location(in: self)
        let transition = SKTransition.fade(withDuration: 0.05)
        let userDefaults = UserDefaults.standard
        //Determine which button was pressed
        if (currentBackground == "pauseMenu"){
            if biosButton.contains(touchLocation) {
                if userDefaults.bool(forKey: "sound"){
                    biosButton.run(bloopSound)
                }
                removeMenuButtons()
                addBios()
                currentBackground = "bioMenu"
                
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"CharacterBios")}
                self.run(changeScene)
                
            }else if soundEffectsButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    soundEffectsButton.run(bloopSound)
                }
                removeMenuButtons()
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"EffectsMenu")}
                self.run(changeScene)
                goToEffects()
                
            }else if highScoresButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    highScoresButton.run(bloopSound)
                }
                removeMenuButtons()
                addTopScores()
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"TopScoresMenu")}
                self.run(changeScene)
            }else if gameCreditsButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    gameCreditsButton.run(bloopSound)
                }
                let nextScene = CreditsScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }else if titleScreenButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    titleScreenButton.run(bloopSound)
                }
                let nextScene = MenuScene(size: scene!.size)
                nextScene.scaleMode = .aspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }else{
                print("Nothing was pressed")
            }
        } else if currentBackground == "bioMenu" {
            if benBioButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    benBioButton.run(bloopSound)
                }
                removeBios()
                goToBios()
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"BenBio")}
                self.run(changeScene)
            }else if croganBioButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    croganBioButton.run(bloopSound)
                }
                removeBios()
                goToBios()
                
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"CroganBio")}
                self.run(changeScene)
            }else if karateBioButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    karateBioButton.run(bloopSound)
                }
                removeBios()
                goToBios()
                
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"KarateBio")}
                self.run(changeScene)
            } else if bearBioButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    bearBioButton.run(bloopSound)
                }
                removeBios()
                goToBios()
                
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"BearBio")}
                self.run(changeScene)
            }else if echoBioButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    echoBioButton.run(bloopSound)
                }
                removeBios()
                goToBios()
                
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"EchoBio")}
                self.run(changeScene)
            }else if kobeBioButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    kobeBioButton.run(bloopSound)
                }
                removeBios()
                goToBios()
                
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"KobeBio")}
                self.run(changeScene)
            }else if queenBioButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    queenBioButton.run(bloopSound)
                }
                removeBios()
                goToBios()
                
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"MachineBio")}
                self.run(changeScene)
            }else if roboBioButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    roboBioButton.run(bloopSound)
                }
                removeBios()
                goToBios()
                
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"RoboBio")}
                self.run(changeScene)
            }else if goBackToBios.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    goBackToBios.run(bloopSound)
                }
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"pauseMenu")}
                removeBios()
                
                self.run(changeScene)
                addMenuButtons()
                
            } else {
                print("Not a button")
            }
        } else if currentBackground == "playerBackground"{
            
            if goBackToBios.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    goBackToBios.run(bloopSound)
                }
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"CharacterBios")}
                goBackToBios.removeFromParent()
                addBios()
                self.run(changeScene)
            } else {
                print("Nothing was pressed")
            }
        } else if currentBackground == "effects"{//<--Effects screen
            let userDefaults = UserDefaults.standard
            if soundsOnButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    print("Already true")
                } else {
                    userDefaults.set(true, forKey: "sound")
                    userDefaults.synchronize()
                    soundsOnButton.run(bloopSound)
                    soundsOffButton.removeFromParent()
                    addChild(soundsOnButton)
                }
            } else if soundsOffButton.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    userDefaults.set(false, forKey: "sound")
                    userDefaults.synchronize()
                    soundsOnButton.removeFromParent()
                    addChild(soundsOffButton)
                }else {
                    print("Already false")
                }
            } else if musicOnButton.contains(touchLocation) {
                if userDefaults.bool(forKey: "music"){
                    print("Already true")
                } else {
                    if userDefaults.bool(forKey: "sound"){
                        musicOnButton.run(bloopSound)
                    }
                    userDefaults.set(true, forKey: "music")
                    userDefaults.synchronize()
                    musicOffButton.removeFromParent()
                    addChild(musicOnButton)
                }
                
            } else if musicOffButton.contains(touchLocation){
                if userDefaults.bool(forKey: "music"){
                    userDefaults.set(false, forKey: "music")
                    userDefaults.synchronize()
                    musicOnButton.removeFromParent()
                    addChild(musicOffButton)
                }else {
                    print("Music off")
                }
            } else if goBackToMenu.contains(touchLocation) {
                if userDefaults.bool(forKey: "sound"){
                    goBackToMenu.run(bloopSound)
                }
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"pauseMenu")}
                removeEffects()
                addMenuButtons()
                self.run(changeScene)
            }else {
                print("Nothing else")
            }
        }else if currentBackground == "topScores"{
            if goBackToMenu.contains(touchLocation){
                if userDefaults.bool(forKey: "sound"){
                    goBackToMenu.run(bloopSound)
                }
                removeTopScores()
                addMenuButtons()
                let changeScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"pauseMenu")}
                self.run(changeScene)
            }
            
        }
        
    }
    
    
    func addMenuButtons(){
        currentBackground = "pauseMenu"
        addChild(biosButton)
       
        addChild(soundEffectsButton)
        addChild(highScoresButton)
        addChild(gameCreditsButton)
        addChild(titleScreenButton)
        
        
    }
    
    func removeMenuButtons(){
        
        soundEffectsButton.removeFromParent()
        highScoresButton.removeFromParent()
        gameCreditsButton.removeFromParent()
        titleScreenButton.removeFromParent()
        biosButton.removeFromParent()
    }
    func addBios(){
        currentBackground = "bioMenu"
        addChild(benBioButton)
        addChild(croganBioButton)
        addChild(karateBioButton)
        addChild(bearBioButton)
        addChild(echoBioButton)
        addChild(queenBioButton)
        addChild(kobeBioButton)
        addChild(roboBioButton)
        addChild(goBackToMenu)
    }
    
    func removeBios(){
        
        goBackToMenu.removeFromParent()
        benBioButton.removeFromParent()
        croganBioButton.removeFromParent()
        karateBioButton.removeFromParent()
        bearBioButton.removeFromParent()
        echoBioButton.removeFromParent()
        queenBioButton.removeFromParent()
        kobeBioButton.removeFromParent()
        roboBioButton.removeFromParent()
    }
    
    func goToBios(){
        print("In goToBios")
        addChild(goBackToBios)
        currentBackground = "playerBackground"
        print(currentBackground)
    }
    func goToEffects(){
        currentBackground = "effects"
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "sound"){
            addChild(soundsOnButton)
        }else {
            addChild(soundsOffButton)
        }
        if userDefaults.bool(forKey: "music"){
            addChild(musicOnButton)
        }else {
            addChild(musicOffButton)
        }
        addChild(goBackToMenu)
    }
    func removeEffects(){
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "sound"){
            soundsOnButton.removeFromParent()
        }else {
            soundsOffButton.removeFromParent()
        }
        if userDefaults.bool(forKey: "music"){
            musicOnButton.removeFromParent()
        }else {
            musicOffButton.removeFromParent()
        }
        goBackToMenu.removeFromParent()
        
    }
    func addTopScores(){
        currentBackground = "topScores"
        let userDefaults = UserDefaults.standard
        
        topScore.text = "\(userDefaults.integer(forKey: "topScore"))"
        addChild(topScore)
        addChild(goBackToMenu)
        
    }
    func removeTopScores(){
        topScore.removeFromParent()
        goBackToMenu.removeFromParent()
    }
   

}
