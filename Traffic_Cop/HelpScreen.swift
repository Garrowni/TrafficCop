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
    let playableRect: CGRect
    
    let titleLabel      : Text
    let titleButt       : Button
    let titleButtR      : CGRect
    
    let backLbl          : Text
    let backButt         : Button
    let backButtR        : CGRect
    
    let help          : Text
    let help2         : Text
    let help3         : Text
    let help4         : Text
    let help5         : Text
    let help6         : Text
    let help7         : Text
    let help8         : Text
    let help9         : Text
    let help10        : Text
    let help11        : Text
    let help12        : Text
    let help13        : Text
    let help14        : Text
    let help15        : Text
    let help16        : Text
    
    let helpSTR       : String
    let helpSTR2      : String
    let helpSTR3      : String
    let helpSTR4      : String
    let helpSTR5      : String
    let helpSTR6      : String
    let helpSTR7      : String
    let helpSTR8      : String
    let helpSTR9      : String
    let helpSTR10     : String
    let helpSTR11     : String
    let helpSTR12     : String
    let helpSTR13     : String
    let helpSTR14     : String
    let helpSTR15     : String
    let helpSTR16     : String
    
    override init(size: CGSize)
    {
        let maxAspectRatio:CGFloat = 9.0/16.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        
        backLbl     = Text(pos: CGPoint(x: 0, y: 0),    says: "Back",        fontSize: 250, font: "font4", color: "green", align: "center")
        titleLabel  = Text(pos: CGPoint(x: 0, y: 0),    says: "Help Me!",    fontSize: 150, font: "font1", color: "yellow", align: "center")
        
        backButtR   = CGRect(x: size.width/2-250, y: size.height-1800, width: 500, height: 200)
        titleButtR  = CGRect(x: size.width/2-350, y: size.height-300, width: 700, height: 200)
        
        backButt    = Button(pos: backButtR,    roundCorner: 100, text: backLbl,    BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        titleButt   = Button(pos: titleButtR,   roundCorner: 100, text: titleLabel, BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: true, glowBulge: false)
        
        helpSTR   = "Looking for help?"
        helpSTR2  = "Steps:"
        helpSTR3  = "1)  Click the car to select it"
        helpSTR4  = "Tell the car its  destination"
        helpSTR5  = "(clicking on a highlighted road)"
        helpSTR6  = ""
        helpSTR7  = "2) Try to click the cars in the"
        helpSTR8  = "order they show up or else"
        helpSTR9  = "people will start getting mad"
        helpSTR10 = ""
        helpSTR11 = "3) Be careful of pedestrians"
        helpSTR12 = "don't direct traffic into people!"
        helpSTR13 = ""
        helpSTR14 = ""
        helpSTR15 = ""
        helpSTR16 = ""
        
        help   = Text(pos: CGPoint(x: size.width/2, y:size.height - 400),     says: helpSTR,   fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help2  = Text(pos: CGPoint(x: size.width/2, y:size.height - 500),     says: helpSTR2,  fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help3  = Text(pos: CGPoint(x: size.width/2, y:size.height - 600),     says: helpSTR3,  fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help4  = Text(pos: CGPoint(x: size.width/2, y:size.height - 700),     says: helpSTR4,  fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help5  = Text(pos: CGPoint(x: size.width/2, y:size.height - 800),     says: helpSTR5,  fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help6  = Text(pos: CGPoint(x: size.width/2, y:size.height - 900),     says: helpSTR6,  fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help7  = Text(pos: CGPoint(x: size.width/2, y:size.height - 1000),    says: helpSTR7,  fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help8  = Text(pos: CGPoint(x: size.width/2, y:size.height - 1100),    says: helpSTR8,  fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help9  = Text(pos: CGPoint(x: size.width/2, y:size.height - 1200),    says: helpSTR9,  fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help10 = Text(pos: CGPoint(x: size.width/2, y:size.height - 1300),    says: helpSTR10, fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help11 = Text(pos: CGPoint(x: size.width/2, y:size.height - 1400),    says: helpSTR11, fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help12 = Text(pos: CGPoint(x: size.width/2, y:size.height - 1500),    says: helpSTR12, fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help13 = Text(pos: CGPoint(x: size.width/2, y:size.height - 1600),    says: helpSTR13, fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help14 = Text(pos: CGPoint(x: size.width/2, y:size.height - 1700),    says: helpSTR14, fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help15 = Text(pos: CGPoint(x: size.width/2, y:size.height - 1800),    says: helpSTR15, fontSize: 60, font: "font2", color: "cyan",  align: "center")
        help16 = Text(pos: CGPoint(x: size.width/2, y:size.height - 1900),    says: helpSTR16, fontSize: 60, font: "font2", color: "cyan",  align: "center")
        
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView)
    {
        var background:SKSpriteNode
        background = SKSpriteNode(imageNamed: "Background2")
        background.position =  CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(background)
        
        
        addChild(help.get())
        addChild(help2.get())
        addChild(help3.get())
        addChild(help4.get())
        addChild(help5.get())
        addChild(help6.get())
        addChild(help7.get())
        addChild(help8.get())
        addChild(help9.get())
        addChild(help10.get())
        addChild(help11.get())
        addChild(help12.get())
        addChild(help13.get())
        addChild(help14.get())
        addChild(help15.get())
        addChild(help16.get())
        
        
        //BUTTON/Title
        addChild(titleButt.getButtBG())
        addChild(titleButt.getButtOL())
        addChild(titleButt.getLabel())
        
        addChild(backButt.getButtBG())
        addChild(backButt.getButtOL())
        addChild(backButt.getLabel())
        
    }
    
    //PRE-COMPILE DIRECTIVES
    #if os(iOS)
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        if(backButtR.contains(location)){goToGame()}
    }
    #else
    override func mouseDown(theEvent: NSEvent)
    {
        let location = theEvent.locationInNode(self)
           if(backButtR.contains(location)){goToGame()}
    }
    #endif
    
    
    //TRANSITION
    func goToGame()
    {
        let transition = SKAction.group([SKAction.runBlock(){
            self.backButt.zoomOUT()
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