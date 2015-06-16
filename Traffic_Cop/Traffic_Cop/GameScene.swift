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
    let car : CarSprite
    let level : Int                     = 0
    let map : Map
    var glowRoads   : [GlowBox]
    var glowCWs     : [GlowBox]
    var glowSpawns  : [GlowCircle]
    var gotoPoints  : [GlowCircle]
    var roadArray   : [Road]
    var spawnsArray : [SpawnPoint]
    var crossWArray : [Crosswalk]
    var vehicleArray: [CarSprite]
    var path = CGPathCreateMutable()
    var spawnAction = SKAction()
    
    //*******************************INIT / SCREEN BOUNDS CALC******************************
    override init(size: CGSize)
    {
        glowRoads       = []
        glowCWs         = []
        glowSpawns      = []
        gotoPoints      = []
        vehicleArray    = []
        map             = Map(lvl: 4)
        roadArray       = map.getRoads()
        spawnsArray     = map.getSpawns()
        crossWArray     = map.getCrossWalks()
      
        
        
   
        
        
        //SET GLOW ROADS
        for road in roadArray
        {
            glowRoads.append(GlowBox(pos: road.rect, roundCorner: 5, OLcolor: "red", OLSize: 15, glowWidth: 2, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        for cw in crossWArray
        {
            glowCWs.append(GlowBox(pos: cw.rect, roundCorner: 5, OLcolor: "yellow", OLSize: 15, glowWidth: 2, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        for spawn in spawnsArray
        {
            glowSpawns.append(GlowCircle(pos: spawn.pos, radius: 20, OLcolor: "green", OLSize: 4, glowWidth: 30, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        
        for road in roadArray
        {
            gotoPoints.append(GlowCircle(pos: road.gotoPoint, radius: 20, OLcolor: "blue", OLSize: 4, glowWidth: 30, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        
        
        
        let maxAspectRatio:CGFloat = 9.0/16.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        car = CarSprite(type: 1, direction: spawnsArray[0])

        super.init(size: size)
        
      
        
        //SET ACTIONS
        let spawn = SKAction.runBlock(){self.spawnVehicle()}
        let wait2 = SKAction.waitForDuration(1)                     //SPAWN TIME !
        let spawnSequence = SKAction.sequence([spawn, wait2])
        spawnAction = SKAction.repeatActionForever(spawnSequence)
        
        
        
        
        
        
        CGPathMoveToPoint(path, nil, CGFloat(709), CGFloat(528))
        CGPathAddQuadCurveToPoint(path, nil,CGFloat(718), CGFloat(690), CGFloat(878), CGFloat(690))
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    //******************************************SCENE INITIALIZATION******************************
    override func didMoveToView(view: SKView)
    {
        //let angle = 1.57079633 * 3
        //car.position = car._spawn
        //car.anchorPoint = CGPointZero
        //let action = SKAction.rotateToAngle(CGFloat(angle), duration: 0.1)
       // car.runAction(action)
        
   
        var tileMap: JSTileMap?
        
        tileMap = JSTileMap(named: "level4v2.tmx")
        
        if tileMap != nil
        {
                self.addChild(tileMap!)
        }
        
        
        
        runAction(spawnAction)
        
        
        
        for road in glowRoads
        {
            addChild(road.getOL())
        }
        
        for cw in glowCWs
        {
            addChild(cw.getOL())
        }
        
        for spawn in glowSpawns
        {
            addChild(spawn.getOL())
        }
        
        for goto in gotoPoints
        {
            addChild(goto.getOL())
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
        
        println("x:\(location.x), y:\(location.y)")
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        
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
        
        
        updateVehicles()

        
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
    
    func spawnVehicle()
    {
        if(vehicleArray.count < 10)
        {
            var car = CarSprite(type: Int.randomNumberFrom(1...6), direction: spawnsArray[Int.randomNumberFrom(0...spawnsArray.count-1)])
            vehicleArray.append(car)
            car.drive()
            
            //car.addChild(car._glowCircle.getOL())
            addChild(car)
        }
       
    }
    
    func updateVehicles()
    {
        func atIntersection(rect: CGRect) -> Bool
        {
            for Cw in crossWArray
            {
                if rect.contains(Cw.rect){return true}
            }
            return false
        }
        
        for(var i = 0; i < vehicleArray.count; i++)
        {
            vehicleArray[i].update()
            
            if(atIntersection(vehicleArray[i].frame)){}      //RECT CHECK
            
            if(vehicleArray[i].isDone(playableRect))
            {
                vehicleArray[i]._glowCircle.getOL().removeFromParent()
                vehicleArray.removeAtIndex(i)
            }
        }
        
    }

    
}
