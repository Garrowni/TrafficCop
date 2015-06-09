//
//  HelpScreen.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-08.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit

class HelpScreen: SKScene
{
    override init(size: CGSize)
    {
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView)
    {
        var background: SKSpriteNode
        background = SKSpriteNode(imageNamed: "MainMenu")
        background.position =  CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        goToGame()
    }
    
    //TRANSITION
    func goToGame()
    {
        let block = SKAction.runBlock
            {
                let myScene = MainMenuScreen(size: self.size)
                myScene.scaleMode = self.scaleMode
                let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
                self.view?.presentScene(myScene, transition: reveal)
        }
        self.runAction(block)
    }
    
}