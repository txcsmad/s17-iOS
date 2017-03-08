//
//  FlappyScene.swift
//  FlappyBird
//
//  Created by Jesse Tipton on 3/7/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import SpriteKit

class FlappyScene: SKScene {

    private let birdNode: SKSpriteNode = {
        let birdTexture1 = SKTexture(image: #imageLiteral(resourceName: "Bird1"))
        birdTexture1.filteringMode = .nearest
        
        let birdTexture2 = SKTexture(image: #imageLiteral(resourceName: "Bird2"))
        birdTexture2.filteringMode = .nearest
        
        let birdNode = SKSpriteNode(texture: birdTexture1)
        birdNode.setScale(2)
        
        return birdNode
    }()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.backgroundColor = SKColor(red: 113.0 / 255.0, green: 197.0 / 255.0, blue: 207.0 / 255.0, alpha: 1.0)
        
        // Add bird
        self.addChild(birdNode)
        birdNode.position = self.frame.center
    }
    
}
