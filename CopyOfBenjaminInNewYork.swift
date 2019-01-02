//
//  CopyOfBenjaminInNewYork.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 2/26/18.
//  Copyright © 2018 Neon Night Riders. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class CopyOfBenjaminInNewYork: SKScene, SKPhysicsContactDelegate {
    
    let splashVideo = SKVideoNode(fileNamed: "HoboDefeat.mp4")
    let background = SKSpriteNode(imageNamed: "benjaminInNewYork")
    
    //Pause Variables
    let pauseBackground = SKSpriteNode(imageNamed: "NewYorkPause")
    let pauseOne = SKSpriteNode(imageNamed: "One")
    let pauseTwo = SKSpriteNode(imageNamed: "Two")
    let pauseThree = SKSpriteNode(imageNamed: "Three")
    let controllers = SKSpriteNode(imageNamed: "controllerBackground")
    let playerDamage = SKSpriteNode(imageNamed: "playerDamage")
    let enemyDamage = SKSpriteNode(imageNamed: "enemyDamage")
    
    var playerDead = false
    var gameStatus = true
    
    var hitMeter = SKSpriteNode(imageNamed: "hitMeter")
    var hitCount = 0
    
    //Player Variables
    var player = SKSpriteNode(imageNamed: "BenjaminIdle")
    var playerLeftArm = SKSpriteNode(imageNamed:"BenjaminLeftArm")
    var playerRightArm = SKSpriteNode(imageNamed:"BenjaminRightArm")
    var playerLeftDodge = SKSpriteNode(imageNamed: "BenjaminLeftDodge")
    var playerRightDodge = SKSpriteNode(imageNamed: "BenjaminRightDodge")
    
    //Enemy Variables
    
    var enemy = SKSpriteNode(imageNamed:"HoboIdle")
    var enemyRightArm = SKSpriteNode(imageNamed:"HoboRightArm")
    var enemyLeftArm = SKSpriteNode(imageNamed:"HoboLeftArm")
    var enemyTell1 = SKSpriteNode(imageNamed: "HoboTell1")
    
    //Buttons
    var leftPunchButton = SKSpriteNode(imageNamed: "btnPunch")
    var rightPunchButton = SKSpriteNode(imageNamed: "btnPunch")
    var rightDodgeButton = SKSpriteNode(imageNamed: "btnRightDodge")
    var leftDodgeButton = SKSpriteNode(imageNamed: "btnLeftDodge")
    var exitButton = SKSpriteNode(imageNamed:"btnExit")
    var pauseButton = SKSpriteNode(imageNamed:"btnPause")
    var touchLocation = CGPoint(x: 0, y: 0)
    
    //Music
    var gameBackgroundMusic: SKAudioNode = SKAudioNode(fileNamed:"Hobo.m4a")
    
    //Score Label
    var scoreLabel = SKLabelNode()
    let scoreLabelName = "scoreLabel"
    var count:Int = 0
    
    //Global Variable
    let userDefaults = UserDefaults.standard
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor.black
        if userDefaults.bool(forKey: "music"){
            gameBackgroundMusic.run(SKAction.changeVolume(to: 0.25, duration: 0))
            addChild(gameBackgroundMusic)
        }
        
        //Background
        background.position = CGPoint(x: size.width/2, y: size.height * 0.565)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = 0
        addChild(background)
        
        //Controllers
        controllers.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        controllers.position = CGPoint(x: size.width/2, y: size.height/2)
        controllers.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        controllers.zPosition = 3
        addChild(controllers)
        
        //Left Punch Button location
        leftPunchButton.position = CGPoint(x: size.width * 0.11, y: size.height * 0.765)
        leftPunchButton.zPosition = 4
        addChild(leftPunchButton)
        
        //Left Dodge Button Location
        leftDodgeButton.position = CGPoint(x: size.width * 0.11, y: size.height * 0.383)
        leftDodgeButton.zPosition = 4
        addChild(leftDodgeButton)
        
        //Right Punch Button Location
        rightPunchButton.position = CGPoint(x: size.width * 0.89, y: size.height * 0.765)
        rightPunchButton.zPosition = 4
        addChild(rightPunchButton)
        
        //RightDodgeButton Location
        rightDodgeButton.position = CGPoint(x: size.width * 0.89, y: size.height * 0.383)
        rightDodgeButton.zPosition = 4
        addChild(rightDodgeButton)
        
        //Score Label
        scoreLabel = SKLabelNode(fontNamed: "DS-Digital")
        scoreLabel.name = scoreLabelName
        scoreLabel.fontSize = 34
        scoreLabel.fontColor = SKColor.black
        scoreLabel.text = "\(count)"
        print(size.height)
        scoreLabel.position = CGPoint(x: size.width * 0.77, y: size.height * 0.86)
        scoreLabel.zPosition = 1
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        self.addChild(scoreLabel)
        
        //Hit Meter
        hitMeter.position = CGPoint(x:size.width/2, y:size.height/1.77)
        hitMeter.zPosition = 1
        addChild(hitMeter)
        
        //Player Damage
        playerDamage.position = CGPoint(x: size.width/2, y: size.height * 0.565)
        playerDamage.zPosition = 1
        //addChild(playerDamage)
        
        //Enemy Damage
        enemyDamage.position = CGPoint(x: size.width/2, y: size.height * 0.565)
        enemyDamage.zPosition = 1
        //addChild(enemyDamage)
        
        //Pause Button
        pauseButton.position = CGPoint(x: size.width * 0.367, y: size.height * 0.107)
        pauseButton.zPosition = 4
        // addChild(pauseButton)
        
        //Pause Background
        pauseBackground.position = CGPoint(x: size.width/2, y: size.height * 0.565)
        pauseBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pauseBackground.zPosition = 2
        
        //Pause One
        pauseOne.position = CGPoint(x: size.width * 0.602, y: size.height * 0.416)
        pauseOne.zPosition = 3
        //addChild(pauseOne)
        
        //Pause Two
        pauseTwo.position = CGPoint(x: size.width * 0.50, y: size.height * 0.416)
        pauseTwo.zPosition = 3
        //addChild(pauseTwo)
        
        //Pause Three
        pauseThree.position = CGPoint(x: size.width * 0.405, y: size.height * 0.416)
        pauseThree.zPosition = 3
        //addChild(pauseThree)
        
        //Exit Button
        exitButton.position = CGPoint(x: size.width * 0.633, y: size.height * 0.107)
        exitButton.zPosition = 4
        //addChild(exitButton)
        
        //Win Scene
        splashVideo.size = CGSize(width: size.width/1.35, height: size.height/1.34)
        splashVideo.position = CGPoint(x: size.width * 0.00, y: size.height * 0.00)
        splashVideo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        splashVideo.zPosition = 2
        
        //Player Location (Benjamin)
        player.position = CGPoint(x: size.width/2, y: size.height * 0.413)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width/2,
                                                               height: player.size.height))
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = BodyType.playerBody.rawValue
        player.physicsBody?.collisionBitMask = 0
        addChild(player)
        
        //Left Arm Punch
        playerLeftArm.position = CGPoint(x:size.width * 0.449, y:size.height * 0.52)
        playerLeftArm.zPosition = 1
        playerLeftArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerLeftArm.size.width/2.5, height: playerLeftArm.size.height * 1.10))
        playerLeftArm.physicsBody?.affectedByGravity = false
        playerLeftArm.physicsBody?.isDynamic = true
        playerLeftArm.physicsBody?.categoryBitMask = BodyType.playerArm.rawValue
        playerLeftArm.physicsBody?.collisionBitMask = 0
        playerLeftArm.physicsBody?.contactTestBitMask = BodyType.enemyBody.rawValue
        
        //Right Arm Punch
        playerRightArm.position = CGPoint(x:size.width * 0.55, y:size.height * 0.516)
        playerRightArm.zPosition = 1
        playerRightArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerRightArm.size.width/2.5, height: playerRightArm.size.height * 1.10))
        playerRightArm.physicsBody?.affectedByGravity = false
        playerRightArm.physicsBody?.isDynamic = true
        playerRightArm.physicsBody?.categoryBitMask = BodyType.playerArm.rawValue
        playerRightArm.physicsBody?.collisionBitMask = 0
        playerRightArm.physicsBody?.contactTestBitMask = BodyType.enemyBody.rawValue
        
        //Left Dodge
        playerLeftDodge.position = CGPoint(x:size.width * 0.368, y:size.height * 0.385)
        playerLeftDodge.zPosition = 1
        playerLeftDodge.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerLeftDodge.size.width/2.5, height: playerLeftDodge.size.height * 1.10))
        playerLeftDodge.physicsBody?.affectedByGravity = false
        playerLeftDodge.physicsBody?.isDynamic = true
        
        //Right Dodge
        playerRightDodge.position = CGPoint(x:size.width * 0.643, y:size.height * 0.385)
        playerRightDodge.zPosition = 1
        playerRightDodge.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerRightDodge.size.width/2.5, height: playerRightDodge.size.height * 1.10))
        playerRightDodge.physicsBody?.affectedByGravity = false
        playerRightDodge.physicsBody?.isDynamic = true
        
        
        //Enemy Location (Hobo)
        enemy.position = CGPoint(x:size.width/2, y:size.height * 0.728)
        enemy.zPosition = 1
        enemy.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: enemy.size.width/2, height: enemy.size.height/2))
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.categoryBitMask = BodyType.enemyBody.rawValue
        enemy.physicsBody?.collisionBitMask = 0
        addChild(enemy)
        
        
        //Enemy Right Arm
        enemyRightArm.zPosition = 1
        enemyRightArm.position = CGPoint(x:size.width * 0.531, y:size.height * 0.692)
        enemyRightArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: enemyRightArm.size.width/2, height: enemyRightArm.size.height))
        enemyRightArm.physicsBody?.affectedByGravity = false
        enemyRightArm.physicsBody?.isDynamic = true
        enemyRightArm.physicsBody?.categoryBitMask = BodyType.enemyArm.rawValue
        enemyRightArm.physicsBody?.collisionBitMask = 0
        enemyRightArm.physicsBody?.contactTestBitMask = BodyType.playerBody.rawValue
        
        //Enemy Left Arm
        enemyLeftArm.zPosition = 1
        enemyLeftArm.position = CGPoint(x:size.width * 0.469, y:size.height * 0.692)
        enemyLeftArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: enemyLeftArm.size.width/2, height: enemyLeftArm.size.height))
        enemyLeftArm.physicsBody?.affectedByGravity = false
        enemyLeftArm.physicsBody?.isDynamic = true
        enemyLeftArm.physicsBody?.categoryBitMask = BodyType.enemyArm.rawValue
        enemyLeftArm.physicsBody?.collisionBitMask = 0
        enemyLeftArm.physicsBody?.contactTestBitMask = BodyType.playerBody.rawValue
        if gameStatus {
            enemyAction()
            
        }    }//<---END OF didMove
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        print("This is contact A: \(contact.bodyA.categoryBitMask)")
        print("This is contact B:\(contact.bodyB.categoryBitMask)")
        print(contactMask)
        let userDefaults = UserDefaults.standard
        switch(contactMask){
        case BodyType.playerArm.rawValue + BodyType.enemyBody.rawValue:
            let enemyHit = SKAction.run{self.addChild(self.enemyDamage)}
            let wait = SKAction.wait(forDuration: 0.1)
            let removeDamage = SKAction.run({self.enemyDamage.removeFromParent()})
            self.run(SKAction.sequence([enemyHit, wait, removeDamage]))
            print("Player hit enemy")
            count += 20
            scoreLabel.text = "\(count)"
            if (userDefaults.bool(forKey: "story") && count >= 750)
            {
                nextRound()
            }
            
        case BodyType.enemyArm.rawValue + BodyType.playerBody.rawValue:
            let playerHit = SKAction.run{self.addChild(self.playerDamage)}
            let wait = SKAction.wait(forDuration: 0.5)
            let removeDamage = SKAction.run({self.playerDamage.removeFromParent()})
            if userDefaults.bool(forKey: "sound"){
                self.run(SKAction.playSoundFileNamed("Damage.mp3", waitForCompletion: false))
            }
            self.run(
                SKAction.sequence([playerHit, wait, removeDamage])
                
            )
            hitCount += 1
            if hitCount == 1 {
                hitMeter.texture = SKTexture(imageNamed:"hit\(hitCount)")
            }else if (hitCount == 2){
                hitMeter.texture = SKTexture(imageNamed:"hit\(hitCount)")
            }else if(hitCount == 3) {
                hitMeter.texture = SKTexture(imageNamed:"hit\(hitCount)")
            }else{
                gameOver()
            }
            
        default:
            return
        }
    }
    
    /* func pauseGame(){
     if gameStatus {
     enemy.removeAllActions()
     gameStatus = false
     } else {
     gameStatus = true
     enemyAction()
     }
     
     
     }
     */
    func gameOver() {
        playerDead = true
        gameStatus = false
        let gameOverScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"HoboBen")}
        let fadeOut = SKAction.fadeOut(withDuration: 0.60)
        let fadeIn = SKAction.fadeIn(withDuration: 0.60)
        let backgroundfadeOut = SKAction.run{self.background.run(fadeOut)}
        let backgroundfadeIn = SKAction.run{self.background.run(fadeIn)}
        let pausePlayer = SKAction.run{self.player.removeAllActions()}
        let pauseEnemy = SKAction.run{self.enemy.removeAllActions()}
        let pauseGroup = SKAction.group([pauseEnemy,pausePlayer])
        let removePlayer = SKAction.run{self.player.removeFromParent()}
        let removeEnemy = SKAction.run{self.enemy.removeFromParent()}
        let removeGroup = SKAction.group([removePlayer,removeEnemy])
        let wait2 = SKAction.wait(forDuration: 0.60)
        let wait3 = SKAction.wait(forDuration: 5.00)
        let wait1 = SKAction.wait(forDuration: 0.30)
        let nextScene = MenuScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: transition)})
        let backgroundPosition = SKAction.run{self.background.zPosition = 5.0}
        self.run(SKAction.sequence([pauseGroup,wait1,removeGroup, backgroundfadeOut,wait2, gameOverScene,wait1, backgroundPosition,backgroundfadeIn, wait3, changeScene]))
        
        gameBackgroundMusic.removeFromParent()
        leftPunchButton.removeFromParent()
        leftDodgeButton.removeFromParent()
        rightDodgeButton.removeFromParent()
        rightPunchButton.removeFromParent()
        self.backgroundColor = SKColor.black
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        //Player controllers
        let touch = touches.first!
        //Choose the first touch
        touchLocation = touch.location(in: self)
        let addLeftPunch = SKAction.run{self.player.texture = SKTexture(imageNamed:"BenjaminLeftPunch")}
        let waitPunch = SKAction.wait( forDuration: 0.15)
        let waitDodge = SKAction.wait(forDuration: 0.5)
        let addRightPunch = SKAction.run{self.player.texture = SKTexture(imageNamed:"BenjaminRightPunch")}
        let addIdle = SKAction.run {
            self.player.texture = SKTexture(imageNamed:"BenjaminIdle")}
        let removeLeftArm = SKAction.run{ self.playerLeftArm.removeFromParent()}
        let addLeftArm = SKAction.run{self.addChild(self.playerLeftArm)}
        let removeRightArm = SKAction.run{ self.playerRightArm.removeFromParent()}
        let addRightArm = SKAction.run({self.addChild(self.playerRightArm)})
        let moveRight = SKAction.move(to: CGPoint(x:size.width * 0.63, y:size.height * 0.413), duration: 0.00)
        let moveLeft = SKAction.move(to: CGPoint(x:size.width * 0.369, y:size.height * 0.415), duration: 0.00)
        let moveBack = SKAction.move(to: CGPoint(x: size.width/2, y: size.height * 0.413), duration: 0.00)
        let addRightDodge = SKAction.run{self.player.texture = SKTexture(imageNamed:"BenjaminRightDodge")}
        let addLeftDodge = SKAction.run{self.player.texture = SKTexture(imageNamed:"BenjaminLeftDodge")}
        let rightDodgeGroup = SKAction.group([moveRight,addRightDodge])
        let leftDodgeGroup = SKAction.group([moveLeft,addLeftDodge])
        //Checks if player is currently in action
        
        //Determine which button was pressed
        if leftPunchButton.contains(touchLocation) && !player.hasActions() && gameStatus {
            leftPunchButton.run(SKAction.run{self.leftPunchButton.texture = SKTexture(imageNamed:"DkPunch")})
            player.run(SKAction.sequence([addLeftPunch, addLeftArm, waitPunch, removeLeftArm, addIdle]))
            if userDefaults.bool(forKey: "sound"){
                leftPunchButton.run(SKAction.playSoundFileNamed("Punch.wav", waitForCompletion: false))
            }
        } else if rightPunchButton.contains(touchLocation) && !player.hasActions() && gameStatus{
            rightPunchButton.run(SKAction.run{self.rightPunchButton.texture = SKTexture(imageNamed:"DkPunch")})
            player.run(SKAction.sequence([addRightPunch, addRightArm, waitPunch, removeRightArm, addIdle]))
            if userDefaults.bool(forKey: "sound"){
                rightPunchButton.run(SKAction.playSoundFileNamed("Punch.wav", waitForCompletion: false))
            }
        } else if rightDodgeButton.contains(touchLocation) && !player.hasActions() && gameStatus {
            rightDodgeButton.run(SKAction.run{self.rightDodgeButton.texture = SKTexture(imageNamed:"DkRightDodge")})
            player.run(SKAction.sequence([rightDodgeGroup,waitDodge,moveBack,addIdle]))
            if userDefaults.bool(forKey: "sound"){
                rightDodgeButton.run(SKAction.playSoundFileNamed("Dodge Right.wav", waitForCompletion: false))
            }
        } else if leftDodgeButton.contains(touchLocation) && !player.hasActions() && gameStatus {
            leftDodgeButton.run(SKAction.run{self.leftDodgeButton.texture = SKTexture(imageNamed:"DkLeftDodge")})
            player.run(SKAction.sequence([leftDodgeGroup,waitDodge,moveBack,addIdle]))
            if userDefaults.bool(forKey: "sound"){
                leftDodgeButton.run(SKAction.playSoundFileNamed("Dodge Left.wav", waitForCompletion: false))
            }
            
        } else if pauseButton.contains(touchLocation){
            //   pauseButton.run(SKAction.run{self.pauseButton.texture = SKTexture(imageName:"")})
            if (playerDead != true) {
                pauseGame()
                print("This will pause the game")
            }
            
        } else if exitButton.contains(touchLocation){
            if (playerDead != true){
                exitGame()
            }
        }
            
        else{
            print("Nothing was touched")
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        touchLocation = touch.location(in: self)
        
        if leftPunchButton.contains(touchLocation) && gameStatus {
            leftPunchButton.run(SKAction.run{self.leftPunchButton.texture = SKTexture(imageNamed:"btnPunch")})
        } else if rightPunchButton.contains(touchLocation) && gameStatus{
            rightPunchButton.run(SKAction.run{self.rightPunchButton.texture = SKTexture(imageNamed:"btnPunch")})
        } else if rightDodgeButton.contains(touchLocation) && gameStatus {
            rightDodgeButton.run(SKAction.run{self.rightDodgeButton.texture = SKTexture(imageNamed:"btnRightDodge")})
        } else if leftDodgeButton.contains(touchLocation) && gameStatus {
            leftDodgeButton.run(SKAction.run{self.leftDodgeButton.texture = SKTexture(imageNamed:"btnLeftDodge")})
        } else {
            print("Nothing was touched")
        }
        
        
    }
    //Enemy's animation
    func enemyAction(){
        
        let addIdle = SKAction.run {
            self.enemy.texture = SKTexture(imageNamed:"HoboIdle")
        }
        
        let wait = SKAction.wait( forDuration: 1.40)
        let wait2 = SKAction.wait( forDuration: 0.20)
        let wait3 = SKAction.wait(forDuration: 0.50)
        
        let addRightPunch = SKAction.run{self.enemy.texture = SKTexture(imageNamed:"HoboRightPunch")
        }
        let addRightArm = SKAction.run({self.addChild(self.enemyRightArm)})
        let addLeftPunch = SKAction.run{self.enemy.texture = SKTexture(imageNamed:"HoboLeftPunch")}
        let addLeftArm = SKAction.run{self.addChild(self.enemyLeftArm)}
        let removeRightArm = SKAction.run{ self.enemyRightArm.removeFromParent()}
        let removeLeftArm = SKAction.run{ self.enemyLeftArm.removeFromParent()}
        let addTell1 = SKAction.run {self.enemy.texture = SKTexture(imageNamed:"HoboTell1") }
        let addTell2 = SKAction.run {self.enemy.texture = SKTexture(imageNamed:"HoboTell2") }
        let addTell3 = SKAction.run {self.enemy.texture = SKTexture(imageNamed:"HoboTell3") }
        if gameStatus == true {
            enemy.run(SKAction.repeatForever(SKAction.sequence([wait,addTell1,wait3, addRightPunch, addRightArm, wait2, removeRightArm, addIdle, wait, addTell1, wait3,  addLeftArm, addLeftPunch, wait2, removeLeftArm, addIdle, wait, addTell2, wait3, addRightPunch, addRightArm, wait2, removeRightArm, addIdle, wait, addTell3, wait, addLeftPunch, addLeftArm, wait2, removeLeftArm, addIdle  ])))
            
        } else {
            enemy.removeAllActions()
        }
        
    }
    
    func nextRound(){
        
        let addVideo = SKAction.run {self.background.addChild(self.splashVideo)}
        let wait1 = SKAction.wait(forDuration:1.0)
        let wait2 = SKAction.wait(forDuration: 7.0)
        let nextScene = BenjaminInBrazilGameScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        gameStatus = false
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.80)
        let fadeIn = SKAction.fadeIn(withDuration: 0.60)
        
        let backgroundfadeOut = SKAction.run{self.background.run(fadeOut)}
        let backgroundfadeIn = SKAction.run{self.background.run(fadeIn)}
        let pausePlayer = SKAction.run{self.player.removeAllActions()}
        let pauseEnemy = SKAction.run{self.enemy.removeAllActions()}
        let pauseGroup = SKAction.group([pauseEnemy,pausePlayer])
        let playVideo = SKAction.run {
            self.splashVideo.play()
        }
        leftPunchButton.removeFromParent()
        leftDodgeButton.removeFromParent()
        rightDodgeButton.removeFromParent()
        rightPunchButton.removeFromParent()
        scoreLabel.removeFromParent()
        hitMeter.removeFromParent()
        
        
        nextScene.scaleMode = .aspectFill
        let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: transition)})
        self.run(SKAction.sequence([pauseGroup,wait1,backgroundfadeOut,wait1, addVideo,wait1,backgroundfadeIn, playVideo,wait2,changeScene ]))
    }
    func pauseGame(){
        if gameStatus == true {
            gameStatus = false
            player.removeAllActions()
            enemy.removeAllActions()
            addChild(pauseBackground)
        } else if gameStatus == false {
            gameStatus = true
            let removePause = SKAction.run{self.pauseBackground.removeFromParent()}
            let addThree = SKAction.run{self.addChild(self.pauseThree)}
            let addTwo = SKAction.run{self.addChild(self.pauseTwo)}
            let addOne = SKAction.run{self.addChild(self.pauseOne)}
            
            let removeThree = SKAction.run{self.pauseThree.removeFromParent()}
            let removeTwo = SKAction.run{self.pauseTwo.removeFromParent()}
            let removeOne = SKAction.run{self.pauseOne.removeFromParent()}
            
            let removeAll = SKAction.group([removeThree,removeTwo,removeOne, removePause])
            if (enemyLeftArm.scene != nil) {
                enemyLeftArm.removeFromParent()
            }
            if (enemyRightArm.scene != nil){
                enemyRightArm.removeFromParent()
            }
            if (playerLeftArm.scene != nil) {
                playerLeftArm.removeFromParent()
            }
            if (playerRightArm.scene != nil){
                playerRightArm.removeFromParent()
            }
            let wait = SKAction.wait(forDuration: 0.5)
            let startEnemy = SKAction.run{ self.enemyAction()}
            self.run(SKAction.sequence([addThree, wait, addTwo, wait, addOne, wait, removeAll, startEnemy]))
            
        }
    }
    func exitGame(){
        
        let transition = SKTransition.fade(withDuration: 0.05)
        
        let menu = MenuScene(size: scene!.size)
        scene?.view?.presentScene(menu,transition:transition)
    }
}
