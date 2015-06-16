//
//  GameViewController.swift
//  Traffic_Cop
//
//  Created by Mathew  Manton on 2015-06-05.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {
    
//let settings : Settings
//    settings = Settings() //LATER ON LOAD FROM FILE
//  


    override func viewDidLoad()
    {
        
        
        
            super.viewDidLoad()
            let scene               = MainMenuScreen(size: CGSize(width: 1024, height: 1920)) // 16*64 = WIDTH 30*64 = HEIGHT
            let skView              = self.view as! SKView
            skView.showsFPS         = true
            skView.showsNodeCount   = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit
            
            skView.presentScene(scene)
    }
    



    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
