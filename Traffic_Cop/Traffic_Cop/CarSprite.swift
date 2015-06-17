//
//  CarSprite.swift
//  Traffic_Cop
//
//  Created by Mathew  Manton on 2015-06-04.
//  Copyright (c) 2015 Mathew  Manton. All rights reserved.
//
//YO HO HO

import SpriteKit



class CarSprite : SKSpriteNode
{
    enum Direction
    {
        case WEST, NORTH, EAST, SOUTH
        
    }
    enum State
    {
        case DRIVING, STOPPED, TURNING
    }
    
    let _MAXSPEED : CGFloat
    var _dir : Direction = Direction.WEST
    var _turnCount : Int = 0
    var _car : SKTexture
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
    var _glowRect : GlowBox
    var _rect : CGRect
    var _selectionColor : String = ""
    var _currPos : CGPoint
    
    
    
    init(type : Int , direction : SpawnPoint)
    {
        var tempDirection = direction.dir
        self._type = type
        self._size = CGSize(width: 152, height: 66)
        self._spawn = direction.pos
        self._currPos = _spawn
        self._rect = CGRect(x: self._spawn.x, y: self._spawn.y, width: self._size.width, height: self._size.height)
        self._glowRect = GlowBox(pos: self._rect, roundCorner: 1, OLcolor: "yellow", OLSize: 1, glowWidth: 1, ZoomIn: true, glowBulge: true, alpha:1)
        
        switch(self._type)
        {
        case 1:
            
            self._car = SKTexture(imageNamed: "Ambulence1")
            self._MAXSPEED = 10
           
            
        case 2:
            self._car = SKTexture(imageNamed:"car_cop")
            self._MAXSPEED = 5
            
       
        case 3:
            self._car = SKTexture(imageNamed: "car_blue")
            self._MAXSPEED = 5
           
         
        case 4:
            self._car = SKTexture(imageNamed: "car_red")
            self._MAXSPEED = 5
           
         
        case 5:
            self._car = SKTexture(imageNamed: "pickup_green")
            self._MAXSPEED = 5
            
           
        case 6:
            self._car = SKTexture(imageNamed: "truck")
            self._MAXSPEED = 5
            
            
        default :
            self._car = SKTexture(imageNamed: "")
            self._MAXSPEED = 0
        }
        
        super.init(texture: _car, color: nil, size: self._size)

        self.position = self._currPos
        self._glowRect = GlowBox(pos: super.frame, roundCorner: 1, OLcolor: "yellow", OLSize: 1, glowWidth: 1, ZoomIn: true, glowBulge: true, alpha: 1)
        self.addChild(self._glowRect.OL)
        

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

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    

//***************************Functions*************************
    func update()
    {
      // println("self.frame pos = \(self.position)")
      // println("self._glowRect pos= \(self._glowRect.OL.position)")
       self._glowRect = GlowBox(pos: super.frame, roundCorner: 1, OLcolor: "yellow", OLSize: 1, glowWidth: 1, ZoomIn: true, glowBulge: true, alpha: 1)
        //println("isSelected: \(self._isSelected)")
        switch(self._dir)
        {
        //rotate the sprite to the correct direction
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
        
        
     
        
        if self._state == State.DRIVING
        {
            goStraight()
        }
        else if self._state == State.STOPPED
        {
         
        }
        else if self._state == State.TURNING
        {
            
        }
        

       self.position = self._currPos
    } 

    
    func turnRight(path : CGPath)
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
    
    
    
    func turnLeft()
    {
        
    }
    
    func drive()
    {
        self._state = State.DRIVING
    }
    
    func goStraight()
    {
        self._state = State.DRIVING
        
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












