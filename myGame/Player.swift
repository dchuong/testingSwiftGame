//
//  Player.swift
//  myGame
//
//  Created by derrick on 8/28/14.
//  Copyright (c) 2014 derrick. All rights reserved.
//

import Foundation
import SpriteKit

class Player : SKSpriteNode {
    
    let duration: Double = 0.005
    override init(texture: SKTexture?,  color: UIColor?,  size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
        name = "player"
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
    }
    
    func walkRight() {
        var right = SKAction.moveByX(10, y: 0, duration: 0)
        self.runAction(right)
    }
    
    func jump () {
        self.physicsBody.applyImpulse(CGVector(0,40))
    }
    
    func start () {
        var moveRight: SKAction = SKAction.moveByX(1.0, y: 0, duration: duration)
        var repeatMoveRight:SKAction = SKAction.repeatActionForever(moveRight)
        self.runAction(repeatMoveRight)
    }
}