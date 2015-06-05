//
//  CarSprite.swift
//  ZombieConga
//
//  Created by Mathew  Manton on 2015-06-04.
//  Copyright (c) 2015 Mathew  Manton. All rights reserved.
//

import SpriteKit



class CarSprite
{
    
    var _car : SKSpriteNode
    var _spawn  : CGPoint
    var _accelX : Float
    var _accelY : Float
    var _type : Int
    var _textures : [SKTexture] = []
    
    
    
    init(type : Int , spawnX : CGFloat, spawnY : CGFloat)
    {
        self._type = type
        
        switch(self._type)
        {
        case 1:
            self._car = SKSpriteNode(imageNamed: "Ambulence1")
            self._spawn = CGPoint(x: spawnX, y: spawnY)
            self._accelX = 0
            self._accelY = 0
            
        case 2:
            self._car = SKSpriteNode(imageNamed:"car_cop")
            self._spawn = CGPoint(x: spawnX, y: spawnY)
            self._accelX = 0
            self._accelY = 0
        case 3:
            self._car = SKSpriteNode(imageNamed: "car_blue")
           self._spawn = CGPoint(x: spawnX, y: spawnY)
            self._accelX = 0
            self._accelY = 0
        case 4:
            self._car = SKSpriteNode(imageNamed: "car_red")
            self._spawn = CGPoint(x: spawnX, y: spawnY)
            self._accelX = 0
            self._accelY = 0
        case 5:
            self._car = SKSpriteNode(imageNamed: "pickup_green")
            self._spawn = CGPoint(x: spawnX, y: spawnY)
            self._accelX = 0
            self._accelY = 0
        case 6:
            self._car = SKSpriteNode(imageNamed: "truck")
            self._spawn = CGPoint(x: spawnX, y: spawnY)
            self._accelX = 0
            self._accelY = 0
        default :
            self._car = SKSpriteNode(imageNamed: "")
            self._spawn = CGPoint(x: spawnX, y: spawnY)
            self._accelX = 0
            self._accelY = 0
            
        }
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









