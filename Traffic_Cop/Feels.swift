//
//  Feels.swift
//  Traffic_Cop
//
//  Created by Nicole Garrow on 2015-06-18.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//
import SpriteKit



class Feels : SKSpriteNode
{
    enum Direction
    {
        case WEST, NORTH, EAST, SOUTH
        
    }
    
    let _MAXSPEED : CGFloat//make equal to the object its connected to
    var _dir : Direction = Direction.WEST  //make equal to the object its connected to
    var _turnCount : Int = 0//make equal to the object its connected to
    var _feeling : SKTexture
    var _spawn  : CGPoint//make equal to the object its connected to
    var _accel: CGFloat = 1 //make equal to the object its connected to
    var _currSpeed: CGFloat = 0 //make equal to the object its connected to
    var _deAccel: CGFloat = 0 //make equal to the object its connected to
    var _isDone : Bool = false //make equal to the object its connected to
    var _type : Int
    var _textures : [SKTexture] = []
    var _size : CGSize
    var _glowCircle : GlowCircle
    var _currPos : CGPoint //make equal to the object its connected to
   

    
    init(type : Int , direction : SpawnPoint)
    {
        var tempDirection = direction.dir
        self._size = CGSize(width: 16, height: 16)
        self._spawn = direction.pos
        self._glowCircle = GlowCircle(pos: self._spawn, radius: 20, OLcolor: "yellow", OLSize: 10, glowWidth: 40, ZoomIn: true, glowBulge: true, alpha: 0.5)
        self._currPos = _spawn
        self._type = type
        
        
        switch(self._type)
        {
        case 1:
            self._feeling = SKTexture(imageNamed: "happy")
            self._MAXSPEED = 5 //math to person or car
        case 2:
            self._feeling = SKTexture(imageNamed: "content")
            self._MAXSPEED = 4 //math to person or car
        case 3:
            self._feeling = SKTexture(imageNamed: "irritated")
            self._MAXSPEED = 5 //math to person or car
        case 4:
            self._feeling = SKTexture(imageNamed: "mad")
            self._MAXSPEED = 5 //math to person or car
        case 5:
            self._feeling = SKTexture(imageNamed: "exclamation")
            self._MAXSPEED = 5 //math to person or car
            
            
            
        default :
            self._feeling = SKTexture(imageNamed: "")
            self._MAXSPEED = 0
        }
        
        
        super.init(texture: _feeling, color: nil, size: self._size)
        self.position = self._currPos
        self.setScale(CGFloat(2.5))
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    

    
    

 
 
}










