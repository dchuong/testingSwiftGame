//
//  GameData.swift
//  myGame
//
//  Created by derrick on 9/10/14.
//  Copyright (c) 2014 derrick. All rights reserved.
//

import Foundation

class GameData {
    var filePath: NSString!
    var highScore:Int!
    var data:NSData!
    
    init() {
        filePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        var fileName: NSString = "archive.data"
        self.filePath = filePath.stringByAppendingPathComponent(fileName)
    }
    
    func save() {
        var data: NSData = NSKeyedArchiver.archivedDataWithRootObject(highScore)
        data.writeToFile(self.filePath, atomically: true)
        
    }
    
    //it will crash if the data is nil
    func load() {
        println(self.filePath)
        if (NSData.dataWithContentsOfFile(self.filePath, options: nil, error: nil) != nil) {
            self.data = NSData.dataWithContentsOfFile(self.filePath, options: nil, error: nil) as NSData
            var number = NSKeyedUnarchiver.unarchiveObjectWithData(data) as NSNumber
            var highestScoreObject = NSKeyedUnarchiver.unarchiveObjectWithData(data) as NSNumber
            self.highScore = highestScoreObject as Int
        }
        else {
            self.highScore = 0
        }
    }
}