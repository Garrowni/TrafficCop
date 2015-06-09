//
//  MainMenuScreen.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-08.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScreen: SKScene
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
        println("x = \(location.x) and y = \(location.y)")
       
       if location.x > 213 && location.x < 877 && location.y < 1255 && location.y > 993
       {
            goToGame()
       }
       else if location.x > 231 && location.x < 895 && location.y < 907 && location.y > 643
       {
            goToHelp()
       }
        else if location.x > 231 && location.x < 895 && location.y < 541 && location.y > 275
       {
            goToCredits()
       }
        
    }
    
    //TRANSITION
    func goToGame()
    {
        let block = SKAction.runBlock
            {
                let myScene = GameScene(size: self.size)
                myScene.scaleMode = self.scaleMode
                let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
                self.view?.presentScene(myScene, transition: reveal)
        }
        self.runAction(block)
    }
    
    func goToHelp()
    {
        let block = SKAction.runBlock
        {
            let myScene = HelpScreen(size: self.size)
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
            self.view?.presentScene(myScene, transition: reveal)
            
        }
        self.runAction(block)
    }
    
    func goToCredits()
    {
        let block = SKAction.runBlock
            {
                let myScene = CreditsScreen(size: self.size)
                myScene.scaleMode = self.scaleMode
                let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
                self.view?.presentScene(myScene, transition: reveal)
                
        }
        self.runAction(block)
    }
    
}
