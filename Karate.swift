//
//  Karate.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 2/17/18.
//  Copyright © 2018 Neon Night Riders. All rights reserved.
//

import Foundation
import SpriteKit

class Karate: SKSpriteNode {
    
    var playerImage:SKTexture =
        SKTexture(imageNamed:"KarateIdle" )
    var playerName: String = "Karate"
    var playerLeftArm = SKSpriteNode(imageNamed:"KarateLeftArm")
    var playerRightArm = SKSpriteNode(imageNamed:"KarateRightArm")
    var playerDamage = SKSpriteNode(imageNamed:"playerDamage")
    var playerHitPoints = 15
    init() {
        super.init(texture: playerImage, color: UIColor.clear, size: playerImage.size())
        
        //self.position = CGPoint(x: size.width/2, y: size.height * 0.413)
        self.zPosition = 1
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width/2,
                                                             height: self.size.height/2))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BodyType.playerBody.rawValue
        self.physicsBody?.collisionBitMask = 0
        
        
        
        //Left Arm Punch
        playerLeftArm.position = CGPoint(x: -35, y: 39)
        playerLeftArm.zPosition = 1
        playerLeftArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerLeftArm.size.width/2.5, height: playerLeftArm.size.height * 1.10))
        playerLeftArm.physicsBody?.affectedByGravity = false
        playerLeftArm.physicsBody?.isDynamic = true
        playerLeftArm.physicsBody?.categoryBitMask = BodyType.playerArm.rawValue
        playerLeftArm.physicsBody?.collisionBitMask = 0
        playerLeftArm.physicsBody?.contactTestBitMask = BodyType.enemyBody.rawValue
        
        //Right Arm Punch
        playerRightArm.position = CGPoint(x: 35, y: 39)
        playerRightArm.zPosition = 1
        playerRightArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerRightArm.size.width/2.5, height: playerRightArm.size.height * 1.10))
        playerRightArm.physicsBody?.affectedByGravity = false
        playerRightArm.physicsBody?.isDynamic = true
        playerRightArm.physicsBody?.categoryBitMask = BodyType.playerArm.rawValue
        playerRightArm.physicsBody?.collisionBitMask = 0
        playerRightArm.physicsBody?.contactTestBitMask = BodyType.enemyBody.rawValue
        
        //Player Damage
        playerDamage.position = CGPoint(x: 0, y: 57)
        playerDamage.zPosition = 1
        
    }
    
    func playerActions(button: SKSpriteNode, screenSize: CGSize){
        
        print("\(String(describing: button.name))")
        let waitPunch = SKAction.wait( forDuration: 0.15)
        let waitDodge = SKAction.wait(forDuration: 0.5)
        let addIdle = SKAction.run {
            self.texture = SKTexture(imageNamed:"KarateIdle")}
        if button.name == "leftPunch"{
            let addLeftPunch = SKAction.run{self.texture = SKTexture(imageNamed:"KarateLeftPunch")}
            let addLeftArm = SKAction.run{self.addChild(self.playerLeftArm)}
            let removeLeftArm = SKAction.run{ self.playerLeftArm.removeFromParent()}
            self.run(SKAction.sequence([addLeftPunch, addLeftArm, waitPunch, removeLeftArm, addIdle]))
            
        }else if button.name == "rightPunch"{
            let addRightPunch = SKAction.run{self.texture = SKTexture(imageNamed:"KarateRightPunch")}
            let addRightArm = SKAction.run({self.addChild(self.playerRightArm)})
            let removeRightArm = SKAction.run{ self.playerRightArm.removeFromParent()}
            self.run(SKAction.sequence([addRightPunch, addRightArm, waitPunch, removeRightArm, addIdle]))
            
        }else if button.name == "leftDodge"{
            let addLeftDodge = SKAction.run{self.texture = SKTexture(imageNamed:"KarateLeftDodge")}
            let moveLeft = SKAction.move(to: CGPoint(x:screenSize.width * 0.347, y: screenSize.height * 0.413), duration: 0.00)
            let moveBack = SKAction.move(to: CGPoint(x: screenSize.width/2, y: screenSize.height * 0.413), duration: 0.00)
            let leftDodgeGroup = SKAction.group([moveLeft,addLeftDodge])
            self.run(SKAction.sequence([leftDodgeGroup,waitDodge,moveBack,addIdle]))
            
        }else if button.name == "rightDodge"{
            let addRightDodge = SKAction.run{self.texture = SKTexture(imageNamed:"KarateRightDodge")}
            let moveRight = SKAction.move(to: CGPoint(x: screenSize.width * 0.65, y: screenSize.height * 0.413), duration: 0.00)
            let moveBack = SKAction.move(to: CGPoint(x: screenSize.width/2, y: screenSize.height * 0.413), duration: 0.00)
            let rightDodgeGroup = SKAction.group([moveRight,addRightDodge])
            self.run(SKAction.sequence([rightDodgeGroup,waitDodge,moveBack,addIdle]))
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
