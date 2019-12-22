//
//  Store.swift
//  GoldMiner
//
//  Created by apple on 2019/12/17.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import Foundation
import SpriteKit

class Store {
    var isNext = false
    
    var products = [StoreProductNode]()
    var storeNode: SKSpriteNode?
    var desk: SKSpriteNode?
    var next: SKSpriteNode?
    
    var ownObject = [StoreProductNode]()
    
    init(width: CGFloat, height: CGFloat){
        buildStore(width: width, height: height)
    }
    
    func buildStore(width: CGFloat, height: CGFloat) {
        storeNode = SKSpriteNode(imageNamed: "shop-background")
        storeNode?.size = CGSize(width: width, height: height)
        storeNode?.position = CGPoint(x: 0, y: 0)
        storeNode?.zPosition = 15
        
        let desk = SKSpriteNode(imageNamed: "desk")
        desk.size = CGSize(width: width, height: 100)
        desk.position = CGPoint(x: 0, y: (desk.size.height-height)/2)
        storeNode?.addChild(desk)
        self.desk = desk
        
        let seller = SKSpriteNode(imageNamed: "seller")
        seller.size = CGSize(width: 150, height: 150)
        seller.position = CGPoint(x: 200, y: desk.size.height/2+seller.size.height/2)
        desk.addChild(seller)
        
        let talkBanner = SKSpriteNode(imageNamed: "shop-talk-banner")
        talkBanner.size = CGSize(width: 400, height: 70)
        talkBanner.position = CGPoint(x: -280, y: 80)
        seller.addChild(talkBanner)
        
        let message = SKLabelNode(text: "点击要购买的物品，准备好继续后点击下一关")
        message.fontColor = UIColor.black
        message.fontSize = 17
        talkBanner.addChild(message)
        
        let nextButton = SKSpriteNode(imageNamed: "next")
        nextButton.size = CGSize(width: 50, height: 50)
        nextButton.position = CGPoint(x: width/2-70, y: height/2-70)
        next = nextButton
        storeNode?.addChild(nextButton)
    }
    
    func creatProducts() {
        for p in products {
            p.removeFromParent()
        }
        products.removeAll()
        var count = Int(arc4random_uniform(4)) + 1
        var x = -200
        while count > 0 {
            let index = Int(arc4random_uniform(5)) + 1
            var type: String
            switch index {
            case 1:
                type = "bomb"
            case 2:
                type = "leaf"
            case 3:
                type = "power"
            case 4:
                type = "diamond"
            case 5:
                type = "time"
            case 6:
                type = "stone"
            default:
                type = ""
            }
            let product = StoreProductNode(imageName: "object"+String(index), type: type)
            product.size = CGSize(width: 50, height: 50)
            product.position = CGPoint(x: x, y: 125-Int((storeNode?.size.height)!/2))
            products.append(product)
            storeNode?.addChild(product)
            
            let price = Int(arc4random_uniform(450)) + 1
            let priceLable = SKLabelNode(text: String(price)+"¥")
            priceLable.fontName = "Zapfino"
            priceLable.fontColor = UIColor.green
            priceLable.fontSize = 17
            priceLable.position = CGPoint(x: 0, y: -50)
            product.addChild(priceLable)
            
            x = x + 100
            count = count - 1
        }
    }
    
    func touched(x: CGFloat, y: CGFloat) {
        if x > ((next?.position.x)!-25) && x < ((next?.position.x)!+25) {
            if y > ((next?.position.y)!-25) && y < ((next?.position.y)!+25) {
                isNext = true
            }
        } else {
            for product in products {
                if x > (product.position.x-25) && x < (product.position.x+25) {
                    if y > (product.position.y-25) && y < (product.position.y+25) {
                        product.removeFromParent()
                        ownObject.append(product)
                    }
                }
            }
        }
    }
}
