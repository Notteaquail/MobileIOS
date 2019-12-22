//
//  StoreProductNode.swift
//  GoldMiner
//
//  Created by apple on 2019/12/17.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import Foundation
import SpriteKit


class StoreProductNode: SKSpriteNode {
    var price: Int
    var type: String
    
    init(imageName: String, type: String) {
        self.type = type
        self.price = Int(arc4random_uniform(400))
        
        let texture = SKTexture(imageNamed: imageName)
        //let size =
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
