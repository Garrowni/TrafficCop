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
import Foundation



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
    
    enum Options
    {
        case STRAIGHT, LEFT, RIGHT
    }

    
    let _MAXSPEED : CGFloat
    var _dir : Direction = Direction.WEST
    var _turnCount : Int = 0
    var _person : SKTexture
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
    var _corner: Corner?
    var canGoNorth : Bool = false
    var canGoSouth : Bool = false
    var canGoEast : Bool = false
    var canGoWest : Bool = false
    
    var MadeChoice : Bool = false
    
    
    
    var canTurnLeft : Bool    = false //AVAILABLE CHOICES SENT FROM THE GAMESCENE AT ILLUMINATION OF ROADS
    var canTurnRight : Bool   = false
    var canGoStraight :Bool   = false
    
   
    
    
    
    
    init(type : Int , direction : SpawnPoint)
    {
        /*CGRectMake(x: self.position.x+8, y: self.position+8, width: 16.0, height: 16.0) ->myRect
        {
            return myRect
        }*/
      
       
        
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
            self._MAXSPEED = 3
        case 2:
            self._person = SKTexture(imageNamed: "LadyBaby")
            self._MAXSPEED = 3
            self._size = CGSize(width: 40, height: 30)
        case 3:
            self._person = SKTexture(imageNamed: "OldMan")
            self._MAXSPEED = 2
        case 4:
            self._person = SKTexture(imageNamed:"littleGirl")
            self._MAXSPEED = 5
            
        default :
            self._person = SKTexture(imageNamed: "")
            self._MAXSPEED = 0
        }
        
        
        super.init(texture: _person, color: nil, size: self._size)
        self.position = self._currPos
        self.setScale(CGFloat(2.5))
        
        switch(tempDirection)
        {
        case 0:
            self._dir = Direction.NORTH
            self._spawn.x = direction.pos.x - self._size.width/2
            self._spawn.y = direction.pos.y - self._size.height
            self.position.y -= 50
        case 1:
            self._dir = Direction.WEST
            self._spawn.x = direction.pos.x + self._size.width
            self._spawn.y = direction.pos.y - self._size.height/2
            self.position.x += 50
        case 2:
            self._dir = Direction.EAST
            self._spawn.x = direction.pos.x - self._size.width
            self._spawn.y = direction.pos.y - self._size.height/2
            self.position.x -= 50
        case 3:
            self._dir = Direction.SOUTH
            self._spawn.x = direction.pos.x - self._size.width/2
            self._spawn.y = direction.pos.y + self._size.height
             self.position.y += 50
        default:
            self._dir = Direction.WEST
            self._spawn.x = direction.pos.x + self._size.height
            self._spawn.y = direction.pos.y - self._size.width/2
            self.position.x += 50
            
        }
        //////////////////////////////
        let myRect: CGRect
        myRect = CGRectMake(self.position.x+8, self.position.y+8, 16.0, 16.0)
                }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
        
        
        
        
    }
    
    
    //***************************Functions*************************
    func update()
    {
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
     
        if self._state == State.WALKING
        {
            goStraight()
        }
        else if self._state == State.STOPPED
        {
            self._currSpeed = 0
            if (self._type == 1)
            {
                var timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("goStraight"), userInfo: nil, repeats: false)
            }
            if (self._type == 2)
            {
                var timer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("goStraight"), userInfo: nil, repeats: false)
            }
            if (self._type == 3)
            {
                var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("goStraight"), userInfo: nil, repeats: false)
            }
        }
    }
    
    func walk()
    {
        self._state = State.WALKING
    
    }
    
    func goStraight()
    {
        self._state = State.WALKING
        self._currSpeed = self._MAXSPEED
        
        
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
    
    func stop()
    {
        self._currSpeed = 0
        self._state = State.STOPPED
        self.MadeChoice = false
    }
    
    
    func isDone(rect : CGRect) -> Bool
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
    
    
    
    
    
    func walkOptions(corner: Corner)
    {
        if (!MadeChoice)
        {
         canGoNorth = corner.North
        canGoSouth = corner.South
        canGoEast = corner.East
        canGoWest = corner.West
        ChangeDirection()
    }
    
        
    }
    //WEST, NORTH, EAST, SOUTH
    func ChangeDirection()
    {
        switch(self._dir.hashValue)
        {
        case 0: //west
            if(canGoNorth){canTurnRight = true} else {canTurnRight = false}
            if(canGoSouth){canTurnLeft = true} else {canTurnLeft = false}
            if(canGoWest){canGoStraight = true} else {canGoStraight = false}
            
        case 1: //north
            if(canGoEast){canTurnRight = true} else {canTurnRight = false}
            if(canGoWest){canTurnLeft = true} else {canTurnLeft = false}
            if(canGoNorth){canGoStraight = true} else {canGoStraight = false}
            
        case 2: //east
            if(canGoSouth){canTurnRight = true} else {canTurnRight = false}
            if(canGoNorth){canTurnLeft = true} else {canTurnLeft = false}
            if(canGoEast){canGoStraight = true} else {canGoStraight = false}
        case 3: //south
            if(canGoEast){canTurnLeft = true} else {canTurnLeft = false}
            if(canGoWest){canTurnRight = true} else {canTurnRight = false}
            if(canGoSouth){canGoStraight = true} else {canGoStraight = false}
        default: break
        }
        RollDirection()
    }
    
    func RollDirection()
    {
        var Roll = 0
      
       if (canTurnRight && canTurnLeft && !canGoStraight)
        {
         Roll = Int.randomNumberFrom(1...2)
            if (Roll == 1)
            {
                TurnRight()
            }
            if (Roll == 2)
            {
                TurnLeft()
            }
        
        }
     if (!canTurnRight && canTurnLeft && canGoStraight)
        {
            Roll = Int.randomNumberFrom(1...2)
            if (Roll == 1)
            {
                TurnLeft()
            }
            if (Roll == 2)
            {
                GoStraight()
            }
            
        }
        if (canTurnRight && !canTurnLeft && canGoStraight)
        {
            Roll = Int.randomNumberFrom(1...2)
            if (Roll == 1)
            {
                TurnRight()
            }
            if (Roll == 2)
            {
                GoStraight()
            }
            
        }
        
      if (canTurnRight && canTurnLeft && canGoStraight)
        {
            Roll = Int.randomNumberFrom(1...3)
            if (Roll == 1)
            {
                TurnLeft()
            }
            if (Roll == 2)
            {
                TurnRight()
            }
            if (Roll == 3)
            {
                GoStraight()
            }
        }
        self.MadeChoice = true
        
        var wait = SKAction.waitForDuration(2.0)
        var block = SKAction.runBlock(){self.MadeChoice = false}
        var sequence = SKAction.sequence([wait, block])
        self.runAction(sequence)
        
    }
    
    //WEST, NORTH, EAST, SOUTH
    func TurnLeft()
    {
      switch(self._dir.hashValue)
      {
      case 0: //west
        self._dir = .SOUTH
      case 1: //north
        self._dir = .WEST
      case 2: //east
        self._dir = .NORTH
      case 3: //south
        self._dir = .EAST
        
      default: break}
    }
    func TurnRight()
    {
        switch(self._dir.hashValue)
        {
        case 0: //west
            self._dir = .NORTH
        case 1: //north
            self._dir = .EAST
        case 2: //east
            self._dir = .SOUTH
        case 3: //south
            self._dir = .WEST
            
        default: break}

    }
    func GoStraight()
    {
        switch(self._dir.hashValue)
        {
        case 0: //west
            self._dir = .WEST
        case 1: //north
            self._dir = .NORTH
        case 2: //east
            self._dir = .EAST
        case 3: //south
            self._dir = .SOUTH
            
        default: break}

    }
    
    
   
    
    
}





















