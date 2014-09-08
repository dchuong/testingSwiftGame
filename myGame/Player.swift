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
    

    override init(texture: SKTexture?,  color: UIColor?,  size: CGSize)
    {
        super.init(texture: texture, color: color, size: size)
        name = "player"
    }

    /*
    convenience init(color: UIColor, size: CGSize) {
        self.init(color: color, size: size)
    }
    */
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
}