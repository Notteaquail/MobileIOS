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
        
    // sceneElements
    var sceneElements: SceneElements?
    
    
    //MARK: Actions
    override func didMove(to view: SKView) {
        if self.contentCreated == false {
            self.createSceneContents()
            self.contentCreated = true
        }
        
        
        self.physicsWorld.contactDelegate = self
    }
    
    
    //MARK: Init Scene Contents
    func createSceneContents(){
        sceneElements = SceneElements(width: self.frame.width, height: self.frame.height)
        
        // menu scene
        sceneElements?.buildMyMenu(mineScene: self)
        
        // main Scene
        sceneElements?.buildMainScene(mineScene: self)
        
        // Cut Scene
        sceneElements?.buildCutScene(mineScene: self)
        
        // store
        sceneElements?.buildStore(mineScene: self)
    }
    
    
    
    
    
    
    
    
    
    //MARK: TouchEvent
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            sceneElements?.touchEvent(location: touch.location(in: self), mineScene: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    

    
    //MARK: Contact
    
    func didBegin(_ contact: SKPhysicsContact) {
        //print("contactBegin")
        
        sceneElements?.contactHandeler(contact: contact)
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        //print("contactEnd")
        
    }
}
