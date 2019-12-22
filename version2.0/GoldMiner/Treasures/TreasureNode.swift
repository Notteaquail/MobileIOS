//
//  TreasureNode.swift
//  GoldMiner
//
//  Created by apple on 2019/12/10.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import Foundation
import SpriteKit


class TreasureNode: SKSpriteNode {
    // gold1=rand=diam=1 gold2=1.5 gold3=stone1=2 stone2=3
    var weight: Double?
    var coin: Int?
    var objType: String
    
    init(imageNamed: String){
        objType = imageNamed
        
        let texture = SKTexture(imageNamed: imageNamed)
        let size = CGSize(width: texture.size().width/2, height: texture.size().height/2)
        super.init(texture: texture, color: UIColor.clear, size: size)
        
        switch imageNamed {
        case "ObjBomb":
            weight=0
            coin=0
        case "ObjGold1":
            weight=1
            coin=50
        case  "ObjRand":
            weight=1
            coin=Int(arc4random_uniform(400))
        case "ObjDiamonds":
            weight=1
            coin=600
        case "ObjGold2":
            weight=2
            coin=100
        case "ObjGold3":
            weight=3
            coin=500
        case "ObjStone1":
            weight=3
            coin=15
        case "ObjStone2":
            weight=4
            coin=25
        default:
            weight=0
            coin=0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func getWeight() -> Double? {
        return weight
    }
    
    func getCoin() -> Int? {
        return coin
    }
}
