//
//  Treasures.swift
//  GoldMiner
//
//  Created by apple on 2019/12/1.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import Foundation
import SpriteKit

class Treasures {
    private var treasureList = [TreasureNode]()

    
    let myHookBitMask: UInt32 = 0x0001
    let myOBJBitMask: UInt32 = 0x0002
    
    
    func addNode(imageName: String, x: Int, y: Int) -> Int {
        let objNode = TreasureNode(imageNamed: imageName)
        //treasureNode?.size = CGSize(width: width, height: height)
        objNode.position = CGPoint(x: x, y: y)
        objNode.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        objNode.physicsBody = SKPhysicsBody(rectangleOf: objNode.size)
        objNode.physicsBody?.isDynamic = false
        objNode.physicsBody?.contactTestBitMask = self.myOBJBitMask
        
        treasureList.append(objNode)
        
        return treasureList.count-1
    }
    
    func removeNode(index: Int){
        treasureList.remove(at: index)
    }
    
    func removeAll() {
        var k = treasureList.count-1;
        while k >= 0 {
            treasureList[k].removeFromParent()
            treasureList.remove(at: k)
            k = k - 1
        }
    }
    
    func getNode(by index: Int) -> SKSpriteNode {
        return treasureList[index]
    }
    
    func addAllToScene(mineScene: SKScene) {
        for t in treasureList {
            mineScene.addChild(t)
        }
    }
    
    
    // levels
    func level1(){
        
        // level 1
        var index = addNode(imageName: "ObjStone1", x: 20, y: -70)

        index = addNode(imageName: "ObjGold1", x: -50, y: 0)

        index = addNode(imageName: "ObjGold3", x: -40, y: -100)

        index = addNode(imageName: "ObjStone2", x: -70, y: -40)

        index = addNode(imageName: "ObjStone1", x: -110, y: -85)

        index = addNode(imageName: "ObjStone2", x: -120, y: 20)

        index = addNode(imageName: "ObjGold1", x: -140, y: 45)

        index = addNode(imageName: "ObjGold2", x: -200, y: 35)

        index = addNode(imageName: "ObjGold3", x: -210, y: -100)

        index = addNode(imageName: "ObjStone2", x: -260, y: -60)

        index = addNode(imageName: "ObjGold1", x: 90, y: 50)

        index = addNode(imageName: "ObjGold1", x: 110, y: 20)

        index = addNode(imageName: "ObjRand", x: 115, y: -85)

        index = addNode(imageName: "ObjStone2", x: 140, y: -40)

        index = addNode(imageName: "ObjStone1", x: 150, y: 30)

        index = addNode(imageName: "ObjGold1", x: 180, y: 60)

        index = addNode(imageName: "ObjGold1", x: 185, y: -77)

        index = addNode(imageName: "ObjGold2", x: 200, y: -20)

        index = addNode(imageName: "ObjGold1", x: 250, y: 25)

        index = addNode(imageName: "ObjGold2", x: 260, y: -50)

        //print(index)

    }
    
    func level2() {
        var index = addNode(imageName: "ObjGold1", x: 0, y: 35)

        index = addNode(imageName: "ObjRand", x: -70, y: -120)

        index = addNode(imageName: "ObjGold1", x: -80, y: 10)

        index = addNode(imageName: "ObjStone2", x: -120, y: -25)

        index = addNode(imageName: "ObjGold1", x: -160, y: -50)

        index = addNode(imageName: "ObjStone2", x: -190, y: 0)

        index = addNode(imageName: "ObjGold2", x: -240, y: 20)

        index = addNode(imageName: "ObjGold3", x: -240, y: -90)

        index = addNode(imageName: "ObjStone1", x: 30, y: -10)

        index = addNode(imageName: "ObjGold3", x: 50, y: -110)

        index = addNode(imageName: "ObjGold1", x: 80, y: 20)

        index = addNode(imageName: "ObjGold1", x: 110, y: -75)

        index = addNode(imageName: "ObjDiamonds", x: 130, y: -45)

        index = addNode(imageName: "ObjStone2", x: 155, y: -90)
 
        index = addNode(imageName: "ObjStone1", x: 160, y: 0)

        index = addNode(imageName: "ObjGold1", x: 190, y: 55)

        index = addNode(imageName: "ObjStone1", x: 220, y: 20)

        index = addNode(imageName: "ObjGold1", x: 235, y: -10)

        index = addNode(imageName: "ObjGold3", x: 250, y: -75)

    }
    
    // store product function
    func leaf() {
        for treasure in treasureList {
            if treasure.objType == "ObjRand" {
                treasure.coin = 200 + Int(arc4random_uniform(200))
            }
        }
    }
    
    func power() {
        for treasure in treasureList {
            treasure.weight = 1
        }
    }
    
    func diamond() {
        for treasure in treasureList {
            if treasure.objType == "ObjDiamonds" {
                treasure.coin = treasure.coin! + 200
            }
        }
    }
    
    func stone() {
        for treasure in treasureList {
            if treasure.objType == "ObjStone1" || treasure.objType == "ObjStone2" {
                treasure.coin = treasure.coin! + 50
            }
        }
    }
}
