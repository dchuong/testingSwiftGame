//
//  PointLabel.swift
//  myGame
//
//  Created by derrick on 9/9/14.
//  Copyright (c) 2014 derrick. All rights reserved.
//

import Foundation
import SpriteKit

class PointLabel :SKLabelNode {
    var number: Int = 0
    override init() {
        super.init()
    
    }
    
    override init(fontNamed fontName: String!) {
        super.init(fontNamed: fontName)
        self.text = "0"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addPoint() {
        self.number++
        self.text = String(self.number)
    }
    
    func setPoints(point: Int) {
        number = point
        self.text = String(self.number)
    }
    
    func reset (){
        self.text = "0"
        self.number = 0
    }
}