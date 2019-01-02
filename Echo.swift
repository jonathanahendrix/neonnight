//
//  Echo.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 1/30/18.
//  Copyright © 2018 Neon Night Riders. All rights reserved.
//

import SpriteKit

class Echo: SKSpriteNode {
    
    var textureImage:SKTexture =
        SKTexture(imageNamed:"EchoIdle" )
    var tell1 = SKAction()
    var tell2 = SKAction()
    var tell3 = SKAction()
    var punchRight = SKAction()
    var punchLeft = SKAction()
    var rightPunch = SKSpriteNode(imageNamed:"EchoRightArm")
    var leftPunch = SKSpriteNode(imageNamed:"EchoLeftArm")
    var idle = SKAction()
    var enemyDamage = SKSpriteNode(imageNamed:"enemyDamage")
    var maxHitAmount:Int = 1500
    
    
    init(){
        
        super.init(texture:textureImage,color:UIColor.clear, size:textureImage.size())
        
        //Enemy's physical body
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width/2, height: size.height/1.75))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BodyType.enemyBody.rawValue
        self.physicsBody?.collisionBitMask = 0
        
        //Enemy's physical left arm
        leftPunch.position = CGPoint(x:-21, y:-17)
        leftPunch.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftPunch.size.width/2, height: leftPunch.size.height*2))
        leftPunch.physicsBody?.affectedByGravity = false
        leftPunch.physicsBody?.isDynamic = true
        leftPunch.physicsBody?.categoryBitMask = BodyType.enemyArm.rawValue
        leftPunch.physicsBody?.collisionBitMask = 0
        leftPunch.physicsBody?.contactTestBitMask = BodyType.playerBody.rawValue
        
        //Enemy's physical right arm
        rightPunch.position = CGPoint(x:21, y:-14)
        rightPunch.zPosition = 1
        rightPunch.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightPunch.size.width/2, height: rightPunch.size.height * 2))
        rightPunch.physicsBody?.affectedByGravity = false
        rightPunch.physicsBody?.isDynamic = true
        rightPunch.physicsBody?.categoryBitMask = BodyType.enemyArm.rawValue
        rightPunch.physicsBody?.collisionBitMask = 0
        rightPunch.physicsBody?.contactTestBitMask = BodyType.playerBody.rawValue
        //addChild(rightPunch)
        // Creates tells and arms.
        createTell1()
        createTell2()
        createTell3()
        createLeftPunch()
        createRightPunch()
        createIdle()
        
        //Runs the enemy action
        enemyAction()
        
    }//<--- End of Init()
    func enemyAction(){
        self.run(SKAction.repeatForever(SKAction.sequence([idle, tell1,punchLeft,idle,tell2,punchRight,idle,tell3,punchLeft,idle,tell2,punchLeft,tell1, punchRight])))
    }
    
    func createIdle(){
        let addIdle = SKAction.run {self.texture = SKTexture(imageNamed:"EchoIdle")}
        let wait2 = SKAction.wait(forDuration: 1.40)
        idle = SKAction.sequence([addIdle,wait2])
        
    }
    func createTell1(){
        let addTell = SKAction.run {self.texture = SKTexture(imageNamed:"EchoTell1") }
        let wait3 = SKAction.wait(forDuration: 0.50)
        tell1 = SKAction.sequence([addTell,wait3])
    }
    
    func createTell2(){
        let addTell = SKAction.run {self.texture = SKTexture(imageNamed:"EchoTell2") }
        let wait3 = SKAction.wait(forDuration: 0.50)
        
        tell2 = SKAction.sequence([addTell,wait3])
    }
    
    func createTell3(){
        let addTell = SKAction.run {self.texture = SKTexture(imageNamed:"EchoTell3") }
        let wait3 = SKAction.wait(forDuration: 0.50)
        tell3 = SKAction.sequence([addTell,wait3])
    }
    
    func createLeftPunch(){
        let addPunch = SKAction.run {self.texture = SKTexture(imageNamed:"EchoLeftPunch") }
        let addLeftArm = SKAction.run{self.addChild(self.leftPunch)}
        let wait3 = SKAction.wait(forDuration: 0.50)
        let groupAdd = SKAction.group([addPunch,addLeftArm])
        let removeLeftArm = SKAction.run{self.leftPunch.removeFromParent()}
        
        punchLeft = SKAction.sequence([groupAdd,wait3,removeLeftArm])
    }
    
    func createRightPunch(){
        let addPunch = SKAction.run {self.texture = SKTexture(imageNamed:"EchoRightPunch") }
        let addRightArm = SKAction.run{self.addChild(self.rightPunch)}
        let wait3 = SKAction.wait(forDuration: 0.50)
        let groupAdd = SKAction.group([addPunch,addRightArm])
        let removeRightArm = SKAction.run{self.rightPunch.removeFromParent()}
        
        punchRight = SKAction.sequence([groupAdd,wait3,removeRightArm])
    }
    func enemyHit(){
        let enemyHit = SKAction.run{self.addChild(self.enemyDamage)}
        let wait = SKAction.wait(forDuration: 0.1)
        let removeDamage = SKAction.run({self.enemyDamage.removeFromParent()})
        self.run(SKAction.sequence([enemyHit, wait, removeDamage]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



