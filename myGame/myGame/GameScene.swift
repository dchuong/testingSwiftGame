//
//  GameScene.swift
//  myGame
//
//  Created by derrick on 8/28/14.
//  Copyright (c) 2014 derrick. All rights reserved.
//

import SpriteKit



class GameScene: SKScene {
    
    var player:Player!
    var world: SKNode!
    
    override func didMoveToView(view: SKView) {
        let groundSize:Int = 50
        //initial anchor point start at the bottom left of the screen (make anchor point to the middle)
        self.anchorPoint = CGPointMake(0.5, 0.5)
        self.backgroundColor = SKColor.blackColor()
        
        self.world = SKNode()
        println(self.world.position.x)
        self.addChild(world)
        
        var ground:SKSpriteNode = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(self.frame.size.width, CGFloat(groundSize)))
        // go to bottom of the screen and add the ground
        ground.position = CGPointMake(0, -self.frame.size.height/2 + ground.frame.size.height/2)
        // adding physics
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
        ground.physicsBody.dynamic = false
        world.addChild(ground)
        
        // add the player
        player = Player(texture: nil, color: UIColor.redColor(), size: CGSizeMake(40, 40))
        player.addPhysicsBody()
        world.addChild(player)
    }
    
    override func didSimulatePhysics() {
        centerTheNode(self.player)
    }
    
    func centerTheNode(node: SKNode) {
        var positionInScene: CGPoint = self.convertPoint(node.position, fromNode: node.parent)
        self.world.position = CGPointMake(self.world.position.x - positionInScene.x, self.world.position.y - positionInScene.y)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        //type case to a player
        player.walkRight()
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
