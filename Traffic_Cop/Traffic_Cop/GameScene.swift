//
//  GameScene.swift
//  Traffic_Cop
//
//  Created by Mathew  Manton on 2015-06-05.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    //*******************************CONSTANTS / VARIABLES******************************
    var lastUpdateTime: NSTimeInterval  = 0
    var dt: NSTimeInterval              = 0
    let playableRect: CGRect                                            //GAME BOUNDS
    let TW                              = 128                           //TILEWIDTH
    let level       : Int               = 0
    var map         : Map?
    var tileMap     : JSTileMap?
    let clock       : Clock
    let pauseButt   : Button
    let pausedPopUp : Button
    let levDonePopUp: Button
    let notDonePopUp: Button
    let quitButt    : Button
    let retryButt   : Button
    let scoreButt   : Button
    let goalButt    : Button
    let soundButt   : Button
    let nextLevButt : Button
    var results     : Text?
    var crashNum    : Text?
    var peopleHit   : Text?
    var totPoints   : Text?
    var pointsLost  : Text?
    var glowRoads   : [GlowBox]
    var glowCWs     : [GlowBox]
    var glowCorners : [GlowBox]
    var pointsArray : [PointsPopUp]
    var selection   : GlowBox
    var glowSpawns  : [GlowCircle]
    var gotoPoints  : [GlowCircle]
    var roadArray   : [Road]?
    var spawnsArray : [SpawnPoint]?
    var peopleSpawns: [SpawnPoint]?
    var crossWArray : [Crosswalk]?
    var cornerArray : [Corner]?
    var vehicleArray: [CarSprite]
    var crashedCars : [CarSprite]
    var peopleArray : [PeopleSprite]
    var hitPeople   : [PeopleSprite]
    var skidArray   : [Skid]
    var feelsArray  : [Feels]
    var chooseRoads : [Road]
    var currentLevel: Int = 0
    var currentScore: Int = 0
    var goalScore   : Int = 0
    var peopleStop  : Int = 0
    var bronzeOutline : SKSpriteNode?
    var silverOutline : SKSpriteNode?
    var goldOutline   : SKSpriteNode?
    var bronzeStar    : SKSpriteNode?
    var silverStar    : SKSpriteNode?
    var goldStar      : SKSpriteNode?
    
    var path            = CGPathCreateMutable()
    var spawnAction     = SKAction()
    var spawnAction2    = SKAction()
    var timerCount      = CGFloat()
    var timePassed      : Int
    var carSelected     : Bool
    var roadSelected    : Bool
    var pausedOn        : Bool
    var deSelecting     : Bool
    var levPassed       : Bool
    var numCrashes      : Int = 0
    var totalPointsLost : Int = 0
    var numPeopleHit    : Int = 0
    //*******************************INIT / SCREEN BOUNDS CALC******************************
    override init(size: CGSize)
    {
        let maxAspectRatio:CGFloat = 9.0/16.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        glowRoads       = []
        glowCWs         = []
        glowCorners     = []
        glowSpawns      = []
        gotoPoints      = []
        vehicleArray    = []
        crashedCars     = []
        peopleArray     = []
        hitPeople       = []
        feelsArray      = []
        chooseRoads     = []
        pointsArray     = []
        skidArray       = []
        selection       = GlowBox(pos: playableRect, roundCorner: 3, OLcolor: "yellow", OLSize: 1, glowWidth: 1, ZoomIn: true, glowBulge: true, alpha: 0)

        timerCount      = CGFloat(0.0)
        timePassed      = 0
        carSelected     = false
        roadSelected    = false
        pausedOn        = false
        deSelecting     = false
        levPassed       = false
        clock           = Clock(playableR: playableRect, countFrom: 10)
        
        var pauseLabel   = Text(pos: CGPoint(x: 0, y:0),    says: "ll",              fontSize: 70,   font: "font2", color: "green",  align: "center")
        var pausedLabel  = Text(pos: CGPoint(x: 0, y:0),    says: "Paused",          fontSize: 300,  font: "font2", color: "green",  align: "center")
        var soundLabel   = Text(pos: CGPoint(x: 0, y:0),    says: "(=",              fontSize: 70,   font: "font2", color: "green",  align: "center")
        var levDoneLabel = Text(pos: CGPoint(x: 0, y:0),    says: "Level Complete!", fontSize: 130,  font: "font2", color: "green",  align: "center")
        var notDoneLabel = Text(pos: CGPoint(x: 0, y:0),    says: "Not Complete!",   fontSize: 130,  font: "font2", color: "green",  align: "center")
        var quitlbl      = Text(pos: CGPoint(x: 0, y:0),    says: "Quit",            fontSize: 150,  font: "font2", color: "green",  align: "center")
        var retryLabel   = Text(pos: CGPoint(x: 0, y:0),    says: "Retry ?",         fontSize: 150,   font: "font2", color: "green",  align: "center")
        var scoreLabel   = Text(pos: CGPoint(x: 0, y:0),    says: "SCORE",           fontSize: 50,   font: "font3", color: "green",  align: "center")
        var goalLabel    = Text(pos: CGPoint(x: 0, y:0),    says: "GOAL",            fontSize: 50,   font: "font3", color: "green",  align: "center")
        var nextLevLabel = Text(pos: CGPoint(x: 0, y:0),    says: "Next Level!",     fontSize: 150,   font: "font2", color: "green",  align: "center")
        
        pauseButt       = Button(pos: CGRect(origin: CGPoint(x: 32, y: TW*14), size: CGSize(width: 128, height: 128)),                                          roundCorner: 64, text: pauseLabel,      BGcolor: "halfblack", OLcolor: "red", OLSize: 2,    glowWidth: 3, ZoomIn: true, Bulge: false, glowBulge: false)
        pausedPopUp     = Button(pos: CGRect(origin: CGPoint(x: 32, y: TW*2+(TW/2)), size: CGSize(width: Int(size.width-64), height: TW*9)),                    roundCorner: 70, text: pausedLabel,     BGcolor: "halfblack", OLcolor: "red", OLSize: 10,   glowWidth: 8, ZoomIn: true, Bulge: true, glowBulge: true)
        levDonePopUp    = Button(pos: CGRect(origin: CGPoint(x: 32, y: TW*4+(TW/2)), size: CGSize(width: Int(size.width-64), height: TW*7)),                    roundCorner: 70, text: levDoneLabel,    BGcolor: "halfblack", OLcolor: "red", OLSize: 10,   glowWidth: 8, ZoomIn: true, Bulge: false, glowBulge: true)
        notDonePopUp    = Button(pos: CGRect(origin: CGPoint(x: 32, y: TW*4+(TW/2)), size: CGSize(width: Int(size.width-64), height: TW*7)),                    roundCorner: 70, text: notDoneLabel,    BGcolor: "halfblack", OLcolor: "red", OLSize: 10,   glowWidth: 8, ZoomIn: true, Bulge: false, glowBulge: true)
        soundButt       = Button(pos: CGRect(origin: CGPoint(x: TW*7-32, y: TW*14), size: CGSize(width: 128, height: 128)),                                     roundCorner: 64, text: soundLabel,      BGcolor: "halfblack", OLcolor: "red", OLSize: 2,    glowWidth: 3, ZoomIn: true, Bulge: false, glowBulge: false)
        scoreButt       = Button(pos: CGRect(origin: CGPoint(x: CGFloat(playableRect.width/2+64), y: CGFloat(TW*12)), size: CGSize(width: 400, height: 100)),   roundCorner: 50, text: scoreLabel,      BGcolor: "halfblack", OLcolor: "red", OLSize: 2,    glowWidth: 3, ZoomIn: true, Bulge: false, glowBulge: false)
        goalButt        = Button(pos: CGRect(origin: CGPoint(x: CGFloat(48), y: CGFloat(TW*12)), size: CGSize(width: 400, height: 100)),                        roundCorner: 50, text: goalLabel,       BGcolor: "halfblack", OLcolor: "red", OLSize: 2,    glowWidth: 3, ZoomIn: true, Bulge: false, glowBulge: false)
        nextLevButt     = Button(pos: CGRect(origin: CGPoint(x: 32, y: TW*2+(TW/2)), size: CGSize(width: Int(size.width-64), height: TW+64)),                   roundCorner: 70, text: nextLevLabel,    BGcolor: "halfblack", OLcolor: "red", OLSize: 2,    glowWidth: 3, ZoomIn: true, Bulge: true, glowBulge: true)
        quitButt        = Button(pos: CGRect(origin: CGPoint(x: 32, y: (TW/2)), size: CGSize(width: Int(size.width-64), height: TW+64)),                        roundCorner: 70, text: quitlbl,         BGcolor: "halfblack", OLcolor: "red", OLSize: 2,    glowWidth: 3, ZoomIn: true, Bulge: false, glowBulge: true)
        retryButt       = Button(pos: CGRect(origin: CGPoint(x: 32, y: TW*2+(TW/2)), size: CGSize(width: Int(size.width-64), height: TW+64)),                   roundCorner: 70, text: retryLabel,      BGcolor: "halfblack", OLcolor: "red", OLSize: 2,    glowWidth: 3, ZoomIn: true, Bulge: true, glowBulge: true)
        

        

        super.init(size: size)
        scene?.scaleMode = .AspectFit
        self.name = "The-Game-Scene"
        
        self.physicsWorld.gravity = CGVector.zeroVector
        physicsWorld.contactDelegate = self
        
        updateScore()
        
        
        //SET ACTIONS
        let spawn = SKAction.runBlock(){self.spawnVehicle();}
        let wait = SKAction.waitForDuration(2)                     //SPAWN TIME !
        let spawnSequence = SKAction.sequence([spawn, wait])
        spawnAction = SKAction.repeatActionForever(spawnSequence)
        
        let spawn2 = SKAction.runBlock(){self.spawnPerson();}
        let wait2 = SKAction.waitForDuration(3.5)                     //SPAWN PEOPLE TIME !
        let spawnSequence2 = SKAction.sequence([spawn2, wait2])
        spawnAction2 = SKAction.repeatActionForever(spawnSequence2)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    
    
    //******************************************SCENE INITIALIZATION******************************
    override func didMoveToView(view: SKView)
    {
         startGame()
        

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
// FOR DEBUG
      //  for corner in glowCorners
     //   {
     //       addChild(corner.getOL())
     //   }

   //    for cw in glowCWs
   //   {
     //       addChild(cw.getOL())
      //  }
//
//        for spawn in glowSpawns
//        {
//            addChild(spawn.getOL())
//        }
//        
//       for goto in gotoPoints
//       {
//           addChild(goto.getOL())
//       }
    
        clock.clockButt.getButtBG().zPosition = 100
        clock.clockButt.getButtOL().zPosition = 100
        clock.clockLabel.get().zPosition = 100
        
        scoreButt.getButtBG().zPosition = 100
        scoreButt.getButtOL().zPosition = 100
        scoreButt.getLabel().zPosition = 100
        
        addChild(clock.clockButt.getButtBG())
        addChild(clock.clockButt.getButtOL())
        addChild(clock.clockLabel.get())
        
        addChild(scoreButt.getButtBG())
        addChild(scoreButt.getButtOL())
        addChild(scoreButt.getLabel())
        
        addChild(goalButt.getButtBG())
        addChild(goalButt.getButtOL())
        addChild(goalButt.getLabel())
        
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
            if(clock.countDownDone){levelDone()}
            //println("\(timePassed)")
        }}
        
        //UPDATE ALL OUR STUFFS HERE
        
        if(!pausedOn)
        {
            updateVehicles()
            updatePeople()
            updatePoints()
            updateSkids()
            

        }
        
    }
    
    
    
    
    //*************************COLLISION/****************AFTER ACTION PROCESS HANDLING*********************
    override func didEvaluateActions()
    {
       // checkCollisions()
    }

    override func didSimulatePhysics()
    {

    }
    
    
    func didBeginContact(contact:SKPhysicsContact)
    {
        let other               = contact.bodyA
        let other2              = contact.bodyB
        
        let contactPoint        = contact.contactPoint
        let collisionImpulse    = contact.collisionImpulse
       
        //TWO CARS CRASHED
        if(other.categoryBitMask == PhysicsCategory.Car && other2.categoryBitMask == PhysicsCategory.Car)
        {
            let Car = other.node as! CarSprite
            let Car2 = other2.node as! CarSprite
            
            if(Car._state != .CRASHED)
            {
                Car.crashed(false)
                Car.removeAllActions()
                numCrashes++
                addPoints(-Int.randomNumberFrom(10...15), pos: contactPoint)
                crashedCars.append(Car)
            }
            
            if(Car2._state != .CRASHED)
            {
                Car2.crashed(false)
                Car2.removeAllActions()
                crashedCars.append(Car2)
            }
            
            explosion(contactPoint, force: collisionImpulse)
        }else if(other.categoryBitMask == PhysicsCategory.Car && other2.categoryBitMask == PhysicsCategory.Person)
        {
            let Car     = other.node as! CarSprite
            let Person  = other2.node as! PeopleSprite
            
            Car.crashed(true) //HIT PERSON
            Car.removeAllActions()

            if(Person._state != .DEAD)
            {
                Person._state = .DEAD
                numPeopleHit++
                addPoints(-Int.randomNumberFrom(15...20), pos: contactPoint)
                hitPeople.append(Person)
            }

            
            
        }else if(other.categoryBitMask == PhysicsCategory.Person && other2.categoryBitMask == PhysicsCategory.Car)
        {
            let Car     = other2.node as! CarSprite
            let Person  = other.node as! PeopleSprite
            
            Car.crashed(true) //HIT PERSON
            Car.removeAllActions()
            
            if(Person._state != .DEAD)
            {
                Person._state = .DEAD
                numPeopleHit++
                addPoints(-Int.randomNumberFrom(15...20), pos: contactPoint)
                hitPeople.append(Person)
            }
        }

  
    }
    
    func didEndContact(contact:SKPhysicsContact)
    {
        
//        let other = (contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyB : contact.bodyA)
//        
//        if other.categoryBitMask & player.physicsBody!.collisionBitMask != 0 {player.faceCurrentDirection()}
    }
    
    //*****************************************SPAWNING VEHICLES / PEOPLE************************
    
    func spawnVehicle()
    {
        if(!pausedOn)
        {
            if(vehicleArray.count < 20) //TODO maybe vary this number for different levels
            {
                var cantSpawnThere = false
                var foundSpot = false
                var theSpawn = Int.randomNumberFrom(0...spawnsArray!.count-1)
                
            
                for car in vehicleArray
                {
                    if(car.frame.contains(spawnsArray![theSpawn].getPos()))
                    {
                        cantSpawnThere = true
                    }
                }
                if cantSpawnThere
                {
                    //DONT SPAWN A CAR THERE THEN
                }
                else
                {
                    //Decreased the chance of a Ambulance or police spawning to 10% form 32% .. 
                    //was just a 1 and 6 cahnce for a cop or ambulance 
                    //which if you do the math is a 32% chance it will be a cop or ambulance ..
                    var rand = Int.randomNumberFrom(1...10) // == 10% leaving 90% chance of a different car .. bit more realistic..
                    var num : Int
                    if (rand == 1){num = Int.randomNumberFrom(1...2)}else{num = Int.randomNumberFrom(3...6)}
                    
                    var car = CarSprite(type: num, direction: spawnsArray![theSpawn], Parent: self)
                    vehicleArray.append(car)
                    car.drive()
                    addChild(car)
                }
                
                
            
            }}
        
    }
    
    func spawnPerson()
    {
        if(!pausedOn)
        {
            if(peopleArray.count < 20)
            {
                var person = PeopleSprite(type: Int.randomNumberFrom(1...5), direction: peopleSpawns![Int.randomNumberFrom(0...peopleSpawns!.count-1)])
                peopleArray.append(person)
                person.walk()
                addChild(person)
            }}
    }
    
    
    
    
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
 
    func updateVehicles()
    {
        for(var d = 0; d < vehicleArray.count; ++d )
        {
            for(var c = 0; c < vehicleArray.count;++c)
            {
                if(d == c )
                {
                    continue
                }
                if(vehicleArray[c].carInFront != nil)
                {
                    if(!vehicleArray[c].carInFront!.containsPoint((vehicleArray[c]._stopPoint)) && vehicleArray[c].carInFront != nil)
                    {
                        vehicleArray[c].drive()
                    }
                }
                if(vehicleArray[d].frame.contains(vehicleArray[c]._stopPoint) && vehicleArray[c]._dir == vehicleArray[d]._dir)
                {
                    vehicleArray[c].wait()
                    vehicleArray[c].carInFront = vehicleArray[d]
                }
            }
        }
        
        func atIntersection(pos: CGPoint) -> Bool
        {
            for Cw in crossWArray!
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
            
            if(vehicleArray[i].getSkid() && !vehicleArray[i].gotSkid)
            {
                skidArray.append(Skid(car: vehicleArray[i], parent: self))
                vehicleArray[i].gotSkid = true
            }
            
            if(atIntersection(vehicleArray[i].position) && vehicleArray[i]._turnCount == 0)
            {
                vehicleArray[i].stop()
            }      //RECT CHECK
            else
            {
                //vehicleArray[i].drive()
            }
            
            
            if(vehicleArray[i].isDone(playableRect))
            {
                vehicleArray[i].removeFromParent()
                vehicleArray.removeAtIndex(i)
            }
      
        }
        
    }
    
    func updateSkids()
    {
        if(skidArray.count > 0)
        {
            for(var i = 0; i < skidArray.count; i++)
            {
                if(skidArray[i].done)
                {
                    skidArray[i].removeKids();
                    skidArray.removeAtIndex(i);
                }
            }
        }
    }
    
    func updatePeople()
    {
        for(var i = 0; i < peopleArray.count; i++)
        {
            func atCorner(pos: CGPoint)
            {
                for corner in cornerArray!
                {
                  if(corner.rect.contains(peopleArray[i].frame))
                  {
                        peopleArray[i].walkOptions(corner)
                  }
                }
             
            }
            
            atCorner(peopleArray[i].position)
            
        
           peopleArray[i].update()
           
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
        if(pausedOn && clock.countDownDone) //END OF GAME / CHECK TOUCHES
        {
            if(levPassed){ if(nextLevButt.origRect.contains(location)){nextLevel(false)}}
            else{ if(retryButt.origRect.contains(location)){nextLevel(true)}}
            
            
            if(quitButt.origRect.contains(location)){quitGame()}
        }
        
        if(pausedOn && !clock.countDownDone) //NORMAL PAUSE SCREEN
        {
            if(quitButt.origRect.contains(location)){quitGame()}
            else if(pausedPopUp.origRect.contains(location)){unPauseGame()}
        }
        
        if(!pausedOn && !deSelecting)
        {
            if(pauseButt.origRect.contains(location))
            {
                deSelectCars()
                pauseGame()
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
    
    func quitGame()
    {
        let transition = SKAction.group([SKAction.runBlock()
            {
                self.quitButt.zoomOUT()
                self.pausedPopUp.FadeAway()
            }])
        
        let wait = SKAction.waitForDuration(0.3)
        
        let block = SKAction.runBlock{
            
                self.enumerateChildNodesWithName("pausePopUp")
                    {node, _ in
                        node.removeFromParent()
                    }
                let myScene = MainMenuScreen(size: self.size)
                myScene.scaleMode = self.scaleMode
                let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
                self.view?.presentScene(myScene, transition: reveal)
            }
    
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
    }
    
    func pauseGame()
    {
        pausedOn = true
        //PAUSED POPUP
        pausedPopUp.getButtBG().name = "pausePopUp"
        pausedPopUp.getButtOL().name = "pausePopUp"
        pausedPopUp.getLabel().name = "pausePopUp"
        quitButt.getButtBG().name = "pausePopUp"
        quitButt.getButtOL().name = "pausePopUp"
        quitButt.getLabel().name = "pausePopUp"
        addChild(quitButt.getButtBG())
        addChild(quitButt.getButtOL())
        addChild(quitButt.getLabel())
        addChild(pausedPopUp.getButtBG())
        addChild(pausedPopUp.getButtOL())
        addChild(pausedPopUp.getLabel())
        
        quitButt.zoomIN()
        pausedPopUp.zoomIN()
    
        for car in vehicleArray
        {
            car.paused = true
        }
    }
    
    func unPauseGame()
    {
        let transition = SKAction.group([SKAction.runBlock()
            {
            self.quitButt.zoomOUT()
            self.pausedPopUp.zoomOUT()
            }])
        
        let wait = SKAction.waitForDuration(0.2)
        
        let block = SKAction.runBlock{
            self.enumerateChildNodesWithName("pausePopUp")
                {node, _ in
                    node.removeFromParent()
            }
            self.pausedOn = false
        }

        
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
        
        for car in vehicleArray
        {
            car.paused = false
        }
    }
    
    func illuminateRoads(car : CarSprite)
    {
            var carOn : Road = map!.getCurRoad(car.position)
        var canGoLeft     = false
        var canGoRight    = false
        var canGoStraight = false
        
            let transition = SKAction.group([SKAction.runBlock()
                {
                    var roadSide = carOn.Side
                    
                    for road in self.map!.roadArray
                    {
                        if road.Side == roadSide {}                                 //SAME SIDE ROADS..ADD TO CHOICES
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
                    //SETTING THE CARS CHOICE OF WHAT ROADS THEY CAN TURN TO AND GETTING THERE CHOICE
                    if (!car.choiceMade)
                    {
                        car.rollChoice(self.currentLevel)
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
        var controlPoint1 : CGPoint
        
        CGPathMoveToPoint(path, nil , car.position.x, car.position.y)

        if car._dir == .NORTH
        {
            switch(road.Side)
            {
            case "top":
                
                car.goStraight()
                
                if(car._wantDir == .NORTH && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
            case "left":
                
                controlPoint1 = CGPoint(x: car.position.x, y: road.gotoPoint.y)
                
                CGPathAddQuadCurveToPoint(path, nil, controlPoint1.x, controlPoint1.y, road.gotoPoint.x, road.gotoPoint.y)
                
                car.turnLeft(path)
                
                if(car._wantDir == .WEST && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
                
            case "right":
                
                controlPoint1 = CGPoint(x: car.position.x, y: road.gotoPoint.y)
                
                CGPathAddQuadCurveToPoint(path, nil, controlPoint1.x, controlPoint1.y, road.gotoPoint.x, road.gotoPoint.y)
                
                car.turnRight(path)
                
                if(car._wantDir == .EAST && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
            default:
                
                car.drive()
            }
        }
        else if car._dir == .SOUTH
        {
            switch(road.Side)
            {
            case "bottom":
                
                car.goStraight()
                
                if(car._wantDir == .SOUTH && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
                
            case "left":
                
                controlPoint1 = CGPoint(x: car.position.x, y: road.gotoPoint.y)
                
                CGPathAddQuadCurveToPoint(path, nil, controlPoint1.x, controlPoint1.y, road.gotoPoint.x, road.gotoPoint.y)
                
                car.turnRight(path)
                
                if(car._wantDir == .WEST && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
                
            case "right":
                
                controlPoint1 = CGPoint(x: car.position.x, y: road.gotoPoint.y)
                
                CGPathAddQuadCurveToPoint(path, nil, controlPoint1.x, controlPoint1.y, road.gotoPoint.x, road.gotoPoint.y)
                
                car.turnLeft(path)
                
                if(car._wantDir == .EAST && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
                
            default:
                
                car.drive()
            }
            
        }
        else if car._dir == .EAST
        {
            switch(road.Side)
            {
            case "right":
                
                car.goStraight()
                
                if(car._wantDir == .EAST && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
                
            case "top":
                
                controlPoint1 = CGPoint(x: road.gotoPoint.x, y: car.position.y)
                
                CGPathAddQuadCurveToPoint(path, nil, controlPoint1.x, controlPoint1.y, road.gotoPoint.x, road.gotoPoint.y)
                
                car.turnLeft(path)
                
                if(car._wantDir == .NORTH && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
                
            case "bottom":
                
                controlPoint1 = CGPoint(x: road.gotoPoint.x, y: car.position.y)
                
                CGPathAddQuadCurveToPoint(path, nil, controlPoint1.x, controlPoint1.y, road.gotoPoint.x, road.gotoPoint.y)
                
                car.turnRight(path)
                
                if(car._wantDir == .SOUTH && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
                
            default:
                
                car.drive()
            }
        }
        else
        {
            switch(road.Side)
            {
            case "left":
                
                car.goStraight()
                
                if(car._wantDir == .WEST && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
                
            case "top":
                
                controlPoint1 = CGPoint(x: road.gotoPoint.x, y: car.position.x)
                
                CGPathAddQuadCurveToPoint(path, nil, controlPoint1.x, controlPoint1.y, road.gotoPoint.x, road.gotoPoint.y)
                
                car.turnRight(path)
                
                if(car._wantDir == .NORTH && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
                
            case "bottom":
                
                controlPoint1 = CGPoint(x: road.gotoPoint.x, y: car.position.x)
                
                CGPathAddQuadCurveToPoint(path, nil, controlPoint1.x, controlPoint1.y, road.gotoPoint.x, road.gotoPoint.y)
                
                car.turnLeft(path)
                
                if(car._wantDir == .SOUTH && car._state != .CRASHED)
                {
                    addPoints(Int.randomNumberFrom(10...15), pos: car.position)
                }
            default:
                
                car.goStraight()
            }
        }
//        let thePath = SKShapeNode()
//        thePath.path = path
//        thePath.strokeColor = SKColor.cyanColor()
//        thePath.name = "path"
//        addChild(thePath)
        
        path = CGPathCreateMutable()
    }
    
    func startGame()
    {
        map = Map(lvl: currentLevel)
        var goalStr = "Goal: "
        
        switch(currentLevel)
        {
        case 1: tileMap = JSTileMap(named: "level1v2.tmx"); goalScore = 100; goalStr += String(goalScore); goalButt.getLabel().text = goalStr;
        case 2: tileMap = JSTileMap(named: "level2v2.tmx"); goalScore = 500; goalStr += String(goalScore); goalButt.getLabel().text = goalStr;
        case 3: tileMap = JSTileMap(named: "level3v2.tmx"); goalScore = 800; goalStr += String(goalScore); goalButt.getLabel().text = goalStr;
        case 4: tileMap = JSTileMap(named: "level4v2.tmx"); goalScore = 1000; goalStr += String(goalScore); goalButt.getLabel().text = goalStr;
        default: tileMap = JSTileMap(named: "level1v2.tmx"); println("error in the level assigning !"); goalScore = 1000;
        }
        
        if tileMap != nil
        {
            self.addChild(tileMap!)
        }
        
        roadArray       = map!.getRoads()
        spawnsArray     = map!.getSpawns()
        crossWArray     = map!.getCrossWalks()
        peopleSpawns    = map!.getPeopleSpawns()
        cornerArray     = map!.getCorners()
        
        
        //SET GLOW ROADS
        for road in roadArray!
        {
            glowRoads.append(GlowBox(pos: road.rect, roundCorner: 64, OLcolor: "green", OLSize: 15, glowWidth: 2, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        for cw in crossWArray!
        {
            glowCWs.append(GlowBox(pos: cw.rect, roundCorner: 40, OLcolor: "yellow", OLSize: 15, glowWidth: 2, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        for corner in cornerArray!
        {
            glowCorners.append(GlowBox(pos: corner.rect, roundCorner: 40, OLcolor: "blue", OLSize: 15, glowWidth: 2, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        for spawn in peopleSpawns!
        {
            glowSpawns.append(GlowCircle(pos: spawn.pos, radius: 20, OLcolor: "green", OLSize: 4, glowWidth: 30, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        
        for road in roadArray!
        {
            gotoPoints.append(GlowCircle(pos: road.gotoPoint, radius: 20, OLcolor: "blue", OLSize: 4, glowWidth: 30, ZoomIn: true, glowBulge: true, alpha: CGFloat(0.5)))
        }
        
    }
    
    class func level(levelNum: Int) -> GameScene?
    {
        var scene = GameScene(size: CGSize(width: 1024, height: 1920))
        scene.currentLevel = levelNum
        scene.scaleMode = .AspectFit
        return scene
    }

    func updateScore()
    {
        if(currentScore < 0)
        {
            currentScore = 0
            //LOSE GAME HERE
        }
        
        var scoreStr = "Score: "
        scoreStr += String(currentScore)
        scoreButt.getLabel().text.removeAll(keepCapacity: false)
        scoreButt.getLabel().text = scoreStr
    }
    
    func levelDone()
    {
        deSelectCars()
        
        for cars in vehicleArray{cars.paused = true}
        
        if(currentScore >= goalScore)
        {
            levPassed = true
            displayResults()
            fireWorksGo()
            addChild(levDonePopUp.getButtBG())
            addChild(levDonePopUp.getButtOL())
            addChild(levDonePopUp.getLabel())
            
            addChild(nextLevButt.getButtBG())
            addChild(nextLevButt.getButtOL())
            addChild(nextLevButt.getLabel())
            
            addChild(quitButt.getButtBG())
            addChild(quitButt.getButtOL())
            addChild(quitButt.getLabel())
            nextLevButt.zoomIN()
            levDonePopUp.zoomIN()
            quitButt.zoomIN()
            
        }
        else
        {
            levPassed = true
            displayResults()
            addChild(notDonePopUp.getButtBG())
            addChild(notDonePopUp.getButtOL())
            addChild(notDonePopUp.getLabel())
            
            addChild(retryButt.getButtBG())
            addChild(retryButt.getButtOL())
            addChild(retryButt.getLabel())
            
            addChild(quitButt.getButtBG())
            addChild(quitButt.getButtOL())
            addChild(quitButt.getLabel())
            notDonePopUp.zoomIN()
            retryButt.zoomIN()
            quitButt.zoomIN()
        }
        quitButt.zoomIN()
        pausedOn = true;
    }
    
    func nextLevel(retry: Bool)
    {
        var lvl = self.currentLevel + 1
        if(lvl > 4){lvl = 4} //MAX LEVEL FOR NOW
        if(retry){lvl = currentLevel}
        var fadeOut = SKAction.fadeAlphaTo(CGFloat(0.0), duration: 1)
        let transition = SKAction.group([SKAction.runBlock()
            {
                if(retry)
                {
                self.retryButt.zoomOUT()
                self.notDonePopUp.FadeAway()
                self.quitButt.FadeAway()
                self.results!.get().runAction(fadeOut)
                self.crashNum!.get().runAction(fadeOut)
                self.peopleHit!.get().runAction(fadeOut)
                self.totPoints!.get().runAction(fadeOut)
                self.pointsLost!.get().runAction(fadeOut)
                }
                else{
                self.nextLevButt.zoomOUT()
                self.levDonePopUp.FadeAway()
                self.quitButt.FadeAway()
                self.results!.get().runAction(fadeOut)
                self.crashNum!.get().runAction(fadeOut)
                self.peopleHit!.get().runAction(fadeOut)
                self.totPoints!.get().runAction(fadeOut)
                self.pointsLost!.get().runAction(fadeOut)
                }
            }])
        
        let wait = SKAction.waitForDuration(0.2)
        
        let block = SKAction.runBlock{
            
            let myScene = GameScene.level(lvl)
            //myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
            self.view?.presentScene(myScene, transition: reveal)
        }
        
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
    }
    
    func addPoints(points: Int, pos: CGPoint)
    {
        var pointAdd = PointsPopUp(Pos: pos, Points: points, goto: CGPoint(x: CGFloat(playableRect.width/2+350), y: CGFloat(TW*12)), Parent: self)
        pointsArray.append(pointAdd)
        addChild(pointAdd.sparkEmitter)
        addChild(pointAdd.text.get())
    }
    
    func updatePoints()
    {
        if(pointsArray.count > 0)
        {
            for(var i = 0; i < pointsArray.count; i++)
            {
                if(pointsArray[i].getAddPoints())
                {
                      if(pointsArray[i].points < 0)
                      {
                        totalPointsLost += pointsArray[i].points
                      }
                      currentScore += pointsArray[i].points
                      updateScore()
                }
                if(pointsArray[i].done)
                {
                    pointsArray[i].sparkEmitter.removeFromParent()
                    pointsArray[i].text.get().removeFromParent()
                    pointsArray.removeAtIndex(i)
                }
            }
        }
    }
    
    func fireWorksGo()
    {
    var f1          : SKEmitterNode = SKEmitterNode(fileNamed: "FireWork1.sks")
    var f2          : SKEmitterNode = SKEmitterNode(fileNamed: "FireWork2.sks")
    var f3          : SKEmitterNode = SKEmitterNode(fileNamed: "FireWork3.sks")
        
    f1.particleTexture!.filteringMode = .Nearest
    f1.targetNode = self
    f1.particleColorSequence = nil;
    f1.particleColorBlendFactor = 1.0;
    f1.particleZPosition = CGFloat(1100)
        
    f2.particleColorSequence = nil;
    f2.particleColorBlendFactor = 1.0;        
    f2.particleTexture!.filteringMode = .Nearest
    f2.targetNode = self
    f2.particleZPosition = CGFloat(1101)
        
    f3.particleTexture!.filteringMode = .Nearest
    f3.targetNode = self
    f3.particleColorSequence = nil;
    f3.particleColorBlendFactor = 1.0;
    f3.particleZPosition = CGFloat(1200)




    self.addChild(f1)
    self.addChild(f2)
    self.addChild(f3)
    
    var wait = SKAction.waitForDuration(4, withRange: 2)
    
    var newPosf1 = SKAction.runBlock()
    {
        f1.particleColor = SKColorWithRGB(
            Int.randomNumberFrom(0...255),
            Int.randomNumberFrom(0...255),
            Int.randomNumberFrom(0...255))
        f1.particleScaleRange = CGFloat.random(min: 0.3, max: 1.0)
        f1.position.x = CGFloat.random(min: 0, max: self.playableRect.maxX)
        f1.position.y = CGFloat.random(min: 0, max: self.playableRect.maxY)
        f1.resetSimulation()
    }
    
    var newPosf2 = SKAction.runBlock()
    {
        f2.particleColor = SKColorWithRGB(
            Int.randomNumberFrom(0...255),
            Int.randomNumberFrom(0...255),
            Int.randomNumberFrom(0...255))
        f2.particleScaleRange = CGFloat.random(min: 0.3, max: 1.0)
        f2.position.x = CGFloat.random(min: 0, max: self.playableRect.maxX)
        f2.position.y = CGFloat.random(min: 0, max: self.playableRect.maxY)
        f2.resetSimulation()
    }
    
    var newPosf3 = SKAction.runBlock()
    {
        f3.particleColor = SKColorWithRGB(
            Int.randomNumberFrom(0...255),
            Int.randomNumberFrom(0...255),
            Int.randomNumberFrom(0...255))
        f3.particleScaleRange = CGFloat.random(min: 0.3, max: 1.0)
        //f3.particleSize = CGFloat.random(min: 0.3, max: 1.0)
        f3.position.x = CGFloat.random(min: 0, max: self.playableRect.maxX)
        f3.position.y = CGFloat.random(min: 0, max: self.playableRect.maxY)
        f3.resetSimulation()
    }
    
    f1.runAction(SKAction.repeatActionForever(SKAction.sequence([newPosf1,wait])))
    f2.runAction(SKAction.repeatActionForever(SKAction.sequence([newPosf2,wait])))
    f3.runAction(SKAction.repeatActionForever(SKAction.sequence([newPosf3,wait])))
    
   }
    
    func explosion(position: CGPoint, force: CGFloat)
    {
        //println("\(force)")
        var explosionEmit = SKEmitterNode(fileNamed: "Explosion.sks")
        explosionEmit.position = position
        explosionEmit.zPosition = 1000
        explosionEmit.particleBirthRate = force; explosionEmit.numParticlesToEmit = Int(force/10)
        var spawnExplosion = SKAction.runBlock(){self.addChild(explosionEmit)}
        var wait = SKAction.waitForDuration(3)
        var block = SKAction.runBlock(){explosionEmit.removeFromParent()}
        var sequence = SKAction.sequence([spawnExplosion,wait,block])
        self.runAction(sequence)
    }
    
    func displayResults()
    {

        
        bronzeOutline = SKSpriteNode(imageNamed: "StarOutline")
        silverOutline = SKSpriteNode(imageNamed: "StarOutline")
        goldOutline = SKSpriteNode(imageNamed : "StarOutline")
        
        bronzeOutline!.position = CGPoint(x: self.size.width/2-300, y: self.size.height/2+285)
        silverOutline!.position = CGPoint(x: self.size.width/2+300, y: self.size.height/2+285)
        goldOutline!.position = CGPoint(x: self.size.width/2, y: self.size.height/2+350)
        
        let bronzeMove = SKAction.moveToX(bronzeOutline!.position.x, duration: 1.2)
        let bronzeRotate = SKAction.repeatAction(SKAction.rotateByAngle(pie, duration: 0.6), count: 2)
        let silverMove = SKAction.moveToX(silverOutline!.position.x, duration: 2.4)
        let silverRotate = SKAction.repeatAction(SKAction.rotateByAngle(pie, duration: 0.6), count: 4)
        let goldMove = SKAction.moveToX(goldOutline!.position.x, duration: 1.8)
        let goldRotate = SKAction.repeatAction(SKAction.rotateByAngle(pie, duration: 0.9), count: 2)
        
        
        bronzeStar = SKSpriteNode(imageNamed: "BronzeStar")
        silverStar = SKSpriteNode(imageNamed: "SilverStar")
        goldStar = SKSpriteNode(imageNamed: "GoldStar")
        
        
        bronzeOutline!.position = CGPoint(x: self.size.width/2-300, y: self.size.height/2+285)
        silverOutline!.position = CGPoint(x: self.size.width/2+300, y: self.size.height/2+285)
        goldOutline!.position = CGPoint(x: self.size.width/2, y: self.size.height/2+350)
        if(levPassed)
        {
            bronzeStar!.position = CGPoint(x:-200, y:self.size.height/2+285)
            bronzeStar!.runAction(bronzeRotate)
            bronzeStar!.runAction(bronzeMove)
            silverStar!.position = CGPoint(x:-200, y:self.size.height/2+285)
            silverStar!.runAction(silverRotate)
            silverStar!.runAction(silverMove)
            goldStar!.position = CGPoint(x: -200, y: self.size.height/2+350)
            goldStar!.runAction(goldRotate)
            goldStar!.runAction(goldMove)
  
            

        }
        
        results     = Text(pos: CGPoint(x: self.size.width/2-450, y: self.size.height/2 - 100), says: "Results:",                                       fontSize: 50, font: "font3", color: "white", align: "left")
        crashNum    = Text(pos: CGPoint(x: self.size.width/2-450, y: self.size.height/2 - 160), says: "Crashes:  \(numCrashes)",                        fontSize: 50, font: "font3", color: "white", align: "left")
        peopleHit   = Text(pos: CGPoint(x: self.size.width/2-450, y: self.size.height/2 - 220), says: "Hit People:  \(numPeopleHit)",                   fontSize: 50, font: "font3", color: "white", align: "left")
        totPoints   = Text(pos: CGPoint(x: self.size.width/2-450, y: self.size.height/2 - 280), says: "Total Points:  \(currentScore)",                 fontSize: 50, font: "font3", color: "white", align: "left")
        pointsLost  = Text(pos: CGPoint(x: self.size.width/2-450, y: self.size.height/2 - 340), says: "Total Points Lost:  \(abs(totalPointsLost))",    fontSize: 50, font: "font3", color: "white", align: "left")
        
        bronzeOutline!.zPosition = 100
        silverOutline!.zPosition = 100
        goldOutline!.zPosition = 100
        bronzeStar!.zPosition = 100
        silverStar!.zPosition = 100
        goldStar!.zPosition = 100
        
        results!.get().zPosition     = 100
        crashNum!.get().zPosition    = 100
        peopleHit!.get().zPosition   = 100
        totPoints!.get().zPosition   = 100
        pointsLost!.get().zPosition  = 100
        
        results!.get().alpha     = CGFloat(0.0)
        crashNum!.get().alpha    = CGFloat(0.0)
        peopleHit!.get().alpha   = CGFloat(0.0)
        totPoints!.get().alpha   = CGFloat(0.0)
        pointsLost!.get().alpha  = CGFloat(0.0)
        
        
        addChild(bronzeOutline!)
        addChild(silverOutline!)
        addChild(goldOutline!)
        addChild(bronzeStar!)
        addChild(silverStar!)
        addChild(goldStar!)
        addChild(results!.get())
        addChild(crashNum!.get())
        addChild(peopleHit!.get())
        addChild(totPoints!.get())
        addChild(pointsLost!.get())
        
        var fadeIn = SKAction.fadeAlphaTo(CGFloat(1.0), duration: 2.5)
        results!.get().runAction(fadeIn)
        crashNum!.get().runAction(fadeIn)
        peopleHit!.get().runAction(fadeIn)
        totPoints!.get().runAction(fadeIn)
        pointsLost!.get().runAction(fadeIn)
       
    }

}


class Skid
{
    var theParent       : SKNode
    var Car             : CarSprite
    var FLeftSkidPath   = SKShapeNode()
    var FRightSkidPath  = SKShapeNode()
    var BRightSkidPath  = SKShapeNode()
    var BLeftSkidPath   = SKShapeNode()
    
    var FLeftTirePath   = CGPathCreateMutable();
    var FRightTirePath  = CGPathCreateMutable();
    var BRightTirePath  = CGPathCreateMutable();
    var BLeftTirePath   = CGPathCreateMutable();
    
    var done : Bool = false
    
    init(car: CarSprite, parent: SKNode)
    {
        Car = car
        theParent = parent

        //ACTION FADE AWAY AFTER TIME AND REMOVE ITS SELF
        var wait = SKAction.waitForDuration(5)
        var fade = SKAction.fadeAlphaTo(0, duration: 4)
        var wait2 = SKAction.waitForDuration(9) //total of wait and fade
        var sequence = SKAction.sequence([wait, fade])
        var block1 = SKAction.runBlock(){self.FLeftSkidPath.runAction(sequence); self.FRightSkidPath.runAction(sequence); self.BRightSkidPath.runAction(sequence);self.BLeftSkidPath.runAction(sequence);}
        var block2 = SKAction.runBlock(){self.done = true;}
        var fullSequence = SKAction.sequence([block1 ,wait2, block2])
        theParent.runAction(fullSequence)
            
        FLeftSkidPath.strokeColor = SKColor.blackColor()
        FRightSkidPath.strokeColor = SKColor.blackColor()
        BRightSkidPath.strokeColor = SKColor.blackColor()
        BLeftSkidPath.strokeColor = SKColor.blackColor()

        FLeftSkidPath.lineWidth = CGFloat(12)
        FRightSkidPath.lineWidth = CGFloat(12)
        BRightSkidPath.lineWidth = CGFloat(12)
        BLeftSkidPath.lineWidth = CGFloat(12)

        FLeftSkidPath.zPosition = -1
        FRightSkidPath.zPosition = -1
        BRightSkidPath.zPosition = -1
        BLeftSkidPath.zPosition = -1
            
        let FL  = car.FLeftTire.convertPoint(car.FLeftTire.position, toNode: theParent)
        let FR  = car.FRightTire.convertPoint(car.FRightTire.position, toNode: theParent)
        let BR  = car.BRightTire.convertPoint(car.BRightTire.position, toNode: theParent)
        let BL  = car.BLeftTire.convertPoint(car.BLeftTire.position, toNode: theParent)
            
        CGPathMoveToPoint(FLeftTirePath, nil, FL.x, FL.y);
        CGPathMoveToPoint(FRightTirePath, nil, FR.x, FR.y);
        CGPathMoveToPoint(BRightTirePath, nil, BR.x, BR.y);
        CGPathMoveToPoint(BLeftTirePath, nil, BL.x, BL.y);

        theParent.addChild(FLeftSkidPath)
        theParent.addChild(FRightSkidPath)
        theParent.addChild(BRightSkidPath)
        theParent.addChild(BLeftSkidPath)
        
        var updateWait = SKAction.waitForDuration(0.2)
        
        var updateLines = SKAction.runBlock(){
            
            var FL  = self.Car.FLeftTire.convertPoint(self.Car.FLeftTire.position, toNode: self.theParent)
            var FR  = self.Car.FRightTire.convertPoint(self.Car.FRightTire.position, toNode: self.theParent)
            var BR  = self.Car.BRightTire.convertPoint(self.Car.BRightTire.position, toNode: self.theParent)
            var BL  = self.Car.BLeftTire.convertPoint(self.Car.BLeftTire.position, toNode: self.theParent)
            
            CGPathAddLineToPoint(self.FLeftTirePath, nil, FL.x, FL.y);
            CGPathAddLineToPoint(self.FRightTirePath, nil, FR.x, FR.y);
            CGPathAddLineToPoint(self.BRightTirePath, nil, BR.x, BR.y);
            CGPathAddLineToPoint(self.BLeftTirePath, nil, BL.x, BL.y);
            
            self.FLeftSkidPath.path = self.FLeftTirePath
            self.FRightSkidPath.path = self.FRightTirePath
            self.BRightSkidPath.path = self.BRightTirePath
           self.BLeftSkidPath.path = self.BLeftTirePath
        
        }
        var updateSequence = SKAction.sequence([updateLines, updateWait])
        self.theParent.runAction(SKAction.repeatAction(updateSequence, count: 25))
    }
    
    func removeKids()
    {
        FLeftSkidPath.removeFromParent()
        FRightSkidPath.removeFromParent()
        BRightSkidPath.removeFromParent()
        BLeftSkidPath.removeFromParent()
    }
}


