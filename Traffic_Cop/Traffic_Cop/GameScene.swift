//
//  GameScene.swift
//  Traffic_Cop
//
//  Created by Mathew  Manton on 2015-06-05.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene
{
    //*******************************CONSTANTS / VARIABLES******************************
    var lastUpdateTime: NSTimeInterval  = 0
    var dt: NSTimeInterval              = 0                             //DELTA TIME
    let playableRect: CGRect                                            //GAME BOUNDS
    let TW                              = 128                           //TILEWIDTH
    
    
    
    
    
    
    //*******************************INIT / SCREEN BOUNDS CALC******************************
    override init(size: CGSize)
    {
        let maxAspectRatio:CGFloat = 9.0/16.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        super.init(size: size)
    }
    required init(coder aDecoder: NSCoder){fatalError("init(coder:) has not been implemented")}
    

    
    
    
    
    
    
    //******************************************SCENE INITIALIZATION******************************
    override func didMoveToView(view: SKView)
    {
       // let car = CarSprite(type: 1, spawnX: 500, spawnY: 1000)
       // car.position = car._spawn
       // car.anchorPoint = CGPointZero
       // addChild(car)
        var tileMap: JSTileMap?
        
        tileMap = JSTileMap(named: "level1.tmx")
        
        if tileMap != nil
        {
                self.addChild(tileMap!)
        }
        
        
       //debugDrawPLayableArea()
    }
    
    
    
    
    
    //******************************************TOUCH EVENT HANDLING******************************
    
    //PRE-COMPILE DIRECTIVES
    #if os(iOS)
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        //sceneTouched(location)
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
    
    
    //*****************************************THE ALL MIGHTY UPDATE******************************
    override func update(currentTime: CFTimeInterval)
    {
        if lastUpdateTime > 0 {dt = currentTime - lastUpdateTime} else {dt = 0}
        lastUpdateTime = currentTime
        
        //println("\(dt*1000) milliseconds since last update")
        
        //UPDATE ALL OUR STUFFS HERE
    }
    
    
    
    
    //*****************************************AFTER ACTION PROCESS HANDLING*********************
    override func didEvaluateActions()
    {
       // checkCollisions()
    }
    
    
    
    
    //*****************************************SPAWNING VEHICLES / PEOPLE************************
    
    
    
    
    
    
    //*****************************************HELPER FUNCTIONS / OTHERS*************************
    
    func debugDrawPLayableArea()
    {
        let shape2 = SKShapeNode()
        let path2 = CGPathCreateMutable()
        CGPathAddRect(path2, nil, playableRect)
        shape2.path = path2
        shape2.fillColor = SKColor.greenColor()
        shape2.lineWidth = 35.0
        addChild(shape2)
        
        let shape = SKShapeNode()
        let path = CGPathCreateMutable()
        CGPathAddRect(path, nil, playableRect)
        shape.path = path
        shape.strokeColor = SKColor.blueColor()
        shape.lineWidth = 35.0
        addChild(shape)
    }
    
}
