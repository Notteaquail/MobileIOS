//
//  mineScene.swift
//  GoldMiner
//
//  Created by apple on 2019/11/30.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class mineScene: SKScene , SKPhysicsContactDelegate{
    
    //MARK: Properties
    private var contentCreated = false
    private var got = false
    
    private var hook: SKSpriteNode?
    private var sPos: CGPoint?
    private var line: SKSpriteNode?
    private var miner: SKSpriteNode?
    private var gold3: SKSpriteNode?
    private var coinCountNode: SKLabelNode?
    private var treasures = [Treasure]()
    
    
    let myHookBitMask: UInt32 = 0x0001
    let myOBJBitMask: UInt32 = 0x0002
    
    
    let shakeAction = SKAction.repeatForever(SKAction.sequence([SKAction.rotate(toAngle: CGFloat(2*Double.pi-2.5/2), duration: 1, shortestUnitArc: true),SKAction.rotate(toAngle: CGFloat(2.5/2), duration: 2, shortestUnitArc: true),SKAction.rotate(toAngle: CGFloat(0), duration: 1, shortestUnitArc: true)]))
    
    
    var coinCount = 0
    
    //MARK: Actions
    override func didMove(to view: SKView) {
        if self.contentCreated == false {
            self.createSceneContents()
            self.contentCreated = true
        }
        
        self.physicsWorld.contactDelegate = self
    }
    
    
    // Create Scene Contents
    
    func createSceneContents(){
        // Config
        
        //self.backgroundColor = SKColor.yellow
        self.scaleMode = SKSceneScaleMode.fill
        
        
        
        
        //Create background
        let backgroundImage = SKSpriteNode(imageNamed: "level-background-0", normalMapped: true)
        backgroundImage.position = CGPoint(x: 0, y: -60)
        backgroundImage.size = CGSize(width: self.frame.width, height: self.frame.height-120)
        self.addChild(backgroundImage)
        
        let backgroundHead = SKSpriteNode(imageNamed: "level-background-header")
        backgroundHead.position = CGPoint(x:0, y:self.frame.height/2-60)
        backgroundHead.size = CGSize(width: self.frame.width, height: 120)
        self.addChild(backgroundHead)
        
        
        //Create sprites
        
        // Miner
        let miner = SKSpriteNode(imageNamed: "workup4")
        miner.position = CGPoint(x: 0, y: self.frame.height/2-70)
        miner.size = CGSize(width: 50, height: 80)
        self.addChild(miner)
        self.miner = miner
        
        
        // Treasures
        let gold3 = SKSpriteNode(imageNamed: "ObjGlod3_1")
        gold3.position = CGPoint(x: 0, y: 0)
        gold3.size = CGSize(width: 50, height: 50)
        gold3.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        gold3.physicsBody = SKPhysicsBody(rectangleOf: gold3.size)
        gold3.physicsBody?.isDynamic = false
        gold3.physicsBody?.contactTestBitMask = self.myOBJBitMask
        self.addChild(gold3)
        self.gold3 = gold3
        
        /*let gold3 = Treasure(imageName: "ObjGlod3_1", x: 0, y: 0, width: 50, height: 50)
        self.addChild(gold3.getTreasureNode()!)
        self.treasures.append(gold3)*/
        
        
        // Hook line
        /*let path = UIBezierPath()
        path.move(to: CGPoint(x: miner.position.x, y: miner.position.y-20))
        //path.move(to: CGPoint(x: 0, y: 0))
        //path.addLine(to: CGPoint(x: 0, y: -15))
        path.addLine(to: CGPoint(x: miner.position.x, y: miner.position.y-40))
        path.close()
        let line = SKSpriteNode(imageNamed: "line")
        line.anchorPoint = CGPoint(x: 0.5, y: 1)
        line.position = CGPoint(x: miner.position.x, y: miner.position.y-20)
        line.size = CGSize(width: 20, height: 20)*/
        
        
        // Hook
        let hook1 = SKSpriteNode(imageNamed: "hook1")
        let hook2 = SKSpriteNode(imageNamed: "hook2")
        hook1.size = CGSize(width: 20, height: 30)
        hook2.size = CGSize(width: 20, height: 30)
        hook1.position = CGPoint(x: miner.position.x, y: miner.position.y-20)
        hook2.position = CGPoint(x: 0, y: 0)
        //hook1.position = CGPoint(x: 0, y: -30)
        hook1.anchorPoint = CGPoint(x: 0.5, y: 1)
        hook2.anchorPoint = CGPoint(x: 0.5, y: 1)
        hook1.zPosition = 0
        hook2.zPosition = 2
        
        hook1.physicsBody = SKPhysicsBody(rectangleOf: hook1.size)
        hook1.physicsBody?.affectedByGravity = false
        hook1.physicsBody?.contactTestBitMask = self.myHookBitMask
        
        self.addChild(hook1)
        hook1.addChild(hook2)
        //self.addChild(line)
        self.hook = hook1
        self.sPos = (hook?.position)!
        //self.line = line
        
        
        // coin
        let coinIcon = SKSpriteNode(imageNamed: "coin")
        coinIcon.size = CGSize(width: 50, height: 50)
        coinIcon.position = CGPoint(x: -self.frame.width/2+25, y: self.frame.height/2-25)
        self.addChild(coinIcon)
        
        let coinCount = SKLabelNode(text: String(self.coinCount))
        coinCount.fontColor = UIColor.green
        coinCount.fontSize = 42
        coinCount.position = CGPoint(x: -self.frame.width/2+60, y: self.frame.height/2-35)
        self.coinCountNode = coinCount
        self.addChild(coinCount)
        
        
        // HookAction
        //hookAction()
        hook1.run(shakeAction)
        
        
    
    }
    
    //MARK: Action
    
    
    
    //MARK: TouchEvent
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.line?.run(SKAction.scale(by: 10, duration: 1))
        //suspension = false
        let r = (hook?.zRotation)!
        let goAction = SKAction.repeatForever(SKAction.move(by: CGVector(dx: 50*sin(r), dy: -50*cos(r)), duration: 0.5))
        hook?.removeAllActions()
        self.hook?.run(goAction)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let returnAction = SKAction.move(to: (self.sPos)!, duration: 1)
        
        hook?.removeAllActions()
        self.hook?.run(returnAction)
        
        let addScores = SKAction.run {
            if self.got {
                self.gold3?.removeFromParent()
                self.coinCount += 1
                self.coinCountNode?.text = String(self.coinCount)
                print(self.coinCount)
                self.got = false
            }
        }
        self.hook?.run(SKAction.sequence([SKAction.wait(forDuration: 1), addScores, self.shakeAction]))
    }

    
    //MARK: Contact
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("contactBegin")
        gold3?.removeFromParent()
        gold3?.position = CGPoint(x: 0, y: -15)
        gold3?.physicsBody = nil
        hook?.addChild(gold3!)
        gold3?.zPosition = 1
        got = true
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("contactEnd")
        
    }
}
