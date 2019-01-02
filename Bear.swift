//
//  Bear.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 2/17/18.
//  Copyright © 2018 Neon Night Riders. All rights reserved.
//

import Foundation
import SpriteKit

class Bear: SKSpriteNode {
    
    var playerImage:SKTexture =
        SKTexture(imageNamed:"BearIdle" )
    var playerName: String = "Bear"
    var playerLeftArm = SKSpriteNode(imageNamed:"BearLeftArm")
    var playerRightArm = SKSpriteNode(imageNamed:"BearRightArm")
    var playerDamage = SKSpriteNode(imageNamed:"playerDamage")
    var playerHitPoints = 50
    init() {
        super.init(texture: playerImage, color: UIColor.clear, size: playerImage.size())
        
        //self.position = CGPoint(x: size.width/2, y: size.height * 0.413)
        self.zPosition = 1
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width/2,
                                                             height: self.size.height/1.40))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BodyType.playerBody.rawValue
        self.physicsBody?.collisionBitMask = 0
        
        
        
        //Left Arm Punch
        playerLeftArm.position = CGPoint(x: -38, y: 55)
        playerLeftArm.zPosition = 1
        playerLeftArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerLeftArm.size.width/2.5, height: playerLeftArm.size.height * 1.10))
        playerLeftArm.physicsBody?.affectedByGravity = false
        playerLeftArm.physicsBody?.isDynamic = true
        playerLeftArm.physicsBody?.categoryBitMask = BodyType.playerArm.rawValue
        playerLeftArm.physicsBody?.collisionBitMask = 0
        playerLeftArm.physicsBody?.contactTestBitMask = BodyType.enemyBody.rawValue
       
        //Right Arm Punch
        playerRightArm.position = CGPoint(x: 31, y: 55)
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
            self.texture = SKTexture(imageNamed:"BearIdle")}
        if button.name == "leftPunch"{
            let addLeftPunch = SKAction.run{self.texture = SKTexture(imageNamed:"BearLeftPunch")}
            let addLeftArm = SKAction.run{self.addChild(self.playerLeftArm)}
            let removeLeftArm = SKAction.run{ self.playerLeftArm.removeFromParent()}
            self.run(SKAction.sequence([addLeftPunch, addLeftArm, waitPunch, removeLeftArm, addIdle]))
            
        }else if button.name == "rightPunch"{
            let addRightPunch = SKAction.run{self.texture = SKTexture(imageNamed:"BearRightPunch")}
            let addRightArm = SKAction.run({self.addChild(self.playerRightArm)})
            let removeRightArm = SKAction.run{ self.playerRightArm.removeFromParent()}
            self.run(SKAction.sequence([addRightPunch, addRightArm, waitPunch, removeRightArm, addIdle]))
            
        }else if button.name == "leftDodge"{
            let addLeftDodge = SKAction.run{self.texture = SKTexture(imageNamed:"BearLeftDodge")}
            let moveLeft = SKAction.move(to: CGPoint(x:screenSize.width * 0.368, y:screenSize.height * 0.385), duration: 0.00)
            let moveBack = SKAction.move(to: CGPoint(x: screenSize.width * 0.505, y: screenSize.height * 0.385), duration: 0.00)
            let leftDodgeGroup = SKAction.group([moveLeft,addLeftDodge])
            self.run(SKAction.sequence([leftDodgeGroup,waitDodge,moveBack,addIdle]))
            
        }else if button.name == "rightDodge"{
            let addRightDodge = SKAction.run{self.texture = SKTexture(imageNamed:"BearRightDodge")}
            let moveRight = SKAction.move(to: CGPoint(x:screenSize.width * 0.643, y:screenSize.height * 0.385), duration: 0.00)
            let moveBack = SKAction.move(to: CGPoint(x: screenSize.width * 0.505, y: screenSize.height * 0.385), duration: 0.00)
            let rightDodgeGroup = SKAction.group([moveRight,addRightDodge])
            self.run(SKAction.sequence([rightDodgeGroup,waitDodge,moveBack,addIdle]))
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
