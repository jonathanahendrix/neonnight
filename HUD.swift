//
//  HUD.swift
//  Benjamin and Ninjamen//
//  Created by Jonathan Andrew Hendrix on 2/1/18.
//  Copyright © 2018 Neon Night Riders. All rights reserved.
//

import SpriteKit

class HUD: SKNode {
    let userDefaults = UserDefaults.standard
    var scoreLabel = SKLabelNode(text:"0000")
    var scoreLabelCounter = 0000
    var lifeNodes: [SKSpriteNode] = []
    var textAtlas = SKTextureAtlas(named: "HUD")
    let scoreLabelName = "scoreLabel"
    var hitIcon = SKSpriteNode(imageNamed:"hit0")
    var hitCount = 0
    //Button Variables
    let leftPunchButton = SKSpriteNode(imageNamed:"btnPunch")
    let rightPunchButton = SKSpriteNode(imageNamed:"btnPunch")
    let leftDodgeButton = SKSpriteNode(imageNamed:"btnLeftDodge")
    let rightDodgeButton = SKSpriteNode(imageNamed:"btnRightDodge")
    let controls = SKSpriteNode(imageNamed:"controllerBackground")
    let pauseButton = SKSpriteNode(imageNamed:"btnPause")
    let exitButton = SKSpriteNode(imageNamed:"btnExit")
    let punchSound = SKAction.playSoundFileNamed("Punch.wav", waitForCompletion: false)
    let dodgeLeftSound = SKAction.playSoundFileNamed("Dodge Left.wav", waitForCompletion: false)
    let dodgeRightSound = SKAction.playSoundFileNamed("Dodge Right.wav", waitForCompletion: false)
    let buttonPressed = SKAction.playSoundFileNamed("ButtonPressed.wav", waitForCompletion: false)
    let buttonReleased = SKAction.playSoundFileNamed("ButtonReleased.wav", waitForCompletion: false)
    //let background = SKSpriteNode(imageNamed:"benjaminInNewYork")
    
    
    func createHUDNodes(screenSize:CGSize){
        
        
        hitIcon.position = CGPoint(x:screenSize.width/2, y:screenSize.height/1.77)
        hitIcon.zPosition = 4
        self.addChild(hitIcon)
        
        scoreLabel.text = "\(scoreLabelCounter)"
        scoreLabel.fontSize = 65
        //scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        
        scoreLabel = SKLabelNode(fontNamed: "DS-Digital")
        scoreLabel.zPosition = 4
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        //scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        scoreLabel.fontColor = SKColor.black
        scoreLabel.name = scoreLabelName
        self.addChild(scoreLabel)
        
        //Controls
        controls.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        controls.zPosition = 9
        self.addChild(controls)
        
        //Left Punch Button
        leftPunchButton.name = "leftPunch"
        leftPunchButton.position = CGPoint(x: screenSize.width * 0.11, y: screenSize.height * 0.765)
        leftPunchButton.zPosition = 10
        self.addChild(leftPunchButton)
        
        //Right Punch Button
        rightPunchButton.name = "rightPunch"
        rightPunchButton.position = CGPoint(x: screenSize.width * 0.89, y: screenSize.height * 0.765)
        rightPunchButton.zPosition = 10
        self.addChild(rightPunchButton)
        
        //Left Dodge Button
        leftDodgeButton.name = "leftDodge"
        leftDodgeButton.position = CGPoint(x: screenSize.width * 0.11, y: screenSize.height * 0.383)
        leftDodgeButton.zPosition = 10
        self.addChild(leftDodgeButton)
        
        //Right Dodge Button
        rightDodgeButton.name = "rightDodge"
        rightDodgeButton.position = CGPoint(x: screenSize.width * 0.89, y: screenSize.height * 0.383)
        rightDodgeButton.zPosition = 10
        self.addChild(rightDodgeButton)
        
        //Pause Button
        pauseButton.name = "pauseButton"
        pauseButton.position = CGPoint(x: screenSize.width * 0.367, y: screenSize.height * 0.107)
        pauseButton.zPosition = 10
        self.addChild(pauseButton)
        
        //Exit Button
        exitButton.name = "exitButton"
        exitButton.position = CGPoint(x: screenSize.width * 0.633, y: screenSize.height * 0.107)
        exitButton.zPosition = 10
        self.addChild(exitButton)
    }
    //Udates Score
    func updateScoreLabel(newScoreCount:Int){
        let number = NSNumber(value:newScoreCount)
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 5
        if let scoreStr = formatter.string(from: number){
            scoreLabel.text = scoreStr
        }
    }//<--End of setScoreLabel()
    
    //When button is pressed
    func buttonPressed(button: SKSpriteNode, background: SKSpriteNode){
        button.run(buttonPressed)
        let scale = SKAction.scale(to: 0.98, duration: 0)
        let darken = SKAction.colorize(with: .black, colorBlendFactor: 0.30, duration: 0.10)
        let group = SKAction.group([scale,darken])
        if button.name == "leftPunch"{
           // let changeTexture = SKAction.run{self.leftPunchButton.texture = SKTexture(imageNamed:"DkbtnPunch")}
            leftPunchButton.run(group)
            if userDefaults.bool(forKey: "sound"){
                leftPunchButton.run(punchSound)
            }
        }else if button.name == "rightPunch"{
           //let changeTexture = SKAction.run{self.rightPunchButton.texture = SKTexture(imageNamed:"DkbtnPunch")}
            rightPunchButton.run(group)
            if userDefaults.bool(forKey: "sound"){
                rightPunchButton.run(punchSound)
            }
        }else if button.name == "leftDodge"{
            //let changeTexture = SKAction.run{self.leftDodgeButton.texture = SKTexture(imageNamed:"DkbtnLeftDodge")}
            leftDodgeButton.run(group)
            if userDefaults.bool(forKey: "sound"){
                leftDodgeButton.run(dodgeLeftSound)
            }
        }else if button.name == "rightDodge"{
            //let changeTexture = SKAction.run{self.rightDodgeButton.texture = SKTexture(imageNamed:"DkbtnRightDodge")}
            rightDodgeButton.run(group)
            if userDefaults.bool(forKey: "sound"){
                rightDodgeButton.run(dodgeRightSound)
            }
        }else if button.name == "pauseButton"{
            print("\(background)")
            //pauseButton.run(group)
            //pauseGame(background: background)
        }else if button.name == "exitButton"{
            exitButton.run(group)}
    }//<--End of buttonPressed()
    
    //When button is released
    func buttonReleased(button:SKSpriteNode){
        button.run(buttonReleased)
        let scale = SKAction.scale(to: 1, duration: 0)
        let lighten = SKAction.colorize( withColorBlendFactor: 0.00, duration: 0.10)
        let group = SKAction.group([scale,lighten])
        //Punch Left Button
        if button.name == "leftPunch"{
            leftPunchButton.run(group)
            
        //Punch Right Button
        }else if button.name == "rightPunch"{
            rightPunchButton.run(group)
            
        //Dodge Left Button
        }else if button.name == "leftDodge"{
            leftDodgeButton.run(group)
            
        //Dodge Right Button
        }else if button.name == "rightDodge"{
            rightDodgeButton.run(group)
            
        //Pause Button
        }else if button.name == "pauseButton"{
            pauseButton.run(group)
            
        }else if button.name == "exitButton"{
            exitButton.run(group)
            exitGame()
        }
    }//<--End of buttonReleased()
    
    /*func pauseGame(background:SKSpriteNode){
        let pauseBackground = background.name as! String
        let pauseImage = SKSpriteNode(imageNamed:"\(pauseBackground)Pause")
        pauseImage.zPosition = 4
        pauseImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(pauseImage)
        removeAllActions()
    }*/
    func exitGame(){
        let transition = SKTransition.fade(withDuration: 0.05)
        
        let menu = MenuScene(size: scene!.size)
        scene?.view?.presentScene(menu,transition:transition)
    }
    func updateHit(counter: Int){
        print("Current Hit: \(counter)")
        let hitIconCounter = "\(counter)"
        let updateHitCounter = SKAction.run {self.hitIcon.texture = SKTexture(imageNamed:"hit\(hitIconCounter)")}
            hitIcon.run(updateHitCounter)
        
    }
    func updateScore(hitPoints:Int){
        print("Current Score: \(scoreLabelCounter)")
        let hitPoints = hitPoints
       scoreLabelCounter += hitPoints
        updateScoreLabel(newScoreCount: scoreLabelCounter)
    }
}
