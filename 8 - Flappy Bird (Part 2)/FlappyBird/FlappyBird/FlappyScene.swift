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

    // category bit mask: what am i
    // contact test bit mask: what should i notify when contact is made
    // collision bit mask: what should i actually collide with
    
    static let birdCategory: UInt32 = 1 << 0     // 0x0001
    static let obstacleCategory: UInt32 = 1 << 1 // 0x0010
    static let scoreCategory: UInt32 = 1 << 2    // 0x0100
    
    var score = 0
    weak var flappyDelegate: FlappySceneDelegate?
    
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
        birdNode.physicsBody?.categoryBitMask = birdCategory
        birdNode.physicsBody?.contactTestBitMask = obstacleCategory
        birdNode.physicsBody?.collisionBitMask = scoreCategory
        
        return birdNode
    }()
    
    
    // MARK: - Set up pipes
    
    /// Sets up the pipes.
    func setUpPipes() {
        // get textures
        let bottomPipeTexture = SKTexture(image: #imageLiteral(resourceName: "PipeBottom"))
        bottomPipeTexture.filteringMode = .nearest
        
        let topPipeTexture = SKTexture(image: #imageLiteral(resourceName: "PipeTop"))
        topPipeTexture.filteringMode = .nearest
        
        // create nodes
        let bottomPipeNode = SKSpriteNode(texture: bottomPipeTexture)
        bottomPipeNode.setScale(2)
        bottomPipeNode.physicsBody = SKPhysicsBody(texture: bottomPipeTexture, size: bottomPipeNode.size)
        bottomPipeNode.physicsBody?.isDynamic = false
        
        let topPipeNode = SKSpriteNode(texture: topPipeTexture)
        topPipeNode.setScale(2)
        topPipeNode.physicsBody = SKPhysicsBody(texture: topPipeTexture, size: topPipeNode.size)
        topPipeNode.physicsBody?.isDynamic = false
        
        // unified pipe node
        let pipePair = SKNode()
        pipePair.addChild(bottomPipeNode)
        pipePair.addChild(topPipeNode)
        
        // score node
        let scoreNode = SKNode()
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: 9999))
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = FlappyScene.scoreCategory
        scoreNode.physicsBody?.contactTestBitMask = FlappyScene.birdCategory
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.zPosition = 2
        pipePair.addChild(scoreNode)
        
        // random y position
        let pipeY = CGFloat(Int(arc4random()) % Int(frame.size.height / 3))
        
        bottomPipeNode.position = CGPoint(x: 0, y: pipeY)
        topPipeNode.position = CGPoint(x: 0, y: bottomPipeNode.size.height + pipeY + 200)
        
        pipePair.position = CGPoint(x: self.frame.size.width + bottomPipeNode.size.width, y: 0)
        pipePair.zPosition = -1
        
        // move pipes
        let movesPipesAction = SKAction.moveBy(x: -1, y: 0, duration: 0.01)
        let movePipesForeverAction = SKAction.repeatForever(movesPipesAction)
        pipePair.run(movePipesForeverAction)
        
        // add pipes to scene
        self.addChild(pipePair)
    }
    
    
    // MARK: - Set up ground
    
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
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        // Add bird
        self.addChild(birdNode)
        birdNode.position = self.frame.center
        
        // Add ground
        self.setUpGround()
        
        // Spawn pipes
        let spawnPipesAction = SKAction.perform(#selector(setUpPipes), onTarget: self)
        let delayAction = SKAction.wait(forDuration: 3)
        let spawnPipesAndWaitAction = SKAction.sequence([spawnPipesAction, delayAction])
        let spawnPipesForeverAction = SKAction.repeatForever(spawnPipesAndWaitAction)
        self.run(spawnPipesForeverAction)
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


// MARK: - SKPhysicsContactDelegate

extension FlappyScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == FlappyScene.scoreCategory || contact.bodyB.categoryBitMask == FlappyScene.scoreCategory {
            // we've hit a score node
            
            // remove score node so we don't get notified again
            if contact.bodyA.categoryBitMask == FlappyScene.scoreCategory {
                if let node = contact.bodyA.node {
                    node.removeFromParent()
                } else {
                    return
                }
            }
            
            if contact.bodyB.categoryBitMask == FlappyScene.scoreCategory {
                if let node = contact.bodyB.node {
                    node.removeFromParent()
                } else {
                    return
                }
            }
            
            // increment score
            score += 1
            print(score)
        } else {
            // we've hit something other than a score node (i.e. an obstacle)
            // GAME OVER
            self.isPaused = true
            flappyDelegate?.gameEnded(with: score)
            score = 0
        }
    }
    
}


protocol FlappySceneDelegate: class {
    
    func gameEnded(with score: Int)
    
}
