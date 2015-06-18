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
    let level       : Int               = 0
    let map         : Map
    let clock       : Clock
    let pauseButt   : Button
    let pausedPopUp : Button
    let soundButt   : Button
    var glowRoads   : [GlowBox]
    var glowCWs     : [GlowBox]
    var selection   : GlowBox
    var glowSpawns  : [GlowCircle]
    var gotoPoints  : [GlowCircle]
    var roadArray   : [Road]
    var spawnsArray : [SpawnPoint]
    var peopleSpawns: [SpawnPoint]
    var crossWArray : [Crosswalk]
    var vehicleArray: [CarSprite]
    var peopleArray: [PeopleSprite]
    var chooseRoads : [Road]
 
    
    var path            = CGPathCreateMutable()
    var spawnAction     = SKAction()
    var spawnAction2    = SKAction()
    var timerCount      = CGFloat()
    var timePassed      : Int
    var carSelected     : Bool
    var roadSelected    : Bool
    var pausedOn        : Bool
    var deSelecting     : Bool
    
    //*******************************INIT / SCREEN BOUNDS CALC******************************
    override init(size: CGSize)
    {

        let maxAspectRatio:CGFloat = 9.0/16.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        glowRoads       = []
        glowCWs         = []
        glowSpawns      = []
        gotoPoints      = []
        vehicleArray    = []
        peopleArray    = []
        chooseRoads     = []
        selection       = GlowBox(pos: playableRect, roundCorner: 3, OLcolor: "yellow", OLSize: 1, glowWidth: 1, ZoomIn: true, glowBulge: true, alpha: 0)
        map             = Map(lvl: 4)
        roadArray       = map.getRoads()
        spawnsArray     = map.getSpawns()
        crossWArray     = map.getCrossWalks()
        peopleSpawns    = map.getPeopleSpawns()
        timerCount      = CGFloat(0.0)
        timePassed      = 0
        carSelected     = false
        roadSelected    = false
        pausedOn        = false
        deSelecting     = false
        clock           = Clock(playableR: playableRect, countFrom: 300)
        
        var pauseLabel  = Text(pos: CGPoint(x: size.width/2, y:0),    says: "ll",       fontSize: 70, font: "font2", color: "green",  align: "center")
        var pausedLabel = Text(pos: CGPoint(x: size.width/2, y:0),    says: "Paused",   fontSize: 300, font: "font2", color: "green",  align: "center")
        var soundLabel  = Text(pos: CGPoint(x: size.width/2, y:0),    says: "(=",       fontSize: 70, font: "font2", color: "green",  align: "center")
        pauseButt       = Button(pos: CGRect(origin: CGPoint(x: 32, y: TW*14), size: CGSize(width: 128, height: 128)), roundCorner: 64, text: pauseLabel, BGcolor: "halfblack", OLcolor: "red", OLSize: 2, glowWidth: 3, ZoomIn: true, Bulge: false, glowBulge: false)
        pausedPopUp     = Button(pos: CGRect(origin: CGPoint(x: 32, y: TW*2), size: CGSize(width: Int(size.width-32), height: TW*9)), roundCorner: 70, text: pausedLabel, BGcolor: "halfblack", OLcolor: "red", OLSize: 10, glowWidth: 8, ZoomIn: true, Bulge: true, glowBulge: true)
        soundButt       = Button(pos: CGRect(origin: CGPoint(x: TW*7-32, y: TW*14), size: CGSize(width: 128, height: 128)), roundCorner: 64, text: soundLabel, BGcolor: "halfblack", OLcolor: "red", OLSize: 2, glowWidth: 3, ZoomIn: true, Bulge: false, glowBulge: false)

        //SET GLOW ROADS
        for road in roadArray
        {
            glowRoads.append(GlowBox(pos: road.rect, roundCorner: 64, OLcolor: "green", OLSize: 15, glowWidth: 2, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        for cw in crossWArray
        {
            glowCWs.append(GlowBox(pos: cw.rect, roundCorner: 40, OLcolor: "yellow", OLSize: 15, glowWidth: 2, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        for spawn in peopleSpawns
        {
            glowSpawns.append(GlowCircle(pos: spawn.pos, radius: 20, OLcolor: "green", OLSize: 4, glowWidth: 30, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        
        for road in roadArray
        {
            gotoPoints.append(GlowCircle(pos: road.gotoPoint, radius: 20, OLcolor: "blue", OLSize: 4, glowWidth: 30, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        
        
        

        super.init(size: size)
        scene?.scaleMode = .AspectFit
      
        
        //SET ACTIONS
        let spawn = SKAction.runBlock(){self.spawnVehicle();}
        let wait = SKAction.waitForDuration(1)                     //SPAWN TIME !
        let spawnSequence = SKAction.sequence([spawn, wait])
        spawnAction = SKAction.repeatActionForever(spawnSequence)
        
        let spawn2 = SKAction.runBlock(){self.spawnPerson();}
        let wait2 = SKAction.waitForDuration(2)                     //SPAWN PEOPLE TIME !
        let spawnSequence2 = SKAction.sequence([spawn2, wait2])
        spawnAction2 = SKAction.repeatActionForever(spawnSequence2)
        
        
        
        
 
        
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
        
        

        //WAIT 1 SEC BEFORE STARTING UP THE SPAWN ACTIONS
        let transition = SKAction.runBlock()
            {
                //RUN ACTIONS
                self.runAction(self.spawnAction)
                self.runAction(self.spawnAction2)
            }
        let wait = SKAction.waitForDuration(1)
        let transSequence = SKAction.sequence([wait,transition])
        self.runAction(transSequence)
        
  
        
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
    
        clock.clockButt.getButtBG().zPosition = 100
        clock.clockButt.getButtOL().zPosition = 100
        clock.clockLabel.get().zPosition = 100
        
        addChild(clock.clockButt.getButtBG())
        addChild(clock.clockButt.getButtOL())
        addChild(clock.clockLabel.get())
        
        addChild(pauseButt.getButtBG())
        addChild(pauseButt.getButtOL())
        addChild(pauseButt.getLabel())
        
        addChild(soundButt.getButtBG())
        addChild(soundButt.getButtOL())
        addChild(soundButt.getLabel())
        addChild(selection.OL)
        
       //debugDrawPLayableArea()
    }
    
    
    
    
    
    //******************************************TOUCH EVENT HANDLING******************************
    
    //PRE-COMPILE DIRECTIVES
    #if os(iOS)
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        
        handleTouchSequence(location)

        //println("x:\(location.x), y:\(location.y)")
        
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
        if(!pausedOn){
        if lastUpdateTime > 0 {dt = currentTime - lastUpdateTime} else {dt = 0}
        lastUpdateTime = currentTime
        
        timerCount += CGFloat(dt*1000)
        if(timerCount >= 1000)
        {
            //ONE SECOND HAS PASSED
            timerCount = 0
            timePassed++
            clock.upDateTime(-1)
            //println("\(timePassed)")
        }}
        
        //UPDATE ALL OUR STUFFS HERE
        
        if(!pausedOn)
        {
            updateVehicles()
            updatePeople()
        }
      

        
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
        if(!pausedOn)
        {
        if(vehicleArray.count < 10)
        {
            var car = CarSprite(type: Int.randomNumberFrom(1...6), direction: spawnsArray[Int.randomNumberFrom(0...spawnsArray.count-1)])
            vehicleArray.append(car)
            car.drive()
            
            //car.addChild(car._glowCircle.getOL())
            addChild(car)
            }}
       
    }
    
    func spawnPerson()
    {
        if(!pausedOn)
        {
        if(peopleArray.count < 20)
        {
            var person = PeopleSprite(type: Int.randomNumberFrom(1...4), direction: peopleSpawns[Int.randomNumberFrom(0...peopleSpawns.count-1)])
            peopleArray.append(person)
            person.walk()
            addChild(person)
        }}
    }
    
 
    func updateVehicles()
    {
        func atIntersection(pos: CGPoint) -> Bool
        {
            for Cw in crossWArray
            {
                if Cw.rect.contains(CGPoint(x: pos.x-80, y: pos.y-80)) || Cw.rect.contains(CGPoint(x: pos.x+80, y: pos.y+80)) ||
                    Cw.rect.contains(CGPoint(x: pos.x-80, y: pos.y+80)) || Cw.rect.contains(CGPoint(x: pos.x+80, y: pos.y-80))
                {
                    return true
                }
                
            }
            return false
        }
        
        for(var i = 0; i < vehicleArray.count; i++)
        {
            vehicleArray[i].update()
            
            if(atIntersection(vehicleArray[i].position))
            {
                vehicleArray[i].stop()
            }      //RECT CHECK
            
            if(vehicleArray[i].isDone(playableRect))
            {
                vehicleArray[i].removeFromParent()
                vehicleArray.removeAtIndex(i)
            }
        }
        
    }
    
    func updatePeople()
    {
        func atIntersection(pos: CGPoint ) -> Bool
        {
            for Cw in crossWArray
            {
                if Cw.rect.contains(CGPoint(x: pos.x-63.5, y: pos.y-63.5)) || Cw.rect.contains(CGPoint(x: pos.x+63.5, y: pos.y+63.5)) ||
                    Cw.rect.contains(CGPoint(x: pos.x-63.5, y: pos.y+63.5)) || Cw.rect.contains(CGPoint(x: pos.x+63.5, y: pos.y-63.5))
                {return true}
            }
            return false
        }
        
        for(var i = 0; i < peopleArray.count; i++)
        {
            peopleArray[i].update()
            
            if(atIntersection(peopleArray[i].position)){
                if(peopleArray[i]._type == 4)
                {
                peopleArray[i].walk()
                }
                else
                {
                peopleArray[i].stop()
                }
            }
            
            //RECT CHECK
            
            if(peopleArray[i].isDone(playableRect))
            {
                peopleArray[i].removeFromParent()
                peopleArray.removeAtIndex(i)
            }
        }
    }
    
    func deSelectCars()
    {
        
        for car in vehicleArray
        {
            car._isSelected = false
        }
        carSelected = false
      
        let transition = SKAction.group([SKAction.runBlock()
            {
                self.deSelecting = true
                self.deIlluminateRoads()
                self.selection.zoomOUT()
            }])
        let block = SKAction.runBlock(){self.selection.OL.removeFromParent(); self.deSelecting = false}
        let wait = SKAction.waitForDuration(0.3)
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
        
        
    }
    func selectCar(car : CarSprite)
    {
        if car._state == .STOPPED
        {
        selection.OL.removeFromParent()
        selection = GlowBox(pos: car.frame, roundCorner: 20, OLcolor: "yellow", OLSize: 1, glowWidth: 1, ZoomIn: true, glowBulge: true, alpha: 1)
        addChild(selection.OL)
        }
    }
    func handleTouchSequence(location: CGPoint)
    {
        if(pausedOn)
        {
            if(playableRect.contains(location))
            {
                unPauseGame()
            }
        }
        
        if(!pausedOn && !deSelecting)
        {
            if(pauseButt.origRect.contains(location))
            {
                pausedOn = true
                //PAUSED POPUP
                pausedPopUp.getButtBG().name = "pausePopUp"
                pausedPopUp.getButtOL().name = "pausePopUp"
                pausedPopUp.getLabel().name = "pausePopUp"
                addChild(pausedPopUp.getButtBG())
                addChild(pausedPopUp.getButtOL())
                addChild(pausedPopUp.getLabel())
                pausedPopUp.zoomIN()
            }
        
            if(carSelected)
            {
                for theRoad in chooseRoads
                {
                    if(theRoad.rect.contains(location))
                    {
                        for theCar in vehicleArray
                        {
                            if (theCar._isSelected){self.drawDrivePath(theCar, road: theRoad); break;}
                        }
                        break
                    }
                }
                
                let transition = SKAction.group([SKAction.runBlock()
                    {
                        self.deSelectCars()
                    }])
                let wait = SKAction.waitForDuration(0.3)
                let transSequence = SKAction.sequence([transition,wait])
                self.runAction(transSequence)
                
            }
            
            if(!carSelected)
            {
                for car in vehicleArray
                {
                    if(car.frame.contains(location) && car._state == .STOPPED)
                    {
                        if(!carSelected)
                        {
                            car._isSelected = true
                            carSelected = true;
                            selectCar(car)
                            illuminateRoads(car)
                        }
                    }
                }
            }
        }
    }
    
    func unPauseGame()
    {
        let transition = SKAction.group([SKAction.runBlock()
            {
            self.pausedPopUp.zoomOUT()
            }])
        
        let wait = SKAction.waitForDuration(0.2)
        
        let block = SKAction.runBlock{
            self.childNodeWithName("pausePopUp")?.removeFromParent()
            self.childNodeWithName("pausePopUp")?.removeFromParent()
            self.childNodeWithName("pausePopUp")?.removeFromParent()
            self.pausedOn = false
          
        }
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
    }
    
    func illuminateRoads(car : CarSprite)
    {
            var carOn : Road = map.getCurRoad(car.position)
            
            let transition = SKAction.group([SKAction.runBlock()
                {
                    var roadSide = carOn.Side
                    
                    for road in self.map.roadArray
                    {
                        if road.Side == roadSide {}                                 //SAME SIDE ROADS..DO Natta
                        else{self.chooseRoads.append(road)}                         //ROADS NOT ON SAME SIDE ... array em up
                    }
                    
                    for road in self.glowRoads
                    {
                        for theRoad in self.chooseRoads
                        {
                            if road.origRect.contains(theRoad.rect)
                            {
                                self.addChild(road.getOL())
                                road.zoomIN()
                                break;
                            }
                        }
                    }
                }])
            
            let wait = SKAction.waitForDuration(0.3)
            
            let block = SKAction.runBlock{  }
            
            let transSequence = SKAction.sequence([transition,wait,block])
            self.runAction(transSequence)
    
        
    }
    func deIlluminateRoads()
    {
        let transition = SKAction.group([SKAction.runBlock()
            {
                for road in self.glowRoads
                {
                    road.zoomOUT()
                }
            }])
        
        let wait = SKAction.waitForDuration(0.3)
        
        let block = SKAction.runBlock{
            for road in self.glowRoads
            {
                self.chooseRoads.removeAll(keepCapacity: false) //CLEAR ALL ROADS THAT COULD BE CHOSEN
                road.getOL().removeFromParent()
            }
        }
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
        
        
   
    }
    
    
    func drawDrivePath(car: CarSprite, road: Road)
    {
        CGPathMoveToPoint(path, nil , car.position.x, car.position.y)
        
        let midPoint = CGPoint(x: (car.position.x+road.gotoPoint.x)/2, y: (car.position.y+road.gotoPoint.y)/2)
      
        if(road.Side == "left" || road.Side == "right")
        {
//            CGPathAddArcToPoint(path,nil, <#x1: CGFloat#>, <#y1: CGFloat#>, road.gotoPoint.x, road.gotoPoint.y, radius: CGFloat.())
           
            CGPathAddCurveToPoint(path, nil,
                size.width/2, CGFloat(TW*7),
                midPoint.x, midPoint.y,
                road.gotoPoint.x, road.gotoPoint.y);
        }
        if(road.Side == "top" || road.Side == "bottom")
        {
            CGPathAddCurveToPoint(path, nil,
                size.width/2, CGFloat(TW*7),
                midPoint.x, midPoint.y,
                road.gotoPoint.x, road.gotoPoint.y);
        }
    
        
        let thePath = SKShapeNode()
        thePath.path = path
        thePath.strokeColor = SKColor.cyanColor()
        thePath.name = "path"
        addChild(thePath)
        
//        //MAKE OUR TURN HANDLE THE EXECUTION
//        CGPathMoveToPoint(path, nil, CGFloat(709), CGFloat(528))
//        CGPathAddQuadCurveToPoint(path, nil,CGFloat(718), CGFloat(690), CGFloat(878), CGFloat(690))
    }
    
}
