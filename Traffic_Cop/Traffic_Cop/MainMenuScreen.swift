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
    let TW : Int
    let titleLabel      : Text
    let playLabel       : Text
    let helpLabel       : Text
    let credLabel       : Text
    
    let titlButt: Button
    let playButt: Button
    let helpButt: Button
    let credButt: Button
    
    let titlR: CGRect
    let playR: CGRect
    let helpR: CGRect
    let credR: CGRect
    
    
   
    override init(size: CGSize)
    {
        TW = 128
        
        //Labels
        titleLabel      = Text(pos: CGPoint(x: 0, y: 0),    says: "Traffic Cop",    fontSize: 150, font: "font1", color: "yellow", align: "center")
        playLabel       = Text(pos: CGPoint(x: 0, y: 0),    says: "Play",           fontSize: 200, font: "font4", color: "black", align: "center")
        helpLabel       = Text(pos: CGPoint(x: 0, y: 0),    says: "Help",           fontSize: 200, font: "font4", color: "black", align: "center")
        credLabel       = Text(pos: CGPoint(x: 0, y: 0),    says: "Credits",        fontSize: 200, font: "font4", color: "black", align: "center")
        
        //Rects  * remember subtract half the width from the x to get true center *
        titlR = CGRect(x: size.width/2-450, y: size.height-400, width: 900, height: 300)
        playR = CGRect(x: size.width/2-300, y: size.height-840, width: 600, height: 400)
        helpR = CGRect(x: size.width/2-300, y: size.height-1260, width: 600, height: 400)
        credR = CGRect(x: size.width/2-300, y: size.height-1690, width: 600, height: 400)
        
        //Buttons
        titlButt = Button(pos: titlR, roundCorner: 100, text: titleLabel, BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 40, ZoomIn: true, Bulge: true, glowBulge: false)
        playButt = Button(pos: playR, roundCorner: 200, text: playLabel, BGcolor: "green", OLcolor: "white", OLSize: 10, glowWidth: 30, ZoomIn: true, Bulge: false, glowBulge: true)
        helpButt = Button(pos: helpR, roundCorner: 200, text: helpLabel, BGcolor: "yellow", OLcolor: "white", OLSize: 10, glowWidth: 30, ZoomIn: true, Bulge: false, glowBulge: true)
        credButt = Button(pos: credR, roundCorner: 200, text: credLabel, BGcolor: "red", OLcolor: "white", OLSize: 10, glowWidth: 30, ZoomIn: true, Bulge: false, glowBulge: true)
        
        super.init(size: size)
    }
    
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToView(view: SKView)
    {
        var background:SKSpriteNode
        background = SKSpriteNode(imageNamed: "MainMenu")
        background.position =  CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        
        //BUTTONS / TITLE
        addChild(titlButt.getButtBG())
        addChild(titlButt.getButtOL())
        addChild(titlButt.getLabel())
        
        addChild(playButt.getButtBG())
        addChild(playButt.getButtOL())
        addChild(playButt.getLabel())
        
        addChild(helpButt.getButtBG())
        addChild(helpButt.getButtOL())
        addChild(helpButt.getLabel())
        
        addChild(credButt.getButtBG())
        addChild(credButt.getButtOL())
        addChild(credButt.getLabel())
        
        
        addChild(background)
    }
    
    
    // iOS AND OSX DIFFERENT TOUCH HANDLING
    //PRE-COMPILE DIRECTIVES
    #if os(iOS)
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        //println("x = \(location.x) and y = \(location.y)")
       
        if playR.contains(location)
        {
            goToGame()
        }
        if helpR.contains(location)
        {
            goToHelp()
        }
        if credR.contains(location)
        {
            goToCredits()
        }
    }
    #else
    override func mouseDown(theEvent: NSEvent)
    {
        let location = theEvent.locationInNode(self)
    
        if playR.contains(location)
        {
            goToGame()
        }
        if helpR.contains(location)
        {
            goToHelp()
        }
        if credR.contains(location)
        {
            goToCredits()
        }
    }
    #endif
    
    
    //TRANSITION
    func goToGame()
    {
        let transition = SKAction.group([SKAction.runBlock(){
            self.playButt.zoomOUT()
            self.titlButt.FadeAway()
            self.credButt.zoomOUT()
            self.helpButt.FadeAway()
            }])
        let wait = SKAction.waitForDuration(0.5)
        let block = SKAction.runBlock
        {
            let myScene = GameScene(size: self.size)
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
            self.view?.presentScene(myScene, transition: reveal)
        }
        self.runAction(block)
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
        
    }
    
    func goToHelp()
    {
        let transition = SKAction.group([SKAction.runBlock(){
            self.playButt.FadeAway()
            self.titlButt.FadeAway()
            self.credButt.FadeAway()
            self.helpButt.zoomOUT()
            }])
        let wait = SKAction.waitForDuration(0.5)
        let block = SKAction.runBlock{
            let myScene = HelpScreen(size: self.size)
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
            self.view?.presentScene(myScene, transition: reveal)
        }
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
    }
    
    func goToCredits()
    {
        let transition = SKAction.group([SKAction.runBlock(){
            self.playButt.FadeAway()
            self.titlButt.FadeAway()
            self.credButt.zoomOUT()
            self.helpButt.FadeAway()
            }])

        let wait = SKAction.waitForDuration(0.5)
        let block = SKAction.runBlock
        {
            let myScene = CreditsScreen(size: self.size)
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
            self.view?.presentScene(myScene, transition: reveal)
        }
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
        
        
    }
    
}
