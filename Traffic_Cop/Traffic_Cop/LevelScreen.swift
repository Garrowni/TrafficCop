//
//  LevelScreen.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-12.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//


import Foundation
import SpriteKit

class LevelScreen: SKScene
{
    let playableRect: CGRect
    
    let titleLabel      : Text
    let titleButt       : Button
    let titleButtR      : CGRect
    
    let loadingLabel      : Text
    let loadingButt       : Button
    let loadingButtR      : CGRect
    
    let backLbl          : Text
    let backButt         : Button
    let backButtR        : CGRect
    
    let lv1Lbl          : Text
    let lv1Butt         : Button
    let lv1ButtR        : CGRect
    
    
    let lv2Lbl          : Text
    let lv2Butt         : Button
    let lv2ButtR        : CGRect

    var lv2Lock         : SKSpriteNode = SKSpriteNode(imageNamed: "PadLockLocked")
    
    let lv3Lbl          : Text
    let lv3Butt         : Button
    let lv3ButtR        : CGRect
  
    var lv3Lock         : SKSpriteNode = SKSpriteNode(imageNamed: "PadLockLocked")
    
    let lv4Lbl          : Text
    let lv4Butt         : Button
    let lv4ButtR        : CGRect
 
    var lv4Lock         : SKSpriteNode = SKSpriteNode(imageNamed: "PadLockLocked")
    
    
    //******Star System**********
    var lv1BronzeStarOutline : SKSpriteNode
    var lv1SilverStarOutline : SKSpriteNode
    var lv1GoldStarOutline : SKSpriteNode
    var lv2BronzeStarOutline : SKSpriteNode
    var lv2SilverStarOutline : SKSpriteNode
    var lv2GoldStarOutline : SKSpriteNode
    var lv3BronzeStarOutline : SKSpriteNode
    var lv3SilverStarOutline : SKSpriteNode
    var lv3GoldStarOutline : SKSpriteNode
    var lv4BronzeStarOutline : SKSpriteNode
    var lv4SilverStarOutline : SKSpriteNode
    var lv4GoldStarOutline : SKSpriteNode
    
    var lv1BronzeStar : SKSpriteNode
    var lv1SilverStar : SKSpriteNode
    var lv1GoldStar : SKSpriteNode
    var lv2BronzeStar : SKSpriteNode
    var lv2SilverStar : SKSpriteNode
    var lv2GoldStar : SKSpriteNode
    var lv3BronzeStar : SKSpriteNode
    var lv3SilverStar : SKSpriteNode
    var lv3GoldStar : SKSpriteNode
    var lv4BronzeStar : SKSpriteNode
    var lv4SilverStar : SKSpriteNode
    var lv4GoldStar : SKSpriteNode
    
    //*********End Star System************
    
    var loading: Bool = false
    
    override init(size: CGSize)
    {
        let maxAspectRatio:CGFloat = 9.0/16.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        //Labels
        backLbl     = Text(pos: CGPoint(x: 0, y: 0),    says: "Back",           fontSize: 250, font: "font4", color: "green", align: "center")
        titleLabel  = Text(pos: CGPoint(x: 0, y: 0),    says: "Levels !",       fontSize: 150, font: "font1", color: "yellow", align: "center")
        loadingLabel  = Text(pos: CGPoint(x: 0, y: 0),    says: "Loading...",       fontSize: 150, font: "font1", color: "yellow", align: "center")
        lv1Lbl      = Text(pos: CGPoint(x: 0, y: 0),    says: "1",              fontSize: 200, font: "font3", color: "green", align: "center")
        lv2Lbl      = Text(pos: CGPoint(x: 0, y: 0),    says: "2",              fontSize: 200, font: "font3", color: "green", align: "center")
        lv3Lbl      = Text(pos: CGPoint(x: 0, y: 0),    says: "3",              fontSize: 200, font: "font3", color: "green", align: "center")
        lv4Lbl      = Text(pos: CGPoint(x: 0, y: 0),    says: "4",              fontSize: 200, font: "font3", color: "green", align: "center")
        
        //Rects
        backButtR   = CGRect(x: size.width/2-250, y: size.height-1800, width: 500, height: 200)
        titleButtR  = CGRect(x: size.width/2-350, y: size.height-250,  width: 700, height: 200)
        loadingButtR = CGRect(x: size.width/2-450, y: size.height/2-400,  width: 900, height: 800)
        lv1ButtR    = CGRect(x: size.width/2-405, y: size.height-650,  width: 300, height: 300)
        lv2ButtR    = CGRect(x: size.width/2+115, y: size.height-650,  width: 300, height: 300)
        lv3ButtR    = CGRect(x: size.width/2-405, y: size.height-1150, width: 300, height: 300)
        lv4ButtR    = CGRect(x: size.width/2+115, y: size.height-1150, width: 300, height: 300)
        
        //Buttons
        backButt    = Button(pos: backButtR,    roundCorner: 100, text: backLbl,    BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        titleButt   = Button(pos: titleButtR,   roundCorner: 100, text: titleLabel, BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: true, glowBulge: false)
        loadingButt = Button(pos: loadingButtR, roundCorner: 100, text: loadingLabel, BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: true, glowBulge: false)
        lv1Butt     = Button(pos: lv1ButtR,     roundCorner: 150, text: lv1Lbl,     BGcolor: "halfblack", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        lv2Butt     = Button(pos: lv2ButtR,     roundCorner: 150, text: lv2Lbl,     BGcolor: "halfblack", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        lv3Butt     = Button(pos: lv3ButtR,     roundCorner: 150, text: lv3Lbl,     BGcolor: "halfblack", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        lv4Butt     = Button(pos: lv4ButtR,     roundCorner: 150, text: lv4Lbl,     BGcolor: "halfblack", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        
        //****************Star System Init****************************
        lv1BronzeStarOutline = SKSpriteNode(imageNamed: "StarOutline")
        lv1SilverStarOutline = SKSpriteNode(imageNamed: "StarOutline")
        lv1GoldStarOutline   = SKSpriteNode(imageNamed: "StarOutline")
        lv2BronzeStarOutline = SKSpriteNode(imageNamed: "StarOutline")
        lv2SilverStarOutline = SKSpriteNode(imageNamed: "StarOutline")
        lv2GoldStarOutline   = SKSpriteNode(imageNamed: "StarOutline")
        lv3BronzeStarOutline = SKSpriteNode(imageNamed: "StarOutline")
        lv3SilverStarOutline = SKSpriteNode(imageNamed: "StarOutline")
        lv3GoldStarOutline   = SKSpriteNode(imageNamed: "StarOutline")
        lv4BronzeStarOutline = SKSpriteNode(imageNamed: "StarOutline")
        lv4SilverStarOutline = SKSpriteNode(imageNamed: "StarOutline")
        lv4GoldStarOutline   = SKSpriteNode(imageNamed: "StarOutline")
        
        lv1BronzeStar = SKSpriteNode(imageNamed: "BronzeStar")
        lv1SilverStar = SKSpriteNode(imageNamed: "SilverStar")
        lv1GoldStar   = SKSpriteNode(imageNamed: "GoldStar")
        lv2BronzeStar = SKSpriteNode(imageNamed: "BronzeStar")
        lv2SilverStar = SKSpriteNode(imageNamed: "SilverStar")
        lv2GoldStar   = SKSpriteNode(imageNamed: "GoldStar")
        lv3BronzeStar = SKSpriteNode(imageNamed: "BronzeStar")
        lv3SilverStar = SKSpriteNode(imageNamed: "SilverStar")
        lv3GoldStar   = SKSpriteNode(imageNamed: "GoldStar")
        lv4BronzeStar = SKSpriteNode(imageNamed: "BronzeStar")
        lv4SilverStar = SKSpriteNode(imageNamed: "SilverStar")
        lv4GoldStar   = SKSpriteNode(imageNamed: "GoldStar")

        lv1BronzeStarOutline.zPosition = 5
        lv1SilverStarOutline.zPosition = 5
        lv1GoldStarOutline.zPosition   = 5
        lv2BronzeStarOutline.zPosition = 5
        lv2SilverStarOutline.zPosition = 5
        lv2GoldStarOutline.zPosition   = 5
        lv3BronzeStarOutline.zPosition = 5
        lv3SilverStarOutline.zPosition = 5
        lv3GoldStarOutline.zPosition   = 5
        lv4BronzeStarOutline.zPosition = 5
        lv4SilverStarOutline.zPosition = 5
        lv4GoldStarOutline.zPosition   = 5
        
        lv1BronzeStarOutline.xScale = 0.25
        lv1SilverStarOutline.xScale = 0.25
        lv1GoldStarOutline.xScale = 0.25
        lv2BronzeStarOutline.xScale = 0.25
        lv2SilverStarOutline.xScale = 0.25
        lv2GoldStarOutline.xScale = 0.25
        lv3BronzeStarOutline.xScale = 0.25
        lv3SilverStarOutline.xScale = 0.25
        lv3GoldStarOutline.xScale = 0.25
        lv4BronzeStarOutline.xScale = 0.25
        lv4SilverStarOutline.xScale = 0.25
        lv4GoldStarOutline.xScale = 0.25
        
        lv1BronzeStarOutline.yScale = 0.25
        lv1SilverStarOutline.yScale = 0.25
        lv1GoldStarOutline.yScale = 0.25
        lv2BronzeStarOutline.yScale = 0.25
        lv2SilverStarOutline.yScale = 0.25
        lv2GoldStarOutline.yScale = 0.25
        lv3BronzeStarOutline.yScale = 0.25
        lv3SilverStarOutline.yScale = 0.25
        lv3GoldStarOutline.yScale = 0.25
        lv4BronzeStarOutline.yScale = 0.25
        lv4SilverStarOutline.yScale = 0.25
        lv4GoldStarOutline.yScale = 0.25
        
        lv1BronzeStarOutline.position = CGPoint(x: lv1Butt.label.position.x-60, y: lv1Butt.label.position.y-180)
        lv1SilverStarOutline.position = CGPoint(x: lv1Butt.label.position.x, y: lv1Butt.label.position.y-200)
        lv1GoldStarOutline.position   = CGPoint(x: lv1Butt.label.position.x+60, y: lv1Butt.label.position.y-180)
        lv2BronzeStarOutline.position = CGPoint(x: lv2Butt.label.position.x-60, y: lv2Butt.label.position.y-180)
        lv2SilverStarOutline.position = CGPoint(x: lv2Butt.label.position.x, y: lv2Butt.label.position.y-200)
        lv2GoldStarOutline.position   = CGPoint(x: lv2Butt.label.position.x+60, y: lv2Butt.label.position.y-180)
        lv3BronzeStarOutline.position = CGPoint(x: lv3Butt.label.position.x-60, y: lv3Butt.label.position.y-180)
        lv3SilverStarOutline.position = CGPoint(x: lv3Butt.label.position.x, y: lv3Butt.label.position.y-200)
        lv3GoldStarOutline.position   = CGPoint(x: lv3Butt.label.position.x+60, y: lv3Butt.label.position.y-180)
        lv4BronzeStarOutline.position = CGPoint(x: lv4Butt.label.position.x-60, y: lv4Butt.label.position.y-180)
        lv4SilverStarOutline.position = CGPoint(x: lv4Butt.label.position.x, y: lv4Butt.label.position.y-200)
        lv4GoldStarOutline.position   = CGPoint(x: lv4Butt.label.position.x+60, y: lv4Butt.label.position.y-180)

        
        lv1BronzeStar.zPosition = 6
        lv1SilverStar.zPosition = 6
        lv1GoldStar.zPosition = 6
        lv2BronzeStar.zPosition = 6
        lv2SilverStar.zPosition = 6
        lv2GoldStar.zPosition = 6
        lv3BronzeStar.zPosition = 6
        lv3SilverStar.zPosition = 6
        lv3GoldStar.zPosition = 6
        lv4BronzeStar.zPosition = 6
        lv4SilverStar.zPosition = 6
        lv4GoldStar.zPosition = 6
        
        lv1BronzeStar.xScale = 0.25
        lv1SilverStar.xScale = 0.25
        lv1GoldStar.xScale = 0.25
        lv2BronzeStar.xScale = 0.25
        lv2SilverStar.xScale = 0.25
        lv2GoldStar.xScale = 0.25
        lv3BronzeStar.xScale = 0.25
        lv3SilverStar.xScale = 0.25
        lv3GoldStar.xScale = 0.25
        lv4BronzeStar.xScale = 0.25
        lv4SilverStar.xScale = 0.25
        lv4GoldStar.xScale = 0.25
        
        lv1BronzeStar.yScale = 0.25
        lv1SilverStar.yScale = 0.25
        lv1GoldStar.yScale = 0.25
        lv2BronzeStar.yScale = 0.25
        lv2SilverStar.yScale = 0.25
        lv2GoldStar.yScale = 0.25
        lv3BronzeStar.yScale = 0.25
        lv3SilverStar.yScale = 0.25
        lv3GoldStar.yScale = 0.25
        lv4BronzeStar.yScale = 0.25
        lv4SilverStar.yScale = 0.25
        lv4GoldStar.yScale = 0.25
        
        lv1BronzeStar.position = lv1BronzeStarOutline.position
        lv1SilverStar.position = lv1SilverStarOutline.position
        lv1GoldStar.position = lv1GoldStarOutline.position
        lv2BronzeStar.position = lv2BronzeStarOutline.position
        lv2SilverStar.position = lv2SilverStarOutline.position
        lv2GoldStar.position = lv2GoldStarOutline.position
        lv3BronzeStar.position = lv3BronzeStarOutline.position
        lv3SilverStar.position = lv3SilverStarOutline.position
        lv3GoldStar.position = lv3GoldStarOutline.position
        lv4BronzeStar.position = lv4BronzeStarOutline.position
        lv4SilverStar.position = lv4SilverStarOutline.position
        lv4GoldStar.position = lv4GoldStarOutline.position
        
        //****************End Star System Init****************************
        
        
        super.init(size: size)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView)
    {
        
        let sequence = SKAction.sequence([SKAction.scaleTo(0.5, duration: 0.2),SKAction.waitForDuration(0.2), SKAction.scaleTo(0.25, duration: 0.2)])
        
        var background:SKSpriteNode
        background = SKSpriteNode(imageNamed: "levelsBG")
        background.position =  CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(background)
        
        addChild(lv1BronzeStarOutline)
        addChild(lv1SilverStarOutline)
        addChild(lv1GoldStarOutline)
        
        lv2Lock.position = lv2Butt.label.position
        lv3Lock.position = lv3Butt.label.position
        lv4Lock.position = lv4Butt.label.position
        
        lv2Lock.zPosition = 10
        lv3Lock.zPosition = 10
        lv4Lock.zPosition = 10
        
        if(HighScore(1) >= lv1Bronze)
        {
            
            lv1BronzeStar.runAction(sequence)
            addChild(lv1BronzeStar)
        }
         if(HighScore(1) >= lv1Silver)
        {
            
            lv1SilverStar.runAction(sequence)
            addChild(lv1SilverStar)
        
        }
         if(HighScore(1) >= lv1Gold)
        {
           
            lv1GoldStar.runAction(sequence)
            addChild(lv1GoldStar)
        }
        
        
        if(!Lev2())
        {
            addChild(lv2Lock)
        }
        else
        {
            lv2Lock.removeFromParent()
            
            
            addChild(lv2BronzeStarOutline)
            addChild(lv2SilverStarOutline)
            addChild(lv2GoldStarOutline)
            
            if(HighScore(2) >= lv2Bronze )
            {
                
                lv2BronzeStar.runAction(sequence)
                addChild(lv2BronzeStar)
            }
            if(HighScore(2) >= lv2Silver)
            {
              
                lv2SilverStar.runAction(sequence)
                addChild(lv2SilverStar)
            }
            if(HighScore(2) >= lv2Gold)
            {
                
                lv2GoldStar.runAction(sequence)
                addChild(lv2GoldStar)
            }
        }
        
        if(!Lev3())
        {
            addChild(lv3Lock)
        }
        else
        {
            lv3Lock.removeFromParent()
            addChild(lv3BronzeStarOutline)
            addChild(lv3SilverStarOutline)
            addChild(lv3GoldStarOutline)
            
            if(HighScore(3) >= lv3Bronze)
            {
                
                lv3BronzeStar.runAction(sequence)
                addChild(lv3BronzeStar)
            }
            if(HighScore(3) >= lv3Silver)
            {
                
                lv3SilverStar.runAction(sequence)
                addChild(lv3SilverStar)
            }
            if(HighScore(3) >= lv3Gold)
            {
                
                lv3GoldStar.runAction(sequence)
                addChild(lv3GoldStar)
            }
        }
        
        if(!Lev4())
        {
            addChild(lv4Lock)
        }
        else
        {
            lv4Lock.removeFromParent()
            
            addChild(lv4BronzeStarOutline)
            addChild(lv4SilverStarOutline)
            addChild(lv4GoldStarOutline)
            
            if(HighScore(4) >= lv4Bronze)
            {
               
                lv4BronzeStar.runAction(sequence)
                 addChild(lv4BronzeStar)
            }
            if(HighScore(4) >= lv4Silver)
            {
                
                lv4SilverStar.runAction(sequence)
                addChild(lv4SilverStar)
            }
            if(HighScore(4) >= lv4Gold)
            {
                
                lv4GoldStar.runAction(sequence)
                addChild(lv4GoldStar)
            }
        }
        
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
        if(lv2ButtR.contains(location) && Lev2()){goToGame(2)}
        if(lv3ButtR.contains(location) && Lev3()){goToGame(3)}
        if(lv4ButtR.contains(location) && Lev4()){goToGame(4)}
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
    {  backgroundMusicPlayer.stop()
        
        var transition = SKAction()

        if(!loading)
        {
            addChild(loadingButt.getButtBG())
            addChild(loadingButt.getButtOL())
            addChild(loadingButt.getLabel())
            loadingButt.zoomIN()
            loading = true
        }
   
        if lv1BronzeStar.parent != nil
        {
            lv1BronzeStar.removeFromParent()
        }
        if lv1SilverStar.parent != nil
        {
            lv1SilverStar.removeFromParent()
        }
        if lv1GoldStar.parent != nil
        {
            lv1GoldStar.removeFromParent()
        }
        if lv2BronzeStar.parent != nil
        {
            lv2BronzeStar.removeFromParent()
        }
        if lv2SilverStar.parent != nil
        {
            lv2SilverStar.removeFromParent()
        }
        if lv2GoldStar.parent != nil
        {
            lv2GoldStar.removeFromParent()
        }
        if lv3BronzeStar.parent != nil
        {
            lv3BronzeStar.removeFromParent()
        }
        if lv3SilverStar.parent != nil
        {
            lv3SilverStar.removeFromParent()
        }
        if lv3GoldStar.parent != nil
        {
            lv3GoldStar  .removeFromParent()
        }
        if lv4BronzeStar.parent != nil
        {
        lv4BronzeStar.removeFromParent()
        }
        if lv4SilverStar.parent != nil
        {
            lv4SilverStar.removeFromParent()
        }
        if lv4GoldStar.parent != nil
        {
            lv4GoldStar.removeFromParent()
        }
        
        if lv1BronzeStarOutline.parent != nil
        {
        lv1BronzeStarOutline.removeFromParent()
        lv1SilverStarOutline.removeFromParent()
        lv1GoldStarOutline.removeFromParent()
        }
        if lv2BronzeStarOutline.parent != nil
        {
        lv2BronzeStarOutline.removeFromParent()
        lv2SilverStarOutline.removeFromParent()
        lv2GoldStarOutline.removeFromParent()
        }
        if lv3BronzeStarOutline.parent != nil
        {
        lv3BronzeStarOutline.removeFromParent()
        lv3SilverStarOutline.removeFromParent()
        lv3GoldStarOutline.removeFromParent()
        }
        if lv4BronzeStarOutline.parent != nil
        {
        lv4BronzeStarOutline.removeFromParent()
        lv4SilverStarOutline.removeFromParent()
        lv4GoldStarOutline.removeFromParent()
        }
        playBackgroundMusic("Life of Riley.mp3")
        
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
        if(lv2Lock.parent != nil)
        {
            lv2Lock.removeFromParent()
        }
        if(lv3Lock.parent != nil)
        {
            lv3Lock.removeFromParent()
        }
        if(lv4Lock.parent != nil)
        {
            lv4Lock.removeFromParent()
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
