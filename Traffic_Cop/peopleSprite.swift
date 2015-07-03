//
//  peopleSprite.swift
//  Traffic_Cop
//
//  Created by Nicole Garrow on 2015-06-17.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.

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
        case WALKING, STOPPED, TURNING, DEAD
    }
    
    enum Options
    {
        case STRAIGHT, LEFT, RIGHT
    }

    
    let _MAXSPEED       : CGFloat
    var _dir            : Direction = Direction.WEST
    var _turnCount      : Int = 0
    var _person         : SKTexture
    var _spawn          : CGPoint
    var _accel          : CGFloat = 2
    var _currSpeed      : CGFloat = 0
    var _deAccel        : CGFloat = 0
    var _isDone         : Bool = false
    var _type           : Int
    var _textures       : [SKTexture] = []
    var _size           : CGSize
    var _state          : State = State.STOPPED
    var _isSelected     : Bool = false
    var _glowCircle     : GlowCircle
    var _currPos        : CGPoint
    var _corner         : Corner?
    var canGoNorth      : Bool = false
    var canGoSouth      : Bool = false
    var canGoEast       : Bool = false
    var canGoWest       : Bool = false
    var _mass           = CGFloat(1) // UNIVAERSAL MASS FOR ALL HUMANS , DONT THINK THERE IS A NEED TO VARY IT
    let RotateRadPerSec : CGFloat = 2.0 * pie
    
    var MadeChoice      : Bool = false
    var canTurnLeft     : Bool = false //AVAILABLE CHOICES SENT FROM THE GAMESCENE AT ILLUMINATION OF ROADS
    var canTurnRight    : Bool = false
    var canGoStraight   : Bool = false
    
    
    init(type : Int , direction : SpawnPoint)
    {
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
            self._MAXSPEED = 40
        case 2:
            self._person = SKTexture(imageNamed: "LadyBaby")
            self._MAXSPEED = 40
            self._size = CGSize(width: 40, height: 30)
        case 3:
            self._person = SKTexture(imageNamed: "OldMan")
            self._MAXSPEED = 30
        case 4:
            self._person = SKTexture(imageNamed:"littleGirl")
            self._MAXSPEED = 60
        case 5:
            self._person = SKTexture(imageNamed:"carGuy")
            self._size = CGSize(width: 40, height: 20)
            self._MAXSPEED = 40
            
        default :
            self._person = SKTexture(imageNamed: "")
            self._MAXSPEED = 0
        }
        
        super.init(texture: _person, color: nil, size: self._size)
        self.position = self._currPos
        self.setScale(CGFloat(2.5))
        
        //PHYSICS ====================================================
        let physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.size.width - 40, height: self.frame.size.height - 40))// INSET THE COLLISION AREA A BIT
        physicsBody.allowsRotation      = true
        physicsBody.restitution         = 0.8
        physicsBody.friction            = 0.2
        physicsBody.linearDamping       = 1
        physicsBody.mass                = self._mass
        physicsBody.categoryBitMask     = PhysicsCategory.Person
        physicsBody.contactTestBitMask  = PhysicsCategory.Car
        physicsBody.collisionBitMask    = PhysicsCategory.Car
        physicsBody.affectedByGravity   = false
        physicsBody.angularDamping      = 0.5
        //===============================================================
        
        switch(tempDirection)
        {
        case 0:
            self._dir = Direction.NORTH
            self._spawn.x = direction.pos.x - self._size.width/2
            self._spawn.y = direction.pos.y - self._size.height
            self.position.y -= 50
            self.zRotation = CGFloat(M_PI_2 * 3)
        case 1:
            self._dir = Direction.WEST
            self._spawn.x = direction.pos.x + self._size.width
            self._spawn.y = direction.pos.y - self._size.height/2
            self.position.x += 50
            self.zRotation = CGFloat(0)
        case 2:
            self._dir = Direction.EAST
            self._spawn.x = direction.pos.x - self._size.width
            self._spawn.y = direction.pos.y - self._size.height/2
            self.position.x -= 50
            self.zRotation = CGFloat(M_PI_2 * 2)
        case 3:
            self._dir = Direction.SOUTH
            self._spawn.x = direction.pos.x - self._size.width/2
            self._spawn.y = direction.pos.y + self._size.height
            self.position.y += 50
            self.zRotation = CGFloat(M_PI_2)
        default:
            self._dir = Direction.WEST
            self._spawn.x = direction.pos.x + self._size.height
            self._spawn.y = direction.pos.y - self._size.width/2
            self.position.x += 50
            
        }
        
        //////////////////////////////
        self.physicsBody = physicsBody
        let myRect: CGRect
        myRect = CGRectMake(self.position.x+8, self.position.y+8, 16.0, 16.0)
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder: ) has not been implemented")
    }
    
    
    //***************************Functions*************************
    func update()
    {
        if self._state == State.WALKING
        {
            goStraight()
        }
    }
    
    func rotatePerson(direction: String)
    {
        switch(direction)
        {
            case "left"  : self.runAction(SKAction.rotateByAngle(CGFloat(pie/2), duration: 2))  //90 degree turn
            case "right" : self.runAction(SKAction.rotateByAngle(CGFloat(-pie/2), duration: 2)) //-90 degree turn
            default: break;
        }
    }
    
    func walk()
    {
        self._state = State.WALKING
    }
    
    func goStraight()
    {
        if(self._state != State.DEAD)
        {
            self._state = State.WALKING
            
            if (self._currSpeed < self._MAXSPEED)
            {
                self._currSpeed += self._accel
            }
            
            switch(self._dir)
            {
            case .NORTH:
                self.physicsBody!.velocity.dy = self._currSpeed
            case .SOUTH:
                self.physicsBody!.velocity.dy = -self._currSpeed
            case .WEST:
                self.physicsBody!.velocity.dx = -self._currSpeed
            case .EAST:
                self.physicsBody!.velocity.dx = self._currSpeed
            default:
                println("No direction")
            }
        }

    }
    
    func stop()
    {
        //self.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        self._state = State.STOPPED
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
        var time = 0 //stand still time
        var time2 = 0 //decisiontime
        self._currSpeed = 0
        if (self._type == 1)
        {
            time = 5
            time2 = 2
        }
        if (self._type == 2)
        {
           time = 4
            time2 = 2
        }
        if (self._type == 3 || self._type == 5)
        {
            time = 2
            time2 = 2
        }
        if (self._type == 4)//KID
        {
            time = 0
            time2 = 2
        }
        
        
        
        
        var wait2 = SKAction.waitForDuration(NSTimeInterval(time2))
        var block = SKAction.runBlock(){self.MadeChoice = false}
        var block2 = SKAction.runBlock(){self.walk()}
        var wait = SKAction.waitForDuration(NSTimeInterval(time))
        var stopblock = SKAction.runBlock(){self.stop()}
        var sequence = SKAction.sequence([stopblock, wait, block2, wait2, block])
        self.runAction(sequence)
       
        
        
    }
    //WEST, NORTH, EAST, SOUTH
    func TurnLeft()
    {
      rotatePerson("left")
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
        rotatePerson("right")
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





















