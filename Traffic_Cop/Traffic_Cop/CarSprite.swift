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
    var dir : SpawnPoint
    var _dir : Direction
    var _turnCount : Int
    var _car : SKTexture
    var _spawn  : CGPoint
    var _accelX : CGFloat
    var _accelY : CGFloat
    var _type : Int
    var _textures : [SKTexture] = []
    var _size : CGSize
    
    
    
    init(type : Int , direction : SpawnPoint)
    {
        var tempDirection = direction.getDir()
        self._type = type
        
        switch(tempDirection)
        {
        case 0:
            self._dir = Direction.NORTH
        case 1:
            self._dir = Direction.WEST
        case 2:
            self._dir = Direction.EAST
        case 3:
            self._dir = Direction.SOUTH
        }
        switch(self._type)
        {
        case 1:
            
            self._car = SKTexture(imageNamed: "Ambulence1")
            self._spawn = direction.pos
            self._accelX = 10
            self._accelY = 10
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
            
        case 2:
            self._car = SKTexture(imageNamed:"car_cop")
            self._spawn = direction.pos
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
       
        case 3:
            self._car = SKTexture(imageNamed: "car_blue")
            self._spawn = direction.pos
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
         
        case 4:
            self._car = SKTexture(imageNamed: "car_red")
            self._spawn = direction.pos
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
         
        case 5:
            self._car = SKTexture(imageNamed: "pickup_green")
            self._spawn = direction.pos
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
           
        case 6:
            self._car = SKTexture(imageNamed: "truck")
            self._spawn = direction.pos
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
            
        default :
            self._car = SKTexture(imageNamed: "")
            self._spawn = direction.pos
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 0, height: 0)
            self._turnCount = 0
          
            
        }
        super.init(texture: _car, color: nil, size: self._size)
        
        switch(self._dir)
        {
        case 0:
            self.zRotation = CGFloat(M_PI_2 * 3)    
        case 1:
            self.zRotation = 0
        case 2:
            self.zRotation = CGFloat(M_PI_2 * 2)
        case 3:
            self.zRotation = CGFloat(M_PI_2)
        default:
            self.zRotation = 0
            
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
        
        
        
        self.runAction(SKAction.group([
            action,
            action2
            ]))
        
        
        switch(self._dir)
        {
        case 0:
            self._dir = .EAST
        case 2:
            self._dir = .SOUTH
        case 1:
            self._dir = .NORTH
        case 3:
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
        case 0:
            self.position.y += self._accelY
        case 3:
            self.position.y += -self._accelY
        case 1:
            self.position.x += -self._accelX
        case 2:
            self.position.x += self._accelY
        }
    }
    
    func stop()
    {
        self._accelY = 0
        self._accelX = 0
    }
    
    func turnaright()
    {
        self.zRotation *= pie
    }
    
}












