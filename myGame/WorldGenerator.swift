//
//  WorldGenerator.swift
//  myGame
//
//  Created by derrick on 9/8/14.
//  Copyright (c) 2014 derrick. All rights reserved.
//

import Foundation
import SpriteKit

  var currentGroundX: Double!

class WorldGenerator : SKNode {
    var currentGroundX: Double!
    var currentObstacle: Double!
    var world: SKNode!
    let groundSize:Int = 50

    init(generateWorld: SKNode){
        super.init()
        self.currentGroundX = 0
        self.currentObstacle = 400
        self.world = generateWorld
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func populate () {
        for (var i = 0; i < 3; i++) {
            self.generate()
        }
    }
    
    //add the platform need to make it continuous
    func generate () {
        var ground:SKSpriteNode = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(self.scene.size.width, CGFloat(groundSize)))
        // go to bottom of the screen and add the ground
        ground.position = CGPointMake(CGFloat(self.currentGroundX), -self.scene.size.height/2 + ground.frame.size.height/2)
        // adding physics
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.size)
        ground.physicsBody.dynamic = false
        ground.name = "ground"
        self.world.addChild(ground)
        
        self.currentGroundX = Double(self.currentGroundX) + Double(ground.frame.size.width)
        
        //obstacle
        var obstacle:SKSpriteNode = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(40, 70))
        obstacle.position = CGPointMake(CGFloat(self.currentObstacle), ground.position.y + ground.frame.size.height/2
                            + obstacle.frame.size.height/2)
        obstacle.physicsBody = SKPhysicsBody(rectangleOfSize: obstacle.size)
        obstacle.physicsBody.dynamic = false
        obstacle.name = "obstacle"
        self.world.addChild(obstacle)
        self.currentObstacle = self.currentObstacle + 200
        
    }
    
}