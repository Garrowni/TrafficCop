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
    
    
    var startTime = NSTimeInterval()
    
    var timer:NSTimer = NSTimer()
   
    
    
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
            self._MAXSPEED = 4
        case 2:
            self._person = SKTexture(imageNamed: "LadyBaby")
            self._MAXSPEED = 3
            self._size = CGSize(width: 64, height: 50)
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
    
    
   /* func pickDirection()
    {
       // var _dir = Direction: Int.randomNumberFrom(0...Direction!.count-1)
    //    if (self._dir == Direction.WEST)
        {
         //choose random direction north south east
            //exception only choose north or south
            //exception only choose south or east
            //exception only choose east or north
                //exception only choose north
                //exception only choose east
                //exception only choose south
        }
        if (self._dir == Direction.SOUTH)
        {
        //choose random direction north east west
            //exception only choose north or west
            //exception only choose west or east
            //exception only choose east or north
            //exception only choose north
            //exception only choose west
          //  if(/*if you can onlyc hoose east*/)
          //  {
          //      self._dir == Direction.EAST)
          //  }
           // else
          //  {
            //choose from north east or west
           // }
        }
        if (self._dir == Direction.EAST)
        {
        //choose random direction north south west
            //exception only choose north or south
            //exception only choose south or west
            //exception only choose west or north
            //exception only choose north
            //exception only choose west
            //exception only choose south
        }
        if (self._dir == Direction.NORTH)
        {
            //choose random direction south east west
            //exception only choose west or south
            //exception only choose south or east
            //exception only choose east or west
            //exception only choose east
            //exception only choose west
            //exception only choose south
        }

   }*/
   
    
   
    
    func walk()
        
    {
        self._state = State.WALKING
    
    }
    
    func goStraight()
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





































