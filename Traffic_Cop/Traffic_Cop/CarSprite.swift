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
    var _dir : SpawnPoint.DIR
    var _turnCount : Int
    var _car : SKTexture
    var _spawn  : CGPoint
    var _accelX : CGFloat
    var _accelY : CGFloat
    var _type : Int
    var _textures : [SKTexture] = []
    var _size : CGSize
    
    
    
    init(type : Int , spawn : CGPoint, direction : SpawnPoint.DIR)
    {
        
        self._type = type
        switch(self._type)
        {
        case 1:
            
            self._car = SKTexture(imageNamed: "Ambulence1")
            self._spawn = spawn
            self._accelX = 10
            self._accelY = 10
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
            self._dir = SpawnPoint.get
            
        case 2:
            self._car = SKTexture(imageNamed:"car_cop")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
            self._dir = direction
        case 3:
            self._car = SKTexture(imageNamed: "car_blue")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
            self._dir = direction
        case 4:
            self._car = SKTexture(imageNamed: "car_red")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
            self._dir = direction
        case 5:
            self._car = SKTexture(imageNamed: "pickup_green")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
            self._dir = direction
        case 6:
            self._car = SKTexture(imageNamed: "truck")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            self._turnCount = 0
            self._dir = direction
        default :
            self._car = SKTexture(imageNamed: "")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 0, height: 0)
            self._turnCount = 0
            self._dir = direction
            
        }
        super.init(texture: _car, color: nil, size: self._size)
        
        switch(self._dir)
        {
            
        case .:
            self.zRotation = 0
        case .SOUTH:
            self.zRotation = CGFloat(M_PI_2)
        case .EAST:
            self.zRotation = CGFloat(M_PI_2 * 2)
        case .NORTH:
            self.zRotation = CGFloat(M_PI_2 * 3)
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
            self.position.y += self._accelY
        case .SOUTH:
            self.position.y += -self._accelY
        case .WEST:
            self.position.x += -self._accelX
        case .EAST:
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












