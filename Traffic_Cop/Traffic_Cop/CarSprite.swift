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
    
     var _car : SKTexture
     var _spawn  : CGPoint
     var _accelX : Float
     var _accelY : Float
     var _type : Int
     var _textures : [SKTexture] = []
     var _size : CGSize
    
    
    
    init(type : Int , spawn : CGPoint)
    {
        
        self._type = type
        
        switch(self._type)
        {
        case 1:
            
            self._car = SKTexture(imageNamed: "Ambulence1")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
            
        case 2:
            self._car = SKTexture(imageNamed:"car_cop")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
        case 3:
            self._car = SKTexture(imageNamed: "car_blue")
           self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
        case 4:
            self._car = SKTexture(imageNamed: "car_red")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
        case 5:
            self._car = SKTexture(imageNamed: "pickup_green")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
        case 6:
            self._car = SKTexture(imageNamed: "truck")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 152, height: 66)
        default :
            self._car = SKTexture(imageNamed: "")
            self._spawn = spawn
            self._accelX = 0
            self._accelY = 0
            self._size = CGSize(width: 0, height: 0)
            
        }
        super.init(texture: _car, color: nil, size: self._size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    func update()
    {}
    
    func TurnRight()
    {}
    
    func TurnLeft()
    {}
    
    func GoStraight()
    {}
}









