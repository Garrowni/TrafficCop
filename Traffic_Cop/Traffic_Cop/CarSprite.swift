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
        case DRIVING, STOPPED, TURNING, WAITING
    }
    
    let _MAXSPEED : CGFloat
    var _dir : Direction = Direction.WEST
    var _turnCount : Int = 0
    var _car : SKTexture
    var _spawn  : CGPoint
    var _accel: CGFloat = 0.5
    var _currSpeed: CGFloat = 0
    var _deAccel: CGFloat = 0
    var _isDone : Bool = false
    var _type : Int
    var _textures : [SKTexture] = []
    var _size : CGSize
    var _state : State = State.DRIVING
    var _isSelected : Bool = false
    var _turned : Bool = false
  
    var _selectionColor : String = ""
    var _currPos : CGPoint
    
    
    
    init(type : Int , direction : SpawnPoint)
    {
        var tempDirection = direction.dir
        self._type = type
        self._size = CGSize(width: 152, height: 66)
        self._spawn = direction.pos
        self._currPos = _spawn
        switch(self._type)
        {
        case 1:
            
            self._car = SKTexture(imageNamed: "Ambulence1")
            self._MAXSPEED = 15
           
            
        case 2:
            self._car = SKTexture(imageNamed:"car_cop")
            self._MAXSPEED = 15
            
       
        case 3:
            self._car = SKTexture(imageNamed: "car_blue")
            self._MAXSPEED = 15
           
         
        case 4:
            self._car = SKTexture(imageNamed: "car_red")
            self._MAXSPEED = 15
           
         
        case 5:
            self._car = SKTexture(imageNamed: "pickup_green")
            self._MAXSPEED = 15
            
           
        case 6:
            self._car = SKTexture(imageNamed: "truck")
            self._MAXSPEED = 15
            
            
        default :
            self._car = SKTexture(imageNamed: "")
            self._MAXSPEED = 0
        }
        
        super.init(texture: _car, color: nil, size: self._size)
        self.position = self._currPos
        

        //position the car in the middle of the road
        switch(tempDirection)
        {
        case 0:
            self._dir = Direction.NORTH
            self._spawn.x = direction.pos.x - self._size.width/2
            self._spawn.y = direction.pos.y - self._size.height
            self.zRotation = CGFloat(M_PI_2 * 3)
        case 1:
            self._dir = Direction.WEST
            self._spawn.x = direction.pos.x + self._size.width
            self._spawn.y = direction.pos.y - self._size.height/2
            self.zRotation = 0
        case 2:
            self._dir = Direction.EAST
            self._spawn.x = direction.pos.x - self._size.width
            self._spawn.y = direction.pos.y - self._size.height/2
            self.zRotation = CGFloat(M_PI_2 * 2)
        case 3:
            self._dir = Direction.SOUTH
            self._spawn.x = direction.pos.x - self._size.width/2
            self._spawn.y = direction.pos.y + self._size.height
            self.zRotation = CGFloat(M_PI_2)
        default:
            self._dir = Direction.WEST
            self._spawn.x = direction.pos.x + self._size.height
            self._spawn.y = direction.pos.y - self._size.width/2
            self.zRotation = 0
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    

//***************************Functions*************************
    func update()
    {
    
        self._currPos = self.position
        
        if self._state == State.DRIVING
        {
            goStraight()
        }
        

       self.position = self._currPos
    } 

    func turnRight(path : CGPath)
    {
        
        
        self._state = State.TURNING

        
        let action = SKAction.followPath(path, asOffset: false , orientToPath: false, duration: 2)
        let action2 = SKAction.rotateByAngle(CGFloat(-M_PI_2), duration: 2)
        var block = SKAction.runBlock()
                        {
                          self._turned = true
                        }
      
        
            var group = SKAction.group([
            action,
            action2,
            
            ])
       var sequence = SKAction.sequence([group,block])
       self.runAction(sequence)
        
        
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
         self._turnCount++
         
    }
    
    
    
    func turnLeft(path : CGPath)
    {
        
       
           
            self._state = State.TURNING
            
            let action = SKAction.followPath(path, asOffset: false , orientToPath: false, duration: 2)
            let action2 = SKAction.rotateByAngle(CGFloat(M_PI_2), duration: 2)
          
            var block = SKAction.runBlock()
            {
                self._turned = true
            }
        
        
            var group = SKAction.group([
                action,
                action2,
                ])
        
            var sequence = SKAction.sequence([group,block])
            self.runAction(sequence)
        

            
            
            switch(self._dir)
            {
            case .NORTH:
                self._dir = .WEST
            case .EAST:
                self._dir = .NORTH
            case .WEST:
                self._dir = .SOUTH
            case .SOUTH:
                self._dir = .EAST
            default:
                self._dir = .WEST
                
                
            }
            
        
         self._turnCount++
        
    }
    
    func drive()
    {
        self._state = State.DRIVING
    }
    
    func goStraight()
    {
        if(self._state == .STOPPED)
        {
            self._turnCount++
            
            self._state = State.DRIVING
            var block = SKAction.runBlock()
                {
                    self._turned = true
                }
            var wait = SKAction.waitForDuration(2)
            
            
            var sequence = SKAction.sequence([wait,block])
            self.runAction(sequence)
        }
        
        
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
        if self._state != .WAITING
        {
            self._state = State.STOPPED
        }
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
    func hasTurned() -> Bool
    {
        if(!self._turned)
        {
            return false
        }
        else
        {
            self._turned = false
            return true
        }
    }
    
}












