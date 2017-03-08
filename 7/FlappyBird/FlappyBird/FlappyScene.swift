//
//  FlappyScene.swift
//  FlappyBird
//
//  Created by Jesse Tipton on 3/7/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import SpriteKit

class FlappyScene: SKScene {

    private var birdNode: SKSpriteNode?
    
    private func setUpBird() {
        let 
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.backgroundColor = SKColor(red: 113.0 / 255.0, green: 197.0 / 255.0, blue: 207.0 / 255.0, alpha: 1.0)
        
        setUpBird()
    }
    
}
