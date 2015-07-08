//
//  StatsScreen.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-07-08.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit

class StatsScreen: SKScene
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

    
    let helpSTR       : String
    let helpSTR2      : String
    let helpSTR3      : String
    let helpSTR4      : String
    let helpSTR5      : String
    let helpSTR6      : String
    let helpSTR7      : String
    let helpSTR8      : String

    
    override init(size: CGSize)
    {
        let maxAspectRatio:CGFloat = 9.0/16.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        
        backLbl     = Text(pos: CGPoint(x: 0, y: 0),    says: "Back",        fontSize: 250, font: "font4", color: "green", align: "center")
        titleLabel  = Text(pos: CGPoint(x: 0, y: 0),    says: "Your Stats!",    fontSize: 150, font: "font1", color: "yellow", align: "center")
        
        backButtR   = CGRect(x: size.width/2-250, y: size.height-1800, width: 500, height: 200)
        titleButtR  = CGRect(x: size.width/2-350, y: size.height-300, width: 700, height: 200)
        
        backButt    = Button(pos: backButtR,    roundCorner: 100, text: backLbl,    BGcolor: "halfblack", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        titleButt   = Button(pos: titleButtR,   roundCorner: 100, text: titleLabel, BGcolor: "halfblack", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: true, glowBulge: false)
        
        helpSTR   = "Total Time Played"
        helpSTR2  = "\(TimePlayed())"
        helpSTR3  = "Total People Injured"
        helpSTR4  = "\(PeopleHit())"
        helpSTR5  = "Total Cars Crashed"
        helpSTR6  = "\(CarsHit())"
        helpSTR7  = "Total Levels Completed"
        helpSTR8  = "\(LevelsBeat())"

        
        help   = Text(pos: CGPoint(x: size.width/2, y:size.height - 600),     says: helpSTR,   fontSize: 90, font: "font2", color: "green",  align: "center")
        help2  = Text(pos: CGPoint(x: size.width/2, y:size.height - 700),     says: helpSTR2,  fontSize: 60, font: "font3", color: "white",  align: "center")
        help3  = Text(pos: CGPoint(x: size.width/2, y:size.height - 800),     says: helpSTR3,  fontSize: 90, font: "font2", color: "green",  align: "center")
        help4  = Text(pos: CGPoint(x: size.width/2, y:size.height - 900),     says: helpSTR4,  fontSize: 90, font: "font3", color: "white",  align: "center")
        help5  = Text(pos: CGPoint(x: size.width/2, y:size.height - 1000),     says: helpSTR5,  fontSize: 90, font: "font2", color: "green",  align: "center")
        help6  = Text(pos: CGPoint(x: size.width/2, y:size.height - 1100),     says: helpSTR6,  fontSize: 90, font: "font3", color: "white",  align: "center")
        help7  = Text(pos: CGPoint(x: size.width/2, y:size.height - 1200),    says: helpSTR7,  fontSize: 90, font: "font2", color: "green",  align: "center")
        help8  = Text(pos: CGPoint(x: size.width/2, y:size.height - 1300),    says: helpSTR8,  fontSize: 90, font: "font3", color: "white",  align: "center")
        
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView)
    {
        var background:SKSpriteNode
        background = SKSpriteNode(imageNamed: "statsBG")
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