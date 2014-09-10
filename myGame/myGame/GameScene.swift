//
//  GameScene.swift
//  myGame
//
//  Created by derrick on 8/28/14.
//  Copyright (c) 2014 derrick. All rights reserved.
//

import SpriteKit

enum ColliderType: UInt32 {
    case playerCate = 1
    case obstacleCate = 2
    case groundCate = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player:Player!
    var world: SKNode!
    var isStarted: Bool! = false
    var isGameOver: Bool! = false
    var generator: WorldGenerator!
    let FONT_TYPE:String = "Arial"
    let FONT_SIZE:CGFloat = 24 as CGFloat
    
    override func didMoveToView(view: SKView) {
        let groundSize:Int = 50
        //initial anchor point start at the bottom left of the screen (make anchor point to the middle)
        
        self.anchorPoint = CGPointMake(0.5, 0.5)
        self.backgroundColor = SKColor(red: 0.684, green: 0.9, blue: 0.8964, alpha: 1.0)
        self.physicsWorld.contactDelegate = self
        
        self.world = SKNode()
        println(self.world.position.x)
        self.addChild(world)
    
        // generate the platform
        self.generator = WorldGenerator(generateWorld: world)
        self.addChild(generator)
        self.generator.populate()

        // add the player
        player = createPlayer()
        world.addChild(player)
        
        // labels
        var pointLabel: PointLabel = PointLabel(fontNamed: FONT_TYPE)
        pointLabel.position = CGPointMake(0,100)
        self.addChild(pointLabel)
        
        var startLabel: SKLabelNode = SKLabelNode(fontNamed: FONT_TYPE)
        startLabel.text = "Tap to Start"
        startLabel.fontSize = FONT_SIZE
        startLabel.name = "startLabel"
        startLabel.position = CGPointMake(0, 35)
        self.addChild(startLabel)
        pulseAnimation(startLabel)
        
        loadClouds()
    }
    
    override func didSimulatePhysics() {
        centerTheNode(self.player)
        handlePoints()
        handleObstacle()

    }
    
    func handlePoints() {
        self.world.enumerateChildNodesWithName("obstacle", usingBlock: {
            node, stop in
            // do something with node or stop
            if ( node.position.x  < self.player.position.x) {
                var pointLabel: PointLabel = self.childNodeWithName("PointLabel") as PointLabel
                pointLabel.addPoint()
            }
        })
    }
    
    func handleObstacle() {
        //go through all the child nodes with the name obstacle
        self.world.enumerateChildNodesWithName("obstacle", usingBlock: {
            node, stop in
            // do something with node or stop
            if ( node.position.x  < self.player.position.x) {
                println("here")
                node.name = "obstacle_cancel"
                self.generator.generate()
            }
        })
    }
    
    // need work
    func handleCleanObstale() {
        self.world.enumerateChildNodesWithName("obstacle_cancel", usingBlock: {
            node, stop in
            // do something with node or stop
            if ( node.position.x  < self.player.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
                
            }
        })
    }
    
    func createPlayer() -> Player {
        //Add physic to the player and facial textures
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
        self.world.position = CGPointMake(self.world.position.x - positionInScene.x, 0)
    }

    func start () {
        self.childNodeWithName("startLabel").removeFromParent()
        self.isStarted = true
        player.start()
    }
    
    func clear() {
        var gameScene: GameScene = GameScene(size: self.frame.size)
        self.view.presentScene(gameScene)
    }
    
    func gameOver() {
        self.isGameOver = true
        var gameOverLabel: SKLabelNode = SKLabelNode(fontNamed: FONT_TYPE)
        gameOverLabel.text = "Game Over"
        gameOverLabel.position = CGPointMake(0, 50)
        
        var resetLabel: SKLabelNode = SKLabelNode(fontNamed: FONT_TYPE)
        resetLabel.text = "Tap to Reset"
        resetLabel.fontSize = FONT_SIZE
        resetLabel.name = "resetLabel"
        resetLabel.position = CGPointMake(0, 10)
        self.addChild(resetLabel)
        self.addChild(gameOverLabel)
        pulseAnimation(resetLabel)
        player.stop()
        
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
    
    func didBeginContact(contact: SKPhysicsContact!) {
        gameOver()
    }
    
    /*         ANIMATION & BACKGROUND          */
    func pulseAnimation(node:SKNode) {
        var disappear: SKAction = SKAction.fadeAlphaTo(0.0, duration: 0.7)
        var appear: SKAction = SKAction.fadeAlphaTo(1.0, duration: 0.7)
        var pulseAction: SKAction = SKAction.sequence([disappear,appear])
        node.runAction(SKAction.repeatActionForever(pulseAction))
    }
    
    func loadClouds() {
        var cloud: SKShapeNode = SKShapeNode()
        //create the shape
        cloud.path = UIBezierPath(ovalInRect: CGRectMake(90, 10, 100, 40)).CGPath
        cloud.fillColor = UIColor.grayColor()
        cloud.strokeColor = UIColor.blackColor()
        self.world.addChild(cloud)
        
    }
}
