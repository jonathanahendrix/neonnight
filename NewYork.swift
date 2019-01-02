//
//  NewYork.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 2/4/18.
//  Copyright © 2018 Neon Night Riders. All rights reserved.
//

import SpriteKit

class NewYork: SKScene, SKPhysicsContactDelegate {
    let hud = HUD()
    var playerName:String = "benjamin"
    let player = Player()
    let enemy = Hobo()
    
    //let leftPunch = Echo().leftPunch
    //let controls = SKSpriteNode(imageNamed:"controllerBackground")
    //let background = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        
        hud.zPosition = 0
        hud.createHUDNodes(screenSize: self.size)
        self.addChild(hud)

        enemy.position = CGPoint(x:size.width/2, y:size.height * 0.728)
        enemy.zPosition = 2
        addChild(enemy)
        
        player.position = CGPoint(x: size.width/2, y: size.height * 0.413)
        player.zPosition = 2
        addChild(player)

        self.physicsWorld.contactDelegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches){
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            
            //hud.buttonPressed(button: nodeTouched as! SKSpriteNode )
            
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches){
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            //hud.buttonReleased(button: nodeTouched as! SKSpriteNode )
            
        }
    }
    
}

