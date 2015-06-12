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
    

//    let label2 : Text
//    let label3 : Text
//    let label4 : Text
//    let label5 : Text
    
    let titleLabel      : Text
    let titleButt       : Button
    let titleButtR      : CGRect

    let label1          : Text
    let button1         : Button
    let button1R        : CGRect
    
    let credits         : Text
    let creditsSTR      : String
    
    override init(size: CGSize)
    {
//        label2 = Text(pos: CGPoint(x: size.width/2, y: size.height-400),    says: "Credits", fontSize: 200, font: "font2", color: "purple", align: "center")
//        label3 = Text(pos: CGPoint(x: size.width/2, y: size.height-600),    says: "FAIL",    fontSize: 200, font: "font3", color: "gray",   align: "center")
//        label4 = Text(pos: CGPoint(x: size.width/2, y: size.height-900),    says: "Credits", fontSize: 300, font: "font4", color: "black",  align: "center")
//        label5 = Text(pos: CGPoint(x: size.width/2, y: size.height-1200),   says: "12:30",   fontSize: 200, font: "font5", color: "blue",   align: "center")
        
        creditsSTR = "Welcome to Traffic Cop !" 
//        "We hope you enjoy your time" +
//        "playing the game , try to " +
//        "complete all the levels and " +
//        "this project was completed " +
//        "by some hard working people!" +
//        "These people are as follows:" +
//        " " +
//        "Justin Morrit !" +
//        " " +
//        "Nicole!" +
//        " " +
//        "Matt!" +
//        " " +
//        "Thanks For Playing !" +
//        "See Yah!"
//        
        credits = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR, fontSize: 70, font: "font2", color: "black",  align: "center")
        let scroll = SKAction.moveTo(CGPoint(x: size.width/2, y:size.height + 500), duration: 15)
        let restart = SKAction.moveTo(CGPoint(x: size.width/2, y:0), duration: 0)
        let sequence = SKAction.sequence([scroll, restart])
        let fullsequence = SKAction.repeatActionForever(sequence)

        credits.get().runAction(fullsequence)
        
        

        label1      = Text(pos: CGPoint(x: 0, y: 0),    says: "Back",        fontSize: 250, font: "font4", color: "green", align: "center")
        titleLabel  = Text(pos: CGPoint(x: 0, y: 0),    says: "Credits !",   fontSize: 150, font: "font1", color: "yellow", align: "center")
        
        button1R    = CGRect(x: size.width/2-250, y: size.height-1800, width: 500, height: 200)
        titleButtR  = CGRect(x: size.width/2-350, y: size.height-300, width: 700, height: 200)
        
        button1     = Button(pos: button1R,     roundCorner: 100, text: label1,     BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        titleButt   = Button(pos: titleButtR,   roundCorner: 100, text: titleLabel, BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: true, glowBulge: false)
      
        
        
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
        
        
        addChild(credits.get())
   
        
        
        //BUTTON/Title
        addChild(titleButt.getButtBG())
        addChild(titleButt.getButtOL())
        addChild(titleButt.getLabel())
        
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
        if(button1R.contains(location)){goToGame()}
       
      
    }
    #else
    override func mouseDown(theEvent: NSEvent)
    {
        let location = theEvent.locationInNode(self)
        if(button1R.contains(location)){goToGame()}
    }
    #endif
    
    
    
    //TRANSITION
    func goToGame()
    {
        let transition = SKAction.group([SKAction.runBlock(){
            self.button1.zoomOUT()
            self.titleButt.FadeAway()
            }])
        let wait = SKAction.waitForDuration(0.5)
        let block = SKAction.runBlock
            {
                let myScene = MainMenuScreen(size: self.size)
                myScene.scaleMode = self.scaleMode
                let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
                self.view?.presentScene(myScene, transition: reveal)
        }
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
    }
    
}