//
//  CreditsScreen.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-08.
//  Edited by Nicole Garrow on 2015-06-23
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
    let credits2        : Text
    let credits3        : Text
    let credits4        : Text
    let credits5        : Text
    let credits6        : Text
    let credits7        : Text
    let credits8        : Text
    let credits9        : Text
    let credits10       : Text
    let credits11       : Text
    let credits12       : Text
    let credits13       : Text
    let credits14       : Text
    let credits15       : Text
    let credits16       : Text
    
    let creditsSTR       : String
    let creditsSTR2      : String
    let creditsSTR3      : String
    let creditsSTR4      : String
    let creditsSTR5      : String
    let creditsSTR6      : String
    let creditsSTR7      : String
    let creditsSTR8      : String
    let creditsSTR9      : String
    let creditsSTR10     : String
    let creditsSTR11     : String
    let creditsSTR12     : String
    let creditsSTR13     : String
    let creditsSTR14     : String
    let creditsSTR15     : String
    let creditsSTR16     : String
    
    
    override init(size: CGSize)
    {
        
//        label2 = Text(pos: CGPoint(x: size.width/2, y: size.height-400),    says: "Credits", fontSize: 200, font: "font2", color: "purple", align: "center")
//        label3 = Text(pos: CGPoint(x: size.width/2, y: size.height-600),    says: "FAIL",    fontSize: 200, font: "font3", color: "gray",   align: "center")
//        label4 = Text(pos: CGPoint(x: size.width/2, y: size.height-900),    says: "Credits", fontSize: 300, font: "font4", color: "black",  align: "center")
//        label5 = Text(pos: CGPoint(x: size.width/2, y: size.height-1200),   says: "12:30",   fontSize: 200, font: "font5", color: "blue",   align: "center")
        
        creditsSTR   = "Welcome to Traffic Cop !"
        creditsSTR2  = "We hope you enjoy your time"
        creditsSTR3  = "playing the game , try to "
        creditsSTR4  = "complete all the levels!"
        creditsSTR5  = "this project was completed "
        creditsSTR6  = "by some hard working people!"
        creditsSTR7  = "These people are as follows:"
        creditsSTR8  = " "
        creditsSTR9  = "Justin Morrit !"
        creditsSTR10 = " "
        creditsSTR11 = "Nicole Garrow!"
        creditsSTR12 = " "
        creditsSTR13 = "Matt Manton!"
        creditsSTR14 = " "
        creditsSTR15 = "cars by Razeware LLC."
        creditsSTR16 = "Thanks For Playing!"
       
        credits   = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR,   fontSize: 70, font: "font2", color: "black",  align: "center")
        credits2  = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR2,  fontSize: 70, font: "font2", color: "black",  align: "center")
        credits3  = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR3,  fontSize: 70, font: "font2", color: "black",  align: "center")
        credits4  = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR4,  fontSize: 70, font: "font2", color: "black",  align: "center")
        credits5  = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR5,  fontSize: 70, font: "font2", color: "black",  align: "center")
        credits6  = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR6,  fontSize: 70, font: "font2", color: "black",  align: "center")
        credits7  = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR7,  fontSize: 70, font: "font2", color: "black",  align: "center")
        credits8  = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR8,  fontSize: 70, font: "font2", color: "black",  align: "center")
        credits9  = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR9,  fontSize: 70, font: "font2", color: "black",  align: "center")
        credits10 = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR10, fontSize: 70, font: "font2", color: "black",  align: "center")
        credits11 = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR11, fontSize: 70, font: "font2", color: "black",  align: "center")
        credits12 = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR12, fontSize: 70, font: "font2", color: "black",  align: "center")
        credits13 = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR13, fontSize: 70, font: "font2", color: "black",  align: "center")
        credits14 = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR14, fontSize: 70, font: "font2", color: "black",  align: "center")
        credits15 = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR15, fontSize: 70, font: "font2", color: "black",  align: "center")
        credits16 = Text(pos: CGPoint(x: size.width/2, y:0),    says: creditsSTR16, fontSize: 70, font: "font2", color: "black",  align: "center")
        

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
        
        
        
        let scroll = SKAction.moveTo(CGPoint(x: size.width/2, y:size.height + 700), duration: 15)
        let restart = SKAction.moveTo(CGPoint(x: size.width/2, y:0), duration: 0)
        let wait = SKAction.waitForDuration(1)
        let wait2 = SKAction.waitForDuration(5)
        let sequence = SKAction.sequence([scroll,restart])
        //let fullsequence = SKAction.runAction(sequence)
        
        super.init(size: size)
        let credBlock1  = SKAction.runBlock(){self.credits.get().runAction(sequence)}
        let credBlock2  = SKAction.runBlock(){self.credits2.get().runAction(sequence)}
        let credBlock3  = SKAction.runBlock(){self.credits3.get().runAction(sequence)}
        let credBlock4  = SKAction.runBlock(){self.credits4.get().runAction(sequence)}
        let credBlock5  = SKAction.runBlock(){self.credits5.get().runAction(sequence)}
        let credBlock6  = SKAction.runBlock(){self.credits6.get().runAction(sequence)}
        let credBlock7  = SKAction.runBlock(){self.credits7.get().runAction(sequence)}
        let credBlock8  = SKAction.runBlock(){self.credits8.get().runAction(sequence)}
        let credBlock9  = SKAction.runBlock(){self.credits9.get().runAction(sequence)}
        let credBlock10 = SKAction.runBlock(){self.credits10.get().runAction(sequence)}
        let credBlock11 = SKAction.runBlock(){self.credits11.get().runAction(sequence)}
        let credBlock12 = SKAction.runBlock(){self.credits12.get().runAction(sequence)}
        let credBlock13 = SKAction.runBlock(){self.credits13.get().runAction(sequence)}
        let credBlock14 = SKAction.runBlock(){self.credits14.get().runAction(sequence)}
        let credBlock15 = SKAction.runBlock(){self.credits15.get().runAction(sequence)}
        let credBlock16 = SKAction.runBlock(){self.credits16.get().runAction(sequence)}
        
        let FullCreds = SKAction.sequence([ credBlock1,wait,
                                            credBlock2,wait,
                                            credBlock3,wait,
                                            credBlock4,wait,
                                            credBlock5,wait,
                                            credBlock6,wait,
                                            credBlock7,wait,
                                            credBlock8,wait,
                                            credBlock9,wait,
                                            credBlock10,wait,
                                            credBlock11,wait,
                                            credBlock12,wait,
                                            credBlock13,wait,
                                            credBlock14,wait,
                                            credBlock15,wait,
                                            credBlock16,wait2])
        
        let fullCredSeq = SKAction.repeatActionForever(FullCreds)
        
        runAction(fullCredSeq)
        
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
        addChild(credits2.get())
        addChild(credits3.get())
        addChild(credits4.get())
        addChild(credits5.get())
        addChild(credits6.get())
        addChild(credits7.get())
        addChild(credits8.get())
        addChild(credits9.get())
        addChild(credits10.get())
        addChild(credits11.get())
        addChild(credits12.get())
        addChild(credits13.get())
        addChild(credits14.get())
        addChild(credits15.get())
        addChild(credits16.get())
   
        
        
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