//
//  Player.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 1/26/18.
//  Copyright © 2018 Neon Night Riders. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode{
    var playerImage:SKTexture =
        SKTexture(imageNamed:"BenjaminIdle" )
    //var player: String = "Benjamin"
    var playerLeftArm = SKSpriteNode()
    var playerRightArm = SKSpriteNode()
    init() {
        super.init(texture: playerImage, color: UIColor.clear, size: playerImage.size())
    
        
     
    //Left Arm Punch
   // playerLeftArm.position = CGPoint(x: , y: size.height * 0.52)
    playerLeftArm.zPosition = 1
    playerLeftArm.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerLeftArm.size.width/2.5, height: playerLeftArm.size.height * 1.10))
    playerLeftArm.physicsBody?.affectedByGravity = false
    playerLeftArm.physicsBody?.isDynamic = true
    playerLeftArm.physicsBody?.categoryBitMask = BodyType.playerArm.rawValue
    playerLeftArm.physicsBody?.collisionBitMask = 0
    playerLeftArm.physicsBody?.contactTestBitMask = BodyType.enemyBody.rawValue
    
        
        
    }
    
    func playerActions( button: SKSpriteNode, screenSize: CGSize){
        
        print("\(String(describing: button.name))")
        let waitPunch = SKAction.wait( forDuration: 0.15)
        let waitDodge = SKAction.wait(forDuration: 0.5)
        let addIdle = SKAction.run {
            self.texture = SKTexture(imageNamed:"Idle")}
        if button.name == "leftPunch"{
            print("I'm in the player Actions")
            let addLeftPunch = SKAction.run{self.texture = SKTexture(imageNamed:"LeftPunch")}
            
            let addLeftArm = SKAction.run{self.addChild(self.playerLeftArm)}
            
            let removeLeftArm = SKAction.run{ self.playerLeftArm.removeFromParent()}
            
            self.run(SKAction.sequence([addLeftPunch, addLeftArm, waitPunch, removeLeftArm, addIdle]))
    
        }else if button.name == "rightPunch"{
            //let addRightArm = SKAction.run({self.addChild(self.playerRightArm)})
        
        }else if button.name == "leftDodge"{
            let addLeftDodge = SKAction.run{self.texture = SKTexture(imageNamed:"LeftDodge")}
            let moveLeft = SKAction.move(to: CGPoint(x:screenSize.width * 0.369, y:screenSize.height * 0.415), duration: 0.00)
            let moveBack = SKAction.move(to: CGPoint(x: screenSize.width/2, y: screenSize.height * 0.413), duration: 0.00)
            let leftDodgeGroup = SKAction.group([moveLeft,addLeftDodge])
            self.run(SKAction.sequence([leftDodgeGroup,waitDodge,moveBack,addIdle]))
        
        }else if button.name == "rightDodge"{
            let addRightDodge = SKAction.run{self.texture = SKTexture(imageNamed:"RightDodge")}
            let moveRight = SKAction.move(to: CGPoint(x:screenSize.width * 0.63, y:screenSize.height * 0.413), duration: 0.00)
            let moveBack = SKAction.move(to: CGPoint(x: screenSize.width/2, y: screenSize.height * 0.413), duration: 0.00)
            let rightDodgeGroup = SKAction.group([moveRight,addRightDodge])
            self.run(SKAction.sequence([rightDodgeGroup,waitDodge,moveBack,addIdle]))
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
