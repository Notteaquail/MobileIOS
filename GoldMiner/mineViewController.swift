//
//  mineViewController.swift
//  GoldMiner
//
//  Created by apple on 2019/11/30.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import UIKit
import SpriteKit

class mineViewController: UIViewController {

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let skView = self.view as? SKView {
            if let scene = SKScene(fileNamed: "mineScene") {
                scene.size = CGSize(width: 320*(skView.bounds.size.width/skView.bounds.size.height), height: 320)
                //scene.scaleMode = .fill
                
                print(scene.size)
                
                skView.showsDrawCount = true
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                skView.presentScene(scene)
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscapeLeft, .landscapeRight]
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    

}
