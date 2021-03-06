//
//  FlappyScene.swift
//  FlappyBird
//
//  Created by Jesse Tipton on 3/7/17.
//  Copyright © 2017 MAD. All rights reserved.
//

import SpriteKit

extension CGRect {
    
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
    
}

class FlappyScene: SKScene {

    private let birdNode: SKSpriteNode = {
        let birdTexture1 = SKTexture(image: #imageLiteral(resourceName: "Bird1"))
        birdTexture1.filteringMode = .nearest
        
        let birdTexture2 = SKTexture(image: #imageLiteral(resourceName: "Bird2"))
        birdTexture2.filteringMode = .nearest

        let birdNode = SKSpriteNode(texture: birdTexture1)
        birdNode.setScale(2)
        
        let flapAction = SKAction.animate(with: [birdTexture2, birdTexture1], timePerFrame: 0.2)
        let flapForeverAction = SKAction.repeatForever(flapAction)
        birdNode.run(flapForeverAction)
        
        birdNode.physicsBody = SKPhysicsBody(texture: birdTexture1, size: birdNode.size)
        birdNode.physicsBody?.isDynamic = true
        birdNode.physicsBody?.allowsRotation = false
        
        return birdNode
    }()
    
    private func setUpGround() {
        let groundTexture = SKTexture(image: #imageLiteral(resourceName: "Ground"))
        groundTexture.filteringMode = .nearest
        
        // Actions for moving the ground nodes
        let moveGroundAction = SKAction.moveBy(x: -groundTexture.size().width * 2, y: 0, duration: 1)
        let resetGroundAction = SKAction.moveBy(x: groundTexture.size().width * 2, y: 0, duration: 0)
        let groundSequenceAction = SKAction.sequence([moveGroundAction, resetGroundAction])
        let moveGroundForeverAction = SKAction.repeatForever(groundSequenceAction)
        
        // How many ground nodes we'll need to cover the screen
        let groundCount = Int(ceil(frame.size.width / (groundTexture.size().width * 2))) + 1
        
        for n in 0..<groundCount {
            let groundNode = SKSpriteNode(texture: groundTexture)
            groundNode.setScale(2)
            
            groundNode.position = CGPoint(x: CGFloat(n) * groundNode.size.width + (groundNode.size.width / 2), y: groundNode.size.height / 2)
            
            groundNode.physicsBody = SKPhysicsBody(rectangleOf: groundNode.size)
            groundNode.physicsBody?.isDynamic = false
            
            groundNode.run(moveGroundForeverAction)
            
            self.addChild(groundNode)
        }
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.backgroundColor = SKColor(red: 113.0 / 255.0, green: 197.0 / 255.0, blue: 207.0 / 255.0, alpha: 1.0)
        
        // World physics
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        // Add bird
        self.addChild(birdNode)
        birdNode.position = self.frame.center
        
        // Add ground
        self.setUpGround()
    }
    
    override func update(_ currentTime: TimeInterval) {
        func clamp(min: CGFloat, max: CGFloat, value: CGFloat) -> CGFloat {
            if value > max {
                return max
            } else if value < min {
                return min
            } else {
                return value
            }
        }
        
        let value = birdNode.physicsBody!.velocity.dy * (birdNode.physicsBody!.velocity.dy < 0 ? 0.003 : 0.001)
        birdNode.zRotation = clamp(min: -1, max: 0.5, value: value)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        birdNode.physicsBody?.velocity = .zero
        birdNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10))
    }
    
}
