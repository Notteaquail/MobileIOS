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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let skView = self.view as! SKView? {
            skView.showsDrawCount = true
            skView.showsFPS = true
            skView.showsNodeCount = true
            
        }
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "level-background-0.jpg")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let scene = SKScene(fileNamed: "mineScene") {
            scene.size = self.view.bounds.size
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            if let spritView = self.view as? SKView {
                spritView.presentScene(scene)
            }
        }
    }

    /*override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscapeRight, .landscapeLeft]
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
