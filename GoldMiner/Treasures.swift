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
    
    func deleteNode(index: Int){
        treasureList.remove(at: index)
    }
    
    
    func getNode(by index: Int) -> SKSpriteNode {
        return treasureList[index]
    }
}
