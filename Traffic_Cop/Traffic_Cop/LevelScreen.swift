//
//  LevelScreen.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-12.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation

import Foundation
import SpriteKit

class LevelScreen: SKScene
{
    let playableRect: CGRect
    
    let titleLabel      : Text
    let titleButt       : Button
    let titleButtR      : CGRect
    
    let backLbl          : Text
    let backButt         : Button
    let backButtR        : CGRect
    
    let lv1Lbl          : Text
    let lv1Butt         : Button
    let lv1ButtR        : CGRect
    
    let lv2Lbl          : Text
    let lv2Butt         : Button
    let lv2ButtR        : CGRect
    
    let lv3Lbl          : Text
    let lv3Butt         : Button
    let lv3ButtR        : CGRect
    
    let lv4Lbl          : Text
    let lv4Butt         : Button
    let lv4ButtR        : CGRect
    
    
    override init(size: CGSize)
    {
        let maxAspectRatio:CGFloat = 9.0/16.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        //Labels
        backLbl     = Text(pos: CGPoint(x: 0, y: 0),    says: "Back",           fontSize: 250, font: "font4", color: "green", align: "center")
        titleLabel  = Text(pos: CGPoint(x: 0, y: 0),    says: "Levels !",       fontSize: 150, font: "font1", color: "yellow", align: "center")
        lv1Lbl      = Text(pos: CGPoint(x: 0, y: 0),    says: "1",        fontSize: 200, font: "font3", color: "green", align: "center")
        lv2Lbl      = Text(pos: CGPoint(x: 0, y: 0),    says: "2",        fontSize: 200, font: "font3", color: "green", align: "center")
        lv3Lbl      = Text(pos: CGPoint(x: 0, y: 0),    says: "3",        fontSize: 200, font: "font3", color: "green", align: "center")
        lv4Lbl      = Text(pos: CGPoint(x: 0, y: 0),    says: "4",        fontSize: 200, font: "font3", color: "green", align: "center")
        
        //Rects
        backButtR   = CGRect(x: size.width/2-250, y: size.height-1800, width: 500, height: 200)
        titleButtR  = CGRect(x: size.width/2-350, y: size.height-300,  width: 700, height: 200)
        lv1ButtR    = CGRect(x: size.width/2-375, y: size.height-750,  width: 300, height: 300)
        lv2ButtR    = CGRect(x: size.width/2+75, y: size.height-750,   width: 300, height: 300)
        lv3ButtR    = CGRect(x: size.width/2-375, y: size.height-1150, width: 300, height: 300)
        lv4ButtR    = CGRect(x: size.width/2+75, y: size.height-1150,  width: 300, height: 300)
        
        //Buttons
        backButt    = Button(pos: backButtR,    roundCorner: 100, text: backLbl,    BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        titleButt   = Button(pos: titleButtR,   roundCorner: 100, text: titleLabel, BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: true, glowBulge: false)
        lv1Butt     = Button(pos: lv1ButtR,     roundCorner: 150, text: lv1Lbl,     BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        lv2Butt     = Button(pos: lv2ButtR,     roundCorner: 150, text: lv2Lbl,     BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        lv3Butt     = Button(pos: lv3ButtR,     roundCorner: 150, text: lv3Lbl,     BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        lv4Butt     = Button(pos: lv4ButtR,     roundCorner: 150, text: lv4Lbl,     BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        
        
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
        
        
        //BUTTON/Title
        addChild(titleButt.getButtBG())
        addChild(titleButt.getButtOL())
        addChild(titleButt.getLabel())
        
        addChild(backButt.getButtBG())
        addChild(backButt.getButtOL())
        addChild(backButt.getLabel())
        
        addChild(lv1Butt.getButtBG())
        addChild(lv1Butt.getButtOL())
        addChild(lv1Butt.getLabel())
        
        addChild(lv2Butt.getButtBG())
        addChild(lv2Butt.getButtOL())
        addChild(lv2Butt.getLabel())
        
        addChild(lv3Butt.getButtBG())
        addChild(lv3Butt.getButtOL())
        addChild(lv3Butt.getLabel())
        
        addChild(lv4Butt.getButtBG())
        addChild(lv4Butt.getButtOL())
        addChild(lv4Butt.getLabel())
    }
    
    
    
    
    //PRE-COMPILE DIRECTIVES
    #if os(iOS)
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        if(backButtR.contains(location)){goToGame(0)}
        if(lv1ButtR.contains(location)){goToGame(1)}
        if(lv2ButtR.contains(location)){goToGame(2)}
        if(lv3ButtR.contains(location)){goToGame(3)}
        if(lv4ButtR.contains(location)){goToGame(4)}
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        //sceneTouched(location)
    }
    #else   //OS X
    override func mouseDown(theEvent: NSEvent)
    {
    let location = theEvent.locationInNode(self)
    }
    
    override func mouseDragged(theEvent: NSEvent)
    {
    let location = theEvent.locationInNode(self)
    }
    
    #endif
    
    
    
    
    //TRANSITION
    func goToGame(lvl: Int)
    {
        var transition = SKAction()
        
        switch(lvl)
        {
        case 0:
            transition = SKAction.group([SKAction.runBlock(){
            self.backButt.zoomOUT()
            self.titleButt.FadeAway()
            self.lv1Butt.FadeAway()
            self.lv2Butt.FadeAway()
            self.lv3Butt.FadeAway()
            self.lv4Butt.FadeAway()
            }])
        case 1:
                transition = SKAction.group([SKAction.runBlock(){
                self.backButt.FadeAway()
                self.titleButt.FadeAway()
                self.lv1Butt.zoomOUT()
                self.lv2Butt.FadeAway()
                self.lv3Butt.FadeAway()
                self.lv4Butt.FadeAway()
                }])
        case 2:
                transition = SKAction.group([SKAction.runBlock(){
                self.backButt.FadeAway()
                self.titleButt.FadeAway()
                self.lv1Butt.FadeAway()
                self.lv2Butt.zoomOUT()
                self.lv3Butt.FadeAway()
                self.lv4Butt.FadeAway()
                }])
        case 3:
                transition = SKAction.group([SKAction.runBlock(){
                self.backButt.FadeAway()
                self.titleButt.FadeAway()
                self.lv1Butt.FadeAway()
                self.lv2Butt.FadeAway()
                self.lv3Butt.zoomOUT()
                self.lv4Butt.FadeAway()
                }])
        case 4:
                transition = SKAction.group([SKAction.runBlock(){
                self.backButt.FadeAway()
                self.titleButt.FadeAway()
                self.lv1Butt.FadeAway()
                self.lv2Butt.FadeAway()
                self.lv3Butt.FadeAway()
                self.lv4Butt.zoomOUT()
                }])
        default: transition = SKAction.group([SKAction.runBlock(){println("big boo boo!")}])

        }
    
        let wait = SKAction.waitForDuration(0.5)
        let block = SKAction.runBlock
        {
            let myScene = MainMenuScreen(size: self.size)
            let myScene2 = GameScene.level(lvl)
    
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
            
            if lvl == 0
            {self.view?.presentScene(myScene, transition: reveal)}
            else{self.view?.presentScene(myScene2, transition: reveal)}
            
        }
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
    }
    
}
