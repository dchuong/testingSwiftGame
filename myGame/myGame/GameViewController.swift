//
//  GameViewController.swift
//  myGame
//
//  Created by derrick on 8/28/14.
//  Copyright (c) 2014 derrick. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {

    var backGroundMusicPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Pick a size for the scene */
            // Configure the view.
        let skView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        let scene = GameScene(size: CGSizeMake(skView.frame.size.width, skView.frame.size.height))
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
        playMusic()
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // **** MUSIC **** //
    func playMusic() {
        var backgroundMusicURL: NSURL = NSBundle.mainBundle().URLForResource("gateofhell", withExtension: "mp3")
        backGroundMusicPlayer = AVAudioPlayer(contentsOfURL: backgroundMusicURL, error: nil)
        backGroundMusicPlayer.numberOfLoops = -1
        backGroundMusicPlayer.volume = 0.3
        backGroundMusicPlayer.play()

    }
}
