//
//  people.swift
//  Traffic_Cop
//
//  Created by Nicole Garrow on 2015-06-17.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//
//
//  people.swift
//  trial
//
//  Created by Nicole Garrow on 2015-06-09.
//  Copyright (c) 2015 Nicole Garrow. All rights reserved.
//
//
//  CarSprite.swift
//  Traffic_Cop
//
//  Created by Mathew  Manton on 2015-06-04.
//  Copyright (c) 2015 Mathew  Manton. All rights reserved.
//
//YO HO HO
//import Foundation
import SpriteKit



class PeopleSprite : SKSpriteNode
{
    enum Direction
    {
        case WEST, NORTH, EAST, SOUTH
        
    }
    enum State
    {
        case WALKING, STOPPED, TURNING
    }
    
    /*moods 0-4*/
    enum mood
    {
        case HAPPY // happy
        case CONTENT // content
        case IRRITATED //irritation
        case MAD //extremely angry
        case DANGER // leaves sidewalk, gets in crash, etc
    }
    
    


    
    let _MAXSPEED : CGFloat
    var _dir : Direction = Direction.WEST
    var _turnCount : Int = 0
    var _person : SKTexture
    // var _emotion : SKTexture
    var _spawn  : CGPoint
    var _accel: CGFloat = 1
    var _currSpeed: CGFloat = 0
    var _deAccel: CGFloat = 0
    var _isDone : Bool = false
    var _type : Int
    var _textures : [SKTexture] = []
    var _size : CGSize
    var _state : State = State.STOPPED
    var _isSelected : Bool = false
    var _glowCircle : GlowCircle
    var _currPos : CGPoint
    var _currentMood = mood.HAPPY
    
    
    var startTime = NSTimeInterval()
    
    var timer:NSTimer = NSTimer()
    // @IBAction func stop(sender: AnyObject) {
    //  timer.invalidate()
    // }

    
    
    init(type : Int , direction : SpawnPoint)
    {
        
        
        
//        
//        var currentTime = NSDate.timeIntervalSinceReferenceDate()
//        
//        //Find the difference between current time and start time.
//        var elapsedTime: NSTimeInterval = currentTime - startTime
//        
        //calculate the seconds in elapsed time.
//        let seconds = UInt8(elapsedTime)
//        elapsedTime -= NSTimeInterval(seconds)
        
        
        
        
        
        var tempDirection = direction.dir
        
        self._size = CGSize(width: 32, height: 32)
        self._spawn = direction.pos
        self._glowCircle = GlowCircle(pos: self._spawn, radius: 20, OLcolor: "yellow", OLSize: 10, glowWidth: 40, ZoomIn: true, glowBulge: true, alpha: 0.5)
        self._currPos = _spawn
        self._type = type
        
        
        
        
        switch(self._type)
        {
        case 1:
            
            self._person = SKTexture(imageNamed: "lady")
            self._MAXSPEED = 5
            //self._spawn = spawn
            
            // self._size = CGSize(width: 32, height: 32)
            self._currentMood = mood.HAPPY
            
            
            // mood timer
            
//            if (seconds == 0)
//            {
//                self._currentMood = mood.HAPPY
//                //    self._emotion = SKTexture(imageNamed: "happy")
//            }
//            else if (seconds == 5)
//            {
//                self._currentMood = mood.CONTENT
//                //self._emotion = SKTexture(imageNamed: "content")
//            }
//            else if (seconds == 10)
//            {
//                self._currentMood = mood.IRRITATED
//                //self._emotion = SKTexture(imageNamed: "irritated")
//            }
//            else if (seconds == 15)
//            {
//                self._currentMood = mood.MAD
//                //self._emotion = SKTexture(imageNamed: "mad")
//            }
//            else if (seconds == 17)
//            {
//                self._currentMood = mood.DANGER
//                //self._emotion = SKTexture(imageNamed: "exclamation")
//            }
//            else
//            {
//                self._currentMood = mood.DANGER
//                //self._emotion = SKTexture(imageNamed: "exclamation")
//            }
//            
//            
//            
            //stop when they are told
            
            
            
            
        case 2:
            self._person = SKTexture(imageNamed:"littleGirl")
            self._MAXSPEED = 5
            // self._spawn = spawn
            
            // self._size = CGSize(width: 32, height: 32)
            self._currentMood = mood.HAPPY
            
            
            
            // mood timer
//            
//            if (seconds == 0)
//            {
//                self._currentMood = mood.HAPPY
//                //self._emotion = SKTexture(imageNamed: "happy")
//            }
//            else
//            {
//                self._currentMood = mood.DANGER
//                //self._emotion = SKTexture(imageNamed: "exclamation")
//            }
//            
//            
//            //do not stop at lights
//            
            
        case 3:
            self._person = SKTexture(imageNamed: "OldMan")
            self._MAXSPEED = 5
            //  self._spawn = spawn
            // self._size = CGSize(width: 32, height: 32)
            self._currentMood = mood.HAPPY
            
            
            
            // mood timer
            
            
//            if (seconds ==  0)
//            {
//                self._currentMood = mood.HAPPY
//                // self._emotion = SKTexture(imageNamed: "happy")
//            }
//            else if (seconds ==  5)
//            {
//                self._currentMood = mood.IRRITATED
//                //self._emotion = SKTexture(imageNamed: "irritated")
//            }
//                
//            else if (seconds == 10)
//            {
//                self._currentMood = mood.MAD
//                //self._emotion = SKTexture(imageNamed: "mad")
//            }
//            else if (seconds ==  12)
//            {
//                self._currentMood = mood.DANGER
//                //self._emotion = SKTexture(imageNamed: "exclamation")
//            }
//            else
//            {
//                self._currentMood = mood.DANGER
//            }
//            
//            
//            
//            
            //get angry faster
            //cause traffic holdups when crossing
            
            
            
            
        case 4:
            self._person = SKTexture(imageNamed: "LadyBaby")
            
            self._MAXSPEED = 4
            // self._spawn = spawn
            
            self._size = CGSize(width: 64, height: 50)
            self._currentMood = mood.HAPPY
            
            
            
            // mood timer
            
//            if (seconds ==  0)
//            {
//                self._currentMood = mood.HAPPY
//                // self._emotion = SKTexture(imageNamed: "happy")
//            }
//            else if (seconds ==  10)
//            {
//                self._currentMood = mood.CONTENT
//                //self._emotion = SKTexture(imageNamed: "content")
//            }
//            else if (seconds == 15)
//            {
//                self._currentMood = mood.IRRITATED
//                //self._emotion = SKTexture(imageNamed: "irritated")
//            }
//            else if (seconds == 20)
//            {
//                self._currentMood = mood.MAD
//                //self._emotion = SKTexture(imageNamed: "mad")
//            }
//            else
//            {
//                self._currentMood = mood.MAD
//                //self._emotion = SKTexture(imageNamed: "mad")
//            }
//            
//            
//            
            // take up more room on corner
            //more patient then others
            
            
            
            
        default :
            self._person = SKTexture(imageNamed: "")
            //self._emotion = SKTexture(imageNamed: "")
            self._MAXSPEED = 0
        }
        
        
        super.init(texture: _person, color: nil, size: self._size)
        
        
        self.setScale(CGFloat(2.5))
        //rotate the sprite to the correct direction
        
        //position the car in the middle of the road
        switch(tempDirection)
        {
        case 0:
            self._dir = Direction.NORTH
            self._spawn.x = direction.pos.x - self._size.width/2
            self._spawn.y = direction.pos.y - self._size.height
        case 1:
            self._dir = Direction.WEST
            self._spawn.x = direction.pos.x + self._size.width
            self._spawn.y = direction.pos.y - self._size.height/2
        case 2:
            self._dir = Direction.EAST
            self._spawn.x = direction.pos.x - self._size.width
            self._spawn.y = direction.pos.y - self._size.height/2
        case 3:
            self._dir = Direction.SOUTH
            self._spawn.x = direction.pos.x - self._size.width/2
            self._spawn.y = direction.pos.y + self._size.height
        default:
            self._dir = Direction.WEST
            self._spawn.x = direction.pos.x + self._size.height
            self._spawn.y = direction.pos.y - self._size.width/2
        }
        
        /*   if (!timer.valid) {
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        }*/
        
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    
    //***************************Functions*************************
    func update()
    {
        println("isSelected: \(self._isSelected)")
        switch(self._dir)
        {
        case .NORTH:
            self.zRotation = CGFloat(M_PI_2 * 3)
        case .WEST:
            self.zRotation = 0
        case .EAST:
            self.zRotation = CGFloat(M_PI_2 * 2)
        case .SOUTH:
            self.zRotation = CGFloat(M_PI_2)
        default:
            self.zRotation = 0
            
        }
        
        self.position = self._currPos
     
        
     
        
        if ((self._type != 2 && (self._dir == Direction.EAST) && (self.position.x + self.size.width/2 >= 129*2)) && ((self.position.y >= 128*4 && self.position.y <= 128*6+64 )||(self.position.y >= 128*7+64 && self.position.y <= 128*9+64)))
        {
        self._currSpeed == 0
        stop()
        }
       else if ((self._type != 2 && (self._dir == Direction.WEST) && (self.position.x - self.size.width/2 <= 129*6)) && ((self.position.y >= 128*4 && self.position.y <= 128*6+64 )||(self.position.y >= 128*7+64 && self.position.y <= 128*9+64)))
        {
            self._currSpeed == 0
            stop()
        }
        else if ((self._type != 2  && (self._dir == Direction.NORTH) && (self.position.y + (3*(self.size.height/4)) >= 129*5)) && ((self.position.x >= 0 && self.position.x <= 128*2) || (self.position.x >= 128*6 && self.position.x <= 128 * 7.5)))
        {
            self._currSpeed == 0
            stop()
        }
        else if ((self._type != 2  && (self._dir == Direction.SOUTH) && (self.position.y - self.size.height/2  <= 129 * 9)) && ((self.position.x >= 0 && self.position.x <= 128*2) || (self.position.x >= 128*6 && self.position.x <= 128 * 7.5)))
        {
            self._currSpeed == 0
            stop()
        }
        
        
        
        
        if self._state == State.WALKING //inactive
        {
            timer.invalidate()
            goStraight()
        }
        else if self._state == State.STOPPED //active
        {
            self._currSpeed = 0
        }
        else if self._state == State.TURNING //inactive
        {
            timer.invalidate()
            
        }
        
        
        
    }
    
    
    func turnRight(path : CGPath) //timer should be deactivated
    {
        self._turnCount++
        self._state = State.TURNING
        
        let action = SKAction.followPath(path, asOffset: false , orientToPath: false, duration: 1)
        let action2 = SKAction.rotateByAngle(CGFloat(-M_PI_2), duration: 0.85)
        
        
        
        self.runAction(SKAction.group([
            action,
            action2
            ]))
        
        
        switch(self._dir)
        {
        case .NORTH:
            self._dir = .EAST
        case .EAST:
            self._dir = .SOUTH
        case .WEST:
            self._dir = .NORTH
        case .SOUTH:
            self._dir = .WEST
        default:
            self._dir = .WEST
            
        }
        
    }
    
    
    
    func turnLeft() //tiner should be inactive
    {
        
    }
    
    func walk() //timer should be inactive
        
    {
        self._state = State.WALKING
    
    }
    
    func goStraight()//timer should be inactive
    {
        self._state = State.WALKING
        
        if self._currSpeed != self._MAXSPEED
        {
            self._currSpeed += self._accel
        }
        
        switch(self._dir)
        {
        case .NORTH:
            self._currPos.y += self._currSpeed
        case .SOUTH:
            self._currPos.y -= self._currSpeed
        case .WEST:
            self._currPos.x -= self._currSpeed
        case .EAST:
            self._currPos.x += self._currSpeed
        default:
            println("No direction")
        }
    }
    
    func stop() //is when timer should activate
    {
        self._currSpeed = 0
        self._state = State.STOPPED
    }
    
    
    func isDone(rect : CGRect) -> Bool //timer should be inactive
    {
        if(self._dir == .NORTH && self.position.y - self._size.height * 2 > rect.maxY)
        {
            return true
        }
        else if(self._dir == .SOUTH && self.position.y + self._size.height * 2 < rect.minY)
        {
            return true
        }
        else if(self._dir == .WEST && self.position.x + self._size.height < rect.minX)
        {
            return true
        }
        else if(self._dir == .EAST && self.position.x - self._size.height > rect.maxX)
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
}


















/* SCORING
PLUS
For every pedestrian that crosses the street your at that is happy:25 points,
For every pedestrian that crosses the street your at that is OK: 5 points.
For every pedestrian that crosses the street your at that is irritated: 0 points.


MINUS
For every pedestrian that crosses the street your at that is  angry: -5
crash: -75 per pedestrian,

*/





/*

LR1  moving from left side to right side, hit end of sidewalk begining of cross walk at TW*2 (TH*6 - TH*7) DIRECTION EAST
LR2  moving from left side to right side, hit end of sidewalk begining of cross walk at TW*2 (TH*11 - TH*12) DIRECTION EAST
RL1  moving from right side to left side, hit end of sidewalk begining of cross walk at TW*6 (TH*6 - TH*7) DIRECTION WEST
RL2  moving from right side to left side, hit end of sidewalk begining of cross walk at TW*6 (TH*11 - TH*12) DIRECTION WEST
TB1  moving from top side to bottom side, hit end of sidewalk begining of cross walk at (TW*1 - TW*2) TH*7 DIRECTION SOUTH
TB2  moving from top side to bottom side, hit end of sidewalk begining of cross walk at (TW*6 - TW*7) TH*7 DIRECTION SOUTH
BT1  moving from bottom side to top side, hit end of sidewalk begining of cross walk at (TW*1 - TW*2) TH*11 DIRECTION NORTH
BT2  moving from bottom side to top side, hit end of sidewalk begining of cross walk at (TW*6 - TW*7) TH*11 DIRECTION NORTH


*/































