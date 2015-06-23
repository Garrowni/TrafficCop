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
            self._MAXSPEED = 3
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
     
        if self._state == State.WALKING
        {            goStraight()
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


   
    
 

    
  
    
    func pickDirection()
    {
         //self._dir =  Int.randomNumberFrom(0...3)
       if (self._dir == Direction.WEST)
        {
            //if(/*if you can onlyc hoose east*/)
            //{
            //  self._dir == Direction.EAST)
            //}
            //else if(/*if you can onlyc hoose north*/)
            //{
            //  self._dir == Direction.NORTH)
            //}
            //else if(/*if you can onlyc hoose south*/)
            //{
            //  self._dir == Direction.SOUTH)
            //}
            //else if (/*you can choose north or south*/
            //{
            //  randomly select either North or SOUTH
            //}
            //else if (/*you can choose north or east*/
            //{
            //  randomly select either North or east
            //}
            //else if (/*you can choose east or south*/
            //{
            //  randomly select either EAST or south
            //}
            //else
            //{
            //  choose from north east or west
            //}
        }
        if (self._dir == Direction.SOUTH)
        {
          //if(/*if you can onlyc hoose east*/)
            //{
            //  self._dir == Direction.EAST)
            //}
            //else if(/*if you can onlyc hoose north*/)
            //{
            //  self._dir == Direction.NORTH)
            //}
            //else if(/*if you can onlyc hoose west*/)
            //{
            //  self._dir == Direction.WEST)
            //}
            //else if (/*you can choose north or west*/
            //{
            //  randomly select either North or west
            //}
            //else if (/*you can choose north or east*/
            //{
            //  randomly select either North or east
            //}
            //else if (/*you can choose east or west*/
            //{
            //  randomly select either EAST or west
            //}
            //else
            //{
            //  choose from north east or west
            //}
        }
        if (self._dir == Direction.EAST)
        {
            //if(/*if you can onlyc hoose south*/)
            //{
            //  self._dir == Direction.SOUTH)
            //}
            //else if(/*if you can onlyc hoose north*/)
            //{
            //  self._dir == Direction.NORTH)
            //}
            //else if(/*if you can onlyc hoose west*/)
            //{
            //  self._dir == Direction.WEST)
            //}
            //else if (/*you can choose north or west*/
            //{ 
            //  randomly select either North or west
            //}
            //else if (/*you can choose north or south*/
            //{ 
            //  randomly select either North or south
            //}
            //else if (/*you can choose south or west*/
            //{ 
            //  randomly select either SOUTH or west
            //}
            //else
            //  {
            //      choose from north south or west
            //  }
        }
        if (self._dir == Direction.NORTH)
        {
            
            //if(/*if you can onlyc hoose east*/)
            //{
            //  self._dir == Direction.EAST)
            //}
            //else if(/*if you can onlyc hoose south*/)
            //{
            //  self._dir == Direction.SOUTH)
            //}
            //else if(/*if you can onlyc hoose west*/)
            //{
            //  self._dir == Direction.WEST)
            //}
            //else if (/*you can choose south or west*/
            //{
            //  randomly select either south or west
            //}
            //else if (/*you can choose south or east*/
            //{ 
            //  randomly select either south or east
            //}
            //else if (/*you can choose east or west*/
            //{ 
            //  randomly select either EAST or west
            //}
            //else
            //{
            //choose from south east or west
            //}
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
    
}





































