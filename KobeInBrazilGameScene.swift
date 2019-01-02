//
//  KobeInBrazilGameScene.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 4/22/17.
//  Copyright © 2017 Neon Night Riders. All rights reserved.
//

import SpriteKit

class KobeInBrazilGameScene: SKScene, SKPhysicsContactDelegate {
    let userDefaults = UserDefaults.standard
    let hud = HUD()
    let player = Kobe()
    let enemy = Echo()
    var playerDamage = SKSpriteNode(imageNamed:"playerDamage")
    var enemyDamage = SKSpriteNode(imageNamed:"enemyDamage")
    let background = SKSpriteNode(imageNamed: "kobeInBrazil")
    var hitCounter = 0
    var gameStatus:Bool = true
    let pauseBackground = SKSpriteNode(imageNamed: "BrazilPause")
    let pauseOne = SKSpriteNode(imageNamed: "One")
    let pauseTwo = SKSpriteNode(imageNamed: "Two")
    let pauseThree = SKSpriteNode(imageNamed: "Three")
    let splashVideo = SKVideoNode(fileNamed: "EchoDefeat.mp4")
    var maxHitCount = 0
    var currentScore = 0
    
    //Music
    var gameBackgroundMusic: SKAudioNode = SKAudioNode(fileNamed:"Echo.m4a")
    
    override func didMove(to view: SKView) {
        if userDefaults.bool(forKey: "music"){
        gameBackgroundMusic.run(SKAction.changeVolume(to: 0.25, duration: 0))
        addChild(gameBackgroundMusic)
         }
        
        hud.zPosition = 0
        //Add the HUD
        hud.createHUDNodes(screenSize: self.size)
        self.addChild(hud)
        
        //Background
        background.name = "NewYork"
        background.position = CGPoint(x: size.width/2, y: size.height * 0.565)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = 2
        
        //SplashVideo
        splashVideo.size = CGSize(width: size.width/1.35, height: size.height/1.34)
        splashVideo.position = CGPoint(x: size.width * 0.00, y: size.height * 0.00)
        splashVideo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        splashVideo.zPosition = 5
        
        //Pause Background
        pauseBackground.position = CGPoint(x: size.width/2, y: size.height * 0.565)
        pauseBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pauseBackground.zPosition = 5
        
        //Pause One
        pauseOne.position = CGPoint(x: size.width * 0.602, y: size.height * 0.416)
        pauseOne.zPosition = 6
        
        //Pause Two
        pauseTwo.position = CGPoint(x: size.width * 0.50, y: size.height * 0.416)
        pauseTwo.zPosition = 6
        
        //Pause Three
        pauseThree.position = CGPoint(x: size.width * 0.405, y: size.height * 0.416)
        pauseThree.zPosition = 6
        
        //Score Label
        hud.scoreLabel.position = CGPoint(x: size.width * 0.77, y: size.height * 0.86)
        hud.scoreLabel.fontSize = 36
        hud.scoreLabel.text = "00000"
        addChild(background)
        
        //Enemy
        enemy.position = CGPoint(x:size.width/2, y:size.height * 0.739)//Queen CGPoint(x:size.width/2, y:size.height * 0.72)//Hobo CGPoint(x:size.width/2, y:size.height * 0.728)
        enemy.zPosition = 3
        addChild(enemy)
        
        //Player
        player.position = CGPoint(x: size.width/2, y: size.height * 0.40)//Karate CGPoint(x: size.width/2, y: size.height * 0.413) //Bear CGPoint(x: size.width * 0.505, y: size.height * 0.385)//Benjamin CGPoint(x: size.width/2, y: size.height * 0.413)
        player.zPosition = 3
        addChild(player)
        
        //Player Damage
        playerDamage.position = CGPoint(x: size.width/2, y: size.height * 0.56)
        playerDamage.zPosition = 3
        
        //Enemy Damage
        enemyDamage.position = CGPoint(x: size.width/2, y: size.height * 0.565)
        enemyDamage.zPosition = 3
        
        maxHitCount = enemy.maxHitAmount
        
        self.physicsWorld.contactDelegate = self
    }//<---End of didMove()
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask){
        //Player hits Enemy
        case BodyType.playerArm.rawValue + BodyType.enemyBody.rawValue:
            currentScore += player.playerHitPoints
            enemyHit()
            //Checks if story mode and if maxHitCount has been reaced
            if (userDefaults.bool(forKey: "story") && currentScore >= maxHitCount) {
                nextRound()
            }
            
        //Enemy hits Player
        case BodyType.enemyArm.rawValue + BodyType.playerBody.rawValue:
            if hitCounter < 3{
                playerHit()
            } else {
                gameOver()
            }
        default:
            print("Nothing Happened")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches){
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if !player.hasActions(){
                hud.buttonPressed(button: nodeTouched as! SKSpriteNode, background: background )
                if gameStatus{
                    player.playerActions(button: nodeTouched as! SKSpriteNode, screenSize: self.size)
                }
            }
            if nodeTouched.name == "pauseButton" {
                pauseGame()
            }
        }
    }//<--End of touchesBegan()
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches){
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            hud.buttonReleased(button: nodeTouched as! SKSpriteNode)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches){
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            hud.buttonReleased(button: nodeTouched as! SKSpriteNode)
        }
    }
    
    //Player takes damage and hit count added.
    func playerHit(){
        hitCounter += 1
        let playerHit = SKAction.run{self.addChild(self.playerDamage)}
        let wait = SKAction.wait(forDuration: 0.15)
        let removeDamage = SKAction.run({self.playerDamage.removeFromParent()})
        hud.updateHit(counter: hitCounter)
        if userDefaults.bool(forKey: "sound"){
            self.run(SKAction.playSoundFileNamed("Damage.mp3", waitForCompletion: false))
        }
        run(SKAction.sequence([playerHit, wait, removeDamage]))
    }//<-- End of playerHit()
    
    //Enemy takes damage and score is updated.
    func enemyHit(){
        let enemyHit = SKAction.run{self.addChild(self.enemyDamage)}
        let wait = SKAction.wait(forDuration: 0.1)
        let removeDamage = SKAction.run({self.enemyDamage.removeFromParent()})
        hud.updateScore(hitPoints: player.playerHitPoints)
        run(SKAction.sequence([enemyHit, wait, removeDamage]))
    }
    
    //Player loses
    func gameOver() {
        hud.removeAllActions()
        gameStatus = false
        let gameOverScene = SKAction.run{self.background.texture = SKTexture(imageNamed:"EchoKobe")}
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
        let wait2 = SKAction.wait(forDuration: 0.70)
        let wait3 = SKAction.wait(forDuration: 5.00)
        let wait1 = SKAction.wait(forDuration: 0.30)
        let nextScene = MenuScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: transition)})
        let backgroundPosition = SKAction.run{self.background.zPosition = 5.0}
        //Checks to see what mode player is playing.
        if (userDefaults.bool(forKey: "story") == false){
            //Checks to see if currentScore is greater than TopScore
            if (currentScore > userDefaults.integer(forKey: "topScore"))
            {
                //Updates player's top score.
                userDefaults.set(currentScore, forKey: "topScore")
                userDefaults.synchronize()
            }
        }
        self.run(SKAction.sequence([pauseGroup,wait1,removeGroup, backgroundfadeOut,wait2, gameOverScene,wait1, backgroundPosition,backgroundfadeIn, wait3, changeScene]))
    }//<-- End of gameOver()
    
    //Pauses the game
    func pauseGame(){
        if gameStatus {
            gameStatus = false
            addChild(pauseBackground)
            enemy.removeAllActions()
            player.removeAllActions()
        }else{
            gameStatus = true
            let removePause = SKAction.run{self.pauseBackground.removeFromParent()}
            let addThree = SKAction.run{self.addChild(self.pauseThree)}
            let addTwo = SKAction.run{self.addChild(self.pauseTwo)}
            let addOne = SKAction.run{self.addChild(self.pauseOne)}
            
            let removeThree = SKAction.run{self.pauseThree.removeFromParent()}
            let removeTwo = SKAction.run{self.pauseTwo.removeFromParent()}
            let removeOne = SKAction.run{self.pauseOne.removeFromParent()}
            let removeAll = SKAction.group([removeThree,removeTwo,removeOne, removePause])
            let wait = SKAction.wait(forDuration: 0.5)
            let startEnemy = SKAction.run{self.enemy.enemyAction()}
            if (enemy.leftPunch.scene != nil ){
                enemy.leftPunch.removeFromParent()
            }
            if (enemy.rightPunch.scene != nil ){
                enemy.rightPunch.removeFromParent()
            }
            if (player.playerLeftArm.scene != nil ){
                player.playerLeftArm.removeFromParent()
            }
            if (player.playerRightArm.scene != nil ){
                player.playerRightArm.removeFromParent()
            }
            self.run(SKAction.sequence([addThree, wait, addTwo, wait, addOne, wait, removeAll, startEnemy]))
            
        }
        
    }//<--End of pauseGame()
    
    func nextRound(){
        gameStatus = false
        let addVideo = SKAction.run {self.background.addChild(self.splashVideo)}
        let wait1 = SKAction.wait(forDuration:1.0)
        let wait2 = SKAction.wait(forDuration: 7.8)
        let nextScene = KobeInFranceGameScene(size: scene!.size)
        let transition = SKTransition.fade(withDuration: 0.5)
        gameStatus = false
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.80)
        let fadeIn = SKAction.fadeIn(withDuration: 0.60)
        
        let backgroundfadeOut = SKAction.run{self.background.run(fadeOut)}
        let backgroundfadeIn = SKAction.run{self.background.run(fadeIn)}
        
        let pausePlayer = SKAction.run{self.player.removeAllActions()}
        let pauseEnemy = SKAction.run{self.enemy.removeAllActions()}
        let pauseGroup = SKAction.group([pauseEnemy,pausePlayer])
        
        let removePlayer = SKAction.run{self.player.removeFromParent()}
        let removeEnemey = SKAction.run{self.enemy.removeFromParent()}
        let removeGroup = SKAction.group([removeEnemey,removePlayer])
        
        let playVideo = SKAction.run {
            self.splashVideo.play()
        }
        nextScene.scaleMode = .aspectFill
        let changeScene = SKAction.run({self.scene?.view?.presentScene(nextScene, transition: transition)})
        self.run(SKAction.sequence([pauseGroup,wait1,backgroundfadeOut,removeGroup,wait1,addVideo,wait1,backgroundfadeIn, playVideo,wait2,changeScene ]))
    }//<--End of nextRound()
}//<--End of GameScene

