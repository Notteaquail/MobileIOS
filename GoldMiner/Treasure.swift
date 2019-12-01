//
//  Treasure.swift
//  GoldMiner
//
//  Created by apple on 2019/12/1.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import Foundation
import SpriteKit

class Treasure {
    static var count = 0
    private var index = 0
    private let treasureNode: SKSpriteNode?
    
    let myHookBitMask: UInt32 = 0x0001
    let myOBJBitMask: UInt32 = 0x0002
    
    init(imageName: String, x: Int, y: Int, width: Int, height: Int) {
        index = Treasure.count
        Treasure.count += 1
        treasureNode = SKSpriteNode(imageNamed: imageName)
        treasureNode?.size = CGSize(width: width, height: height)
        treasureNode?.position = CGPoint(x: x, y: y)
        treasureNode?.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        treasureNode?.physicsBody = SKPhysicsBody(rectangleOf: treasureNode!.size)
        treasureNode?.physicsBody?.isDynamic = false
        treasureNode?.physicsBody?.contactTestBitMask = self.myOBJBitMask
    }
    
    deinit {
        Treasure.count -= 1
    }
    
    func getTreasureNode() -> SKSpriteNode? {
        return treasureNode
    }
}
