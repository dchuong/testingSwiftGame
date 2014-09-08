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
    var isStarted: Bool! = false
    var isGameOver: Bool! = false
    var generator: WorldGenerator!
    
    override func didMoveToView(view: SKView) {
        let groundSize:Int = 50
        //initial anchor point start at the bottom left of the screen (make anchor point to the middle)
        self.anchorPoint = CGPointMake(0.5, 0.5)
        self.backgroundColor = SKColor.blackColor()
        
        self.world = SKNode()
        println(self.world.position.x)
        self.addChild(world)
    
        self.generator = WorldGenerator(generateWorld: world)
        self.addChild(generator)
        self.generator.populate()

        // add the player
        player = createPlayer()
        world.addChild(player)
    }
    
    override func didSimulatePhysics() {
        centerTheNode(self.player)
    }
    
    func createPlayer() -> Player {
        player = Player(texture: nil, color: UIColor.redColor(), size: CGSizeMake(40, 40))
        player.addPhysicsBody()
        var leftEye: SKSpriteNode = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(5, 5))
        leftEye.position = CGPointMake(-10, 8)
        var rightEye: SKSpriteNode = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(5, 5))
        rightEye.position = CGPointMake(10, 8)
        var mouth: SKSpriteNode = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(30, 5))
        mouth.position = CGPointMake(0, -10)
        player.addChild(leftEye)
        player.addChild(rightEye)
        player.addChild(mouth)
        
        return player

    }
    func centerTheNode(node: SKNode) {
        var positionInScene: CGPoint = self.convertPoint(node.position, fromNode: node.parent)
        self.world.position = CGPointMake(self.world.position.x - positionInScene.x, self.world.position.y - positionInScene.y)
    }

    func start () {
        println("start")
        self.isStarted = true
        player.start()
    }
    
    func clear() {
        println("clear")
        
    }
    
    func gameOver() {
        println("game over")
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        if (!self.isStarted) {
            start()
        }
        else if (self.isGameOver == true){
            clear()
        }
        else {
            player.jump()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
