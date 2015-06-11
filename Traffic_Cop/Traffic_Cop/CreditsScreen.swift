//
//  CreditsScreen.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-08.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit

class CreditsScreen: SKScene
{
    let playableRect: CGRect
    let label1 : Text
    let label2 : Text
    let label3 : Text
    let label4 : Text
    let label5 : Text
    
    let button1: RectButton
    let button1R: CGRect
    
    override init(size: CGSize)
    {
        
        label1 = Text(pos: CGPoint(x: 0, y: 0),    says: "Credits", fontSize: 150, font: "font1", color: "yellow", align: "center")
        
        label2 = Text(pos: CGPoint(x: size.width/2, y: size.height-400),    says: "Credits", fontSize: 200, font: "font2", color: "purple", align: "center")
        label3 = Text(pos: CGPoint(x: size.width/2, y: size.height-600),    says: "FAIL",    fontSize: 200, font: "font3", color: "gray",   align: "center")
        label4 = Text(pos: CGPoint(x: size.width/2, y: size.height-900),    says: "Credits", fontSize: 300, font: "font4", color: "black",  align: "center")
        label5 = Text(pos: CGPoint(x: size.width/2, y: size.height-1200),   says: "12:30",   fontSize: 200, font: "font5", color: "blue",   align: "center")

        
        button1R = CGRect(x: size.width/2-350, y: size.height-1700, width: 700, height: 400)
        button1 = RectButton(pos: button1R, roundCorner: 200, text: label1, BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 70)
      
        
        
        let maxAspectRatio:CGFloat = 9.0/16.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView)
    {
        let shape2 = SKShapeNode()
        let path2 = CGPathCreateMutable()
        CGPathAddRect(path2, nil, playableRect)
        shape2.path = path2
        shape2.fillColor = SKColor.greenColor()
        shape2.lineWidth = 35.0
        
        addChild(shape2)
        
       
        //addChild(label1.get())
        addChild(label2.get())
        addChild(label3.get())
        addChild(label4.get())
        addChild(label5.get())
        
        
        //BUTTON 1
        addChild(button1.getButtBG())
        addChild(button1.getButtOL())
        addChild(button1.getLabel())

        
    }
    
    
    //PRE-COMPILE DIRECTIVES
    #if os(iOS)
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        goToGame()
    }
    #else
    override func mouseDown(theEvent: NSEvent)
    {
        let location = theEvent.locationInNode(self)
        goToGame()
    }
    #endif
    
    
    
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