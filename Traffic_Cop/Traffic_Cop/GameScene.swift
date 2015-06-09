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
    
    override func didMoveToView(view: SKView)
    {
       // let car = CarSprite(type: 1, spawnX: 500, spawnY: 1000)
       // car.position = car._spawn
       // car.anchorPoint = CGPointZero
       // addChild(car)
        
       
    }
    
    
    //******************************************TOUCH EVENT HANDLING******************************
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
    
    
    //*****************************************AFTER ACTION PROCESS HANDLING*********************
    override func didEvaluateActions()
    {
       // checkCollisions()
    }
    
    
    
    
    
    
    
    
    
}
