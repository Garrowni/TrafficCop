//
//  CarSprite.swift
//  ZombieConga
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
    let _MAXSPEED : CGFloat
    var _dir : Direction = Direction.WEST
    var _turnCount : Int
    var _car : SKTexture
    var _spawn  : CGPoint
    var _accel: CGFloat = 1
    var _currSpeed: CGFloat = 0
    var _deAccel: CGFloat = 0
    var _isDone : Bool = false
    var _type : Int
    var _textures : [SKTexture] = []
    var _size : CGSize
    
    
    
    init(type : Int , direction : SpawnPoint)
    {
        var tempDirection = direction.dir
        self._type = type
        self._size = CGSize(width: 152, height: 66)
        switch(self._type)
        {
        case 1:
            
            self._car = SKTexture(imageNamed: "Ambulence1")
            self._spawn = direction.pos
            self._MAXSPEED = 10
            self._turnCount = 0
            
        case 2:
            self._car = SKTexture(imageNamed:"car_cop")
            self._spawn = direction.pos
            self._accel = 0
            self._MAXSPEED = 0
            self._turnCount = 0
       
        case 3:
            self._car = SKTexture(imageNamed: "car_blue")
            self._spawn = direction.pos
            self._accel = 0
            self._MAXSPEED = 0
            self._turnCount = 0
         
        case 4:
            self._car = SKTexture(imageNamed: "car_red")
            self._spawn = direction.pos
            self._accel = 0
            self._MAXSPEED = 0
            self._turnCount = 0
         
        case 5:
            self._car = SKTexture(imageNamed: "pickup_green")
            self._spawn = direction.pos
            self._accel = 0
            self._MAXSPEED = 0
            self._turnCount = 0
           
        case 6:
            self._car = SKTexture(imageNamed: "truck")
            self._spawn = direction.pos
            self._accel = 0
            self._MAXSPEED = 0
            self._turnCount = 0
            
        default :
            self._car = SKTexture(imageNamed: "")
            self._spawn = direction.pos
            self._accel = 0
            self._MAXSPEED = 0
            self._turnCount = 0
          
            
        }
        super.init(texture: _car, color: nil, size: self._size)
        
        switch(self._dir)
        {
        case .NORTH:
            self.zRotation = CGFloat(M_PI_2 * 3)    
        case .WEST:
            self.zRotation = 0
        case .EAST:
            self.zRotation = CGFloat(M_PI_2 * 2)
        case .SOUTH:
            self.zRotation = CGFloat(-M_PI_2)
        default:
            self.zRotation = 0
        
        }
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
    func update()
    {}
    
    func turnRight(path : CGPath)
    {
        self._turnCount++
        let pie = -M_PI_2
        let action = SKAction.followPath(path, asOffset: false , orientToPath: false, duration: 1)
        let action2 = SKAction.rotateByAngle(CGFloat(-M_PI_2), duration: 0.85)
        
        
//        
//        self.runAction(SKAction.group([
//            action,
//            action2
//            ]))
//        
        
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
        //SKAction.
    }
    
    func goStraight()
    {
        switch(self._dir)
        {
        case .NORTH:
            self.position.y += self._accel
        case .SOUTH:
            self.position.y += -self._accel
        case .WEST:
            self.position.x += -self._accel
        case .EAST:
            self.position.x += self._accel
        default:
            println("No direction")
        }
    }
    
    func stop()
    {
        self._accel = 0
        self._accel = 0
    }
    
    func turnaright()
    {
        self.zRotation *= pie
    }
    
    func isDone(rect : CGRect) -> Bool
    {
        if(self._dir == .NORTH && self.position.y > rect.maxY)
        {
            return true
        }
        else if(self._dir == .SOUTH && self.position.y < rect.minY)
        {
            return true
        }
        else if(self._dir == .WEST && self.position.x < rect.minX)
        {
            return true
        }
        else if(self._dir == .EAST && self.position.x > rect.maxX)
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
}












