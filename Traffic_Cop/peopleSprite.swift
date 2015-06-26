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
    
    enum Options
    {
        case STRAIGHT, LEFT, RIGHT
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
    
    

    var _stopped : Int = 0
    
    
    
    var canTurnLeft     = false //AVAILABLE CHOICES SENT FROM THE GAMESCENE AT ILLUMINATION OF ROADS
    var canTurnRight    = false
    var canGoStraight   = false
    
   
    
    
    
    
    init(type : Int , direction : SpawnPoint)
    {
        /*CGRectMake(x: self.position.x+8, y: self.position+8, width: 16.0, height: 16.0) ->myRect
        {
            return myRect
        }*/
      
       
        
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
            self._size = CGSize(width: 40, height: 30)
        case 3:
            self._person = SKTexture(imageNamed: "OldMan")
            self._MAXSPEED = 2
        case 4:
            self._person = SKTexture(imageNamed:"littleGirl")
            self._MAXSPEED = 5
            self._stopped = 1
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
        //////////////////////////////
        let myRect: CGRect
        myRect = CGRectMake(self.position.x+8, self.position.y+8, 16.0, 16.0)
                }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
        
        
        
        
    }
    
    
    //***************************Functions*************************
    func update()
    {
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
        {
            goStraight()
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

  
 

    
   
    
    func walk()
    {
        self._state = State.WALKING
        self._stopped = 0
    }
    
    func goStraight()
    {
        self._state = State.WALKING
        self._currSpeed = self._MAXSPEED
                self._stopped = 0
        
        
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
        self._stopped = 1
        
        self.setChoices( true, left: true, right: true)

       
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
    
 
    func setChoices(forward: Bool, left: Bool, right: Bool)
    {
        canTurnLeft     = left
        canTurnRight    = right
        canGoStraight   = forward
        println("CAN TURN -----> Straight:\(canGoStraight) Right: \(canTurnRight)  Left: \(canTurnLeft)")
        rollChoice()
    }
    
    func rollChoice()
    {
        var rollAmount = 0
        if(canTurnLeft)  {rollAmount++}
        if(canTurnRight) {rollAmount++}
        if(canGoStraight){rollAmount++}
        var rand = Int.randomNumberFrom(1...rollAmount)
        if(canTurnLeft && canTurnRight && !canGoStraight)
        {
            if(rand == 1) //turn left
            {
                if (self._dir == .EAST)
                { 
                    self._dir = .NORTH
                }
                if (self._dir == .WEST)
                {
                    self._dir == .SOUTH
                }
            }
            if(rand == 2)//turn right
            {
                if (self._dir == .EAST)
                {
                    self._dir = .SOUTH
                }
                if (self._dir == .WEST)
                {
                    self._dir = .NORTH
                }
            }
        }
    
        if(canTurnLeft && canGoStraight && !canTurnRight)
        {
            if(rand == 1)//turn left
            {
                if (self._dir == .NORTH)
                {
                    self._dir = .WEST
                }
                if (self._dir == .SOUTH)
                {
                    self._dir = .EAST
                }
            }

            if(rand == 2)//go straight
            {
                if (self._dir == .NORTH)
                {
                    self._dir = .NORTH
                }
                if (self._dir == .SOUTH)
                {
                    self._dir = .SOUTH
                }
            }
        }
    
        if(canTurnRight && canGoStraight && !canTurnLeft)
        {
            if(rand == 1)//go right
            {
                if (self._dir == .NORTH)
                {
                    self._dir = .EAST
                }
                if (self._dir == .SOUTH)
                {
                    self._dir = .WEST
                }
            }
            if(rand == 2) //go straight
            {
                
                if (self._dir == .NORTH)
                {
                    self._dir = .NORTH
                }
                if (self._dir == .SOUTH)
                {
                    self._dir = .SOUTH
                }
            }
        }
        if(canTurnLeft && canTurnRight && canGoStraight)
        {
            if(rand == 1)//left
            {
                if (self._dir == .NORTH)
                {
                    self._dir = .WEST
                }
                if (self._dir == .SOUTH)
                {
                    self._dir = .EAST
                }
                if (self._dir == .EAST)
                {
                    self._dir = .NORTH
                }
                if (self._dir == .WEST)
                {
                    self._dir = .SOUTH
                }
            }
            if(rand == 2)//Right
            {
                if (self._dir == .NORTH)
                {
                    self._dir = .EAST
                }
                if (self._dir == .SOUTH)
                {
                    self._dir = .WEST
                }
                if (self._dir == .EAST)
                {
                    self._dir = .SOUTH
                }
                if (self._dir == .WEST)
                {
                    self._dir = .NORTH
                }
            }
            if(rand == 3)//Straight
            {
                if (self._dir == .NORTH)
                {
                    self._dir = .NORTH
                }
                if (self._dir == .SOUTH)
                {
                    self._dir = .SOUTH
                }
                if (self._dir == .EAST)
                {
                    self._dir = .EAST
                }
                if (self._dir == .WEST)
                {
                    self._dir = .WEST
                }
            }
        }
    
   
    }
    
}












/*

North --> SR, SLR, SL
South --> SR, SLR, SL
East  --> LR, SLR
West  --> LR, SLR

*/



/*
what level?
    What Spot?
        What Direction did you come from / are you going in?
            What Choices?
                Pick Random Choice
                    GO.


*/



/*
Level 1
    Top Left        --> 2 choices per direction (can't access if your going in East direction)
                            North   -->Straight, Right
                                            --> Pick Random choice
                                                    -->go
                            South   -->Straight, Left
                                            --> Pick Random choice
                                                    -->go
                            West    -->Left, Right
                                            --> Pick Random choice
                                                    -->go
    Top Right       --> 3 choices per direction
                            North   -->Straight, Left, Right
                                            --> Pick Random choice
                                                    -->go
                            South   -->Straight, Left, Right
                                            --> Pick Random choice
                                                    -->go
                            East    -->Straight, Left, Right
                                            --> Pick Random choice
                                                    -->go
                            West    -->Straight, Left, Right
                                            --> Pick Random choice
                                                    -->go
    Bottom Left     --> 2 choices per direction (can't access if your going in East direction)
                            North   -->Straight, Right
                                            --> Pick Random choice
                                                    -->go
                            South   -->Straight, Left
                                            --> Pick Random choice
                                                    -->go
                            West    -->Left, Right
                                            --> Pick Random choice
                                                    -->go
    Bottom Right    --> 3 choices per direction
                            North   -->Straight, Left, Right
                                            --> Pick Random choice
                                                    -->go
                            South   -->Straight, Left, Right
                                            --> Pick Random choice
                                                    -->go
                            East    -->Straight, Left, Right
                                            --> Pick Random choice
                                                    -->go
                            West    -->Straight, Left, Right
                                            --> Pick Random choice
                                                    -->go
Level 2
    Top Left        --> 3 choices per direction
                            North   -->Straight, Left, Right
                            South   -->Straight, Left, Right
                            East    -->Straight, Left, Right
                            West    -->Straight, Left, Right
    Top Right       --> 3 choices per direction
                            North   -->Straight, Left, Right
                            South   -->Straight, Left, Right
                            East    -->Straight, Left, Right
                            West    -->Straight, Left, Right
    Bottom Left     --> 3 choices per direction
                            North   -->Straight, Left, Right
                            South   -->Straight, Left, Right
                            East    -->Straight, Left, Right
                            West    -->Straight, Left, Right
    Bottom Right    --> 3 choices per direction
                            North   -->Straight, Left, Right
                            South   -->Straight, Left, Right
                            East    -->Straight, Left, Right
                            West    -->Straight, Left, Right
Level 3
    Top Left        --> 3 choices per direction
                            North   -->Straight, Left, Right
                            South   -->Straight, Left, Right
                            East    -->Straight, Left, Right
                            West    -->Straight, Left, Right
    Top Right       --> 2 choices per direction (can't access if your going in West direction)
                            North   --> Straight, Left
                            South   -->Straight, Right
                            East    -->Left, Right
    Bottom Left     --> 3 choices per direction
                            North   -->Straight, Left, Right
                            South   -->Straight, Left, Right
                            East    -->Straight, Left, Right
                            West    -->Straight, Left, Right
    Bottom Right    --> 2 choices per direction (can't access if your going in West direction)
                            North   -->Straight, Left
                            South   -->Straight, Right
                            East    -->Left, Right
Level 4
    Top Left        --> 3 choices per direction
                            North   -->Straight, Left, Right
                            South   -->Straight, Left, Right
                            East    -->Straight, Left, Right
                            West    -->Straight, Left, Right
    Top Right       --> 3 choices per direction
                            North   -->Straight, Left, Right
                            South   -->Straight, Left, Right
                            East    -->Straight, Left, Right
                            West    -->Straight, Left, Right
    Bottom Left     --> 3 choices per direction
                            North   -->Straight, Left, Right
                            South   -->Straight, Left, Right
                            East    -->Straight, Left, Right
                            West    -->Straight, Left, Right
    Bottom Right    --> 3 choices per direction
                            North   -->Straight, Left, Right
                            South   -->Straight, Left, Right
                            East    -->Straight, Left, Right
                            West    -->Straight, Left, Right



*/
















