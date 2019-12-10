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



//SCENE SIZE = 320*568
class mineScene: SKScene , SKPhysicsContactDelegate{
    
    //MARK: Properties
    private var contentCreated = false
    private var got = false
    
    private var hook: SKSpriteNode?
    private var sPos: CGPoint?
    private var line: SKSpriteNode?
    private var miner: SKSpriteNode?
    //private var gold3: SKSpriteNode?
    private var coinCountNode: SKLabelNode?
    private var treasures: Treasures?
    
    
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
        
        
        
        
        
        //Create background
        let backgroundImage = SKSpriteNode(imageNamed: "level-background-0")
        backgroundImage.position = CGPoint(x: 0, y: -40)
        backgroundImage.size = CGSize(width: self.frame.width, height: self.frame.height-80)
        self.addChild(backgroundImage)
        
        let backgroundHead = SKSpriteNode(imageNamed: "level-background-header")
        backgroundHead.position = CGPoint(x:0, y:self.frame.height/2-40)
        backgroundHead.size = CGSize(width: self.frame.width, height: 80)
        self.addChild(backgroundHead)
        
        
        //Create sprites
        
        // Miner
        let miner = SKSpriteNode(imageNamed: "workup4")
        miner.position = CGPoint(x: 0, y: self.frame.height/2-40)
        miner.size = CGSize(width: 70, height: 70)
        self.addChild(miner)
        self.miner = miner
        
        
        // Treasures
        /*let gold3 = SKSpriteNode(imageNamed: "ObjGlod3_1")
        gold3.position = CGPoint(x: 0, y: 0)
        gold3.size = CGSize(width: 50, height: 50)
        gold3.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        gold3.physicsBody = SKPhysicsBody(rectangleOf: gold3.size)
        gold3.physicsBody?.isDynamic = false
        gold3.physicsBody?.contactTestBitMask = self.myOBJBitMask
        self.addChild(gold3)
        self.gold3 = gold3*/
        
        treasures = Treasures()
        
        
        // round 1
        var index = treasures?.addNode(imageName: "ObjStone1", x: 20, y: -70)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold1", x: -50, y: 0)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold3", x: -40, y: -100)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjStone2", x: -70, y: -40)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjStone1", x: -110, y: -85)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjStone2", x: -120, y: 20)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold1", x: -140, y: 45)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold2", x: -200, y: 35)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold3", x: -210, y: -100)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjStone2", x: -260, y: -60)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold1", x: 90, y: 50)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold1", x: 110, y: 20)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjRand", x: 115, y: -85)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjStone2", x: 140, y: -40)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjStone1", x: 150, y: 30)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold1", x: 180, y: 60)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold1", x: 185, y: -77)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold2", x: 200, y: -20)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold1", x: 250, y: 25)
        self.addChild((treasures?.getNode(by: index!))!)
        index = treasures?.addNode(imageName: "ObjGold2", x: 260, y: -50)
        self.addChild((treasures?.getNode(by: index!))!)
        
        
        
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
        hook1.size = CGSize(width: 30, height: 30)
        hook2.size = CGSize(width: 30, height: 30)
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
        
        // HookAction
        hook1.run(shakeAction)
        
        // coin
        let coinIcon = SKSpriteNode(imageNamed: "coin")
        coinIcon.size = CGSize(width: 30, height: 30)
        coinIcon.position = CGPoint(x: -self.frame.width/2+25, y: self.frame.height/2-20)
        self.addChild(coinIcon)
        
        let coinCount = SKLabelNode(text: String(self.coinCount))
        coinCount.fontName = "Zapfino"
        coinCount.fontColor = UIColor.green
        coinCount.fontSize = 17
        coinCount.position = CGPoint(x: -self.frame.width/2+60, y: self.frame.height/2-32)
        self.coinCountNode = coinCount
        self.addChild(coinCount)
        
        // goal
        let goalIcon = SKSpriteNode(imageNamed: "goal")
        goalIcon.size = CGSize(width: 30, height: 30)
        goalIcon.position = CGPoint(x: -self.frame.width/2+25, y: self.frame.height/2-55)
        self.addChild(goalIcon)
        
        let goalCount = SKLabelNode(text: "650")
        goalCount.fontName = "Zapfino"
        goalCount.fontColor = UIColor.black
        goalCount.fontSize = 17
        goalCount.position = CGPoint(x: -self.frame.width/2+60, y: self.frame.height/2-67)
        self.addChild(goalCount)
        
        
        // time
        
        
    
    }
    
    //MARK: Action
    
    
    
    //MARK: TouchEvent
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.line?.run(SKAction.scale(by: 10, duration: 1))
        //suspension = false
        let r = (hook?.zRotation)!
        let goAction = SKAction.repeatForever(SKAction.sequence([SKAction.move(by: CGVector(dx: 50*sin(r), dy: -50*cos(r)), duration: 0.5), SKAction.run {
            if let x = self.hook?.position.x, let y = self.hook?.position.y, let w = self.hook?.size.width, let h = self.hook?.size.height {
                let bw = self.frame.width
                let bh = self.frame.height
                if x < (-bw/2+w) || x > (bw/2-w) || y < (-bh/2+h) {
                    self.hook?.removeAllActions()
                    let returnAction = SKAction.move(to: (self.sPos)!, duration: 2)
                    self.hook?.run(SKAction.sequence([returnAction, self.shakeAction]))
                    //, SKAction.wait(forDuration: returnAction.duration)
                }
            }
            }]))
        hook?.removeAllActions()
        self.hook?.run(goAction)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    
    //MARK: Contact
    
    func didBegin(_ contact: SKPhysicsContact) {
        //print("contactBegin")
        
        hook?.removeAllActions()
        
        let obj = contact.bodyA.node as! TreasureNode;
        obj.removeFromParent()
        obj.position = CGPoint(x: 0, y: -15)
        obj.physicsBody = nil
        hook?.addChild(obj)
        obj.zPosition = 1
        
        let r = (hook?.zRotation)!
        let goBack = SKAction.move(by: CGVector(dx: -sin(r), dy: cos(r)), duration: 0.01)
        goBack.speed = CGFloat(1/obj.weight!)
        let returnAction = SKAction.repeatForever(SKAction.sequence([goBack, SKAction.run {
            if (self.hook?.position.y)! + cos(r) >= (self.sPos?.y)! {
                self.hook?.removeAllActions()
                self.hook?.run(SKAction.move(to: self.sPos!, duration: 0.01))
            }
            }]))

        
        
        //self.hook?.run(returnAction)
        
        let addScores = SKAction.run {
            obj.removeFromParent()
            
            self.coinCount += obj.coin!
            self.coinCountNode?.text = String(self.coinCount)
            //print(self.coinCount)
        }
        self.hook?.run(returnAction)
        
        let quene = DispatchQueue.global()
        quene.async {
            while self.hook?.position.x != self.sPos?.x || self.hook?.position.y != self.sPos?.y {}
            self.hook?.run(SKAction.sequence([addScores, self.shakeAction]))
        }
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        //print("contactEnd")
        
    }
}
