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
        case DRIVING, STOPPED, TURNING, WAITING, CRASHED
    }
    
    let _MAXSPEED       : CGFloat
    var _dir            : Direction = Direction.WEST
    var _turnCount      : Int = 0
    var _spawn          : CGPoint
    var _accel          : CGFloat = 3
    var _currSpeed      : CGFloat = 0
    var _impulse        : CGFloat = 0
    var _isDone         : Bool = false
    var _type           : Int
    var _textures       : [SKTexture] = []
    var _size           : CGSize
    var _state          : State = State.DRIVING
    var _isSelected     : Bool = false
    var _turned         : Bool = false
    var _stopPoint      : CGPoint = CGPoint(x: 0, y: 0)
    var _selectionColor : String = ""
    var _currPos        : CGPoint
    var _mass           : CGFloat
    var smokeEmitter    : SKEmitterNode
    var fireEmitter     : SKEmitterNode
    var fireSmokeEmitter: SKEmitterNode
    var canTurnLeft     = false //AVAILABLE CHOICES SENT FROM THE GAMESCENE AT ILLUMINATION OF ROADS
    var canTurnRight    = false
    var canGoStraight   = false
    var wantsRight      = false //RANDOM ROLL FOR THE CARS WANT
    var wantsStraight   = false
    var wantsLeft       = false
    var turningLeft     = false //CHOICE A PERSON CHOOSES AT THE TIME OF DE-LUUMINATION
    var turningRight    = false
    var goingStrait     = false
    var choiceMade      = false //IF THEY HAVE MADE A CHOICE DONT MAKE ANOTHER.
    var theParent       : SKNode
    var carInFront      : SKSpriteNode?
    
    init(type : Int , direction : SpawnPoint, Parent: SKNode)
    {
        var tempDirection   = direction.dir
        self._type          = type
        self._size          = CGSize(width: 152, height: 66)
        self._spawn         = direction.pos
        self._currPos       = _spawn
        smokeEmitter        = SKEmitterNode(fileNamed: "Exhaust.sks")
        fireEmitter         = SKEmitterNode(fileNamed: "Fire.sks")
        fireSmokeEmitter    = SKEmitterNode(fileNamed: "BlackSmoke.sks")
        smokeEmitter.name   = "Smoke-Emitter"
        fireSmokeEmitter.name = "fire-Emitter"
        fireEmitter.name    = "fire-Emitter"

        theParent           = Parent
    
        
        switch(self._type)
        {
        case 1:
            
            self._impulse = 6300
            self._MAXSPEED = 150
            self._textures.append(SKTexture(imageNamed: "Ambulence1"))
            self._textures.append(SKTexture(imageNamed: "Ambulence1L"))
            self._textures.append(SKTexture(imageNamed: "Ambulence1R"))
            self._textures.append(SKTexture(imageNamed: "Ambulence2"))
            self._textures.append(SKTexture(imageNamed: "Ambulence2L"))
            self._textures.append(SKTexture(imageNamed: "Ambulence2R"))
            self._textures.append(SKTexture(imageNamed: "Ambulence2L"))
            self._textures.append(SKTexture(imageNamed: "Ambulence2"))
            self._textures.append(SKTexture(imageNamed: "Ambulence1R"))
            self._textures.append(SKTexture(imageNamed: "Ambulence1L"))
            self._mass = 6300
           
            
        case 2:
            self._impulse = 6000
            self._MAXSPEED = 200
            self._textures.append(SKTexture(imageNamed: "car_cop1"))
            self._textures.append(SKTexture(imageNamed: "car_cop1L"))
            self._textures.append(SKTexture(imageNamed: "car_cop1R"))
            self._textures.append(SKTexture(imageNamed: "car_cop2"))
            self._textures.append(SKTexture(imageNamed: "car_cop2L"))
            self._textures.append(SKTexture(imageNamed: "car_cop2R"))
            self._textures.append(SKTexture(imageNamed: "car_cop2L"))
            self._textures.append(SKTexture(imageNamed: "car_cop1R"))
            self._textures.append(SKTexture(imageNamed: "car_cop1L"))
            self._mass = 1500
        case 3:
            self._impulse = 6000
            self._MAXSPEED = 200
            self._textures.append(SKTexture(imageNamed: "car_blue"))
            self._mass = 1500
         
        case 4:
            self._impulse = 6000
            self._MAXSPEED = 200
            self._textures.append(SKTexture(imageNamed: "car_red"))
            self._mass = 1500
         
        case 5:
            self._impulse = 6000
            self._MAXSPEED = 200
            self._textures.append(SKTexture(imageNamed: "pickup_green"))
            self._mass = 1500
           
        case 6:
            self._impulse = 4000
            self._MAXSPEED = 150
            self._textures.append(SKTexture(imageNamed: "truck"))
           
            self._mass = 4000
            
            
        default :
            
            self._MAXSPEED = 0
            self._textures.append(SKTexture(imageNamed: "Ambulence1"))
            self._mass = 0
        }
        
        super.init(texture: self._textures[0], color: nil, size: self._size)
        
        self.position = self._currPos
        self.addChild(smokeEmitter)
        
        if (type == 6) {self.runAction(SKAction.colorizeWithColor(randCarColour(), colorBlendFactor: CGFloat(1.0), duration: 0))
}
        
        let physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        physicsBody.usesPreciseCollisionDetection = true
        physicsBody.allowsRotation = true
        physicsBody.restitution = 0.8
        physicsBody.friction = 0.2
        physicsBody.linearDamping = 0.3
        physicsBody.mass  = self._mass
        physicsBody.categoryBitMask = PhysicsCategory.Car
        physicsBody.contactTestBitMask = PhysicsCategory.All
        physicsBody.collisionBitMask = PhysicsCategory.Car | PhysicsCategory.Person
        physicsBody.affectedByGravity = false
        physicsBody.angularDamping = 0.5

        
        
        smokeEmitter.position.x += 85
        fireSmokeEmitter.position.x -= 70
        fireEmitter.position.x -= 70
        
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(self._textures, timePerFrame: 0.1)))
        //position the car in the middle of the road
        switch(tempDirection)
        {
        case 0:
            self._dir = Direction.NORTH
            self._spawn.x = direction.pos.x - self._size.width/2
            self._spawn.y = direction.pos.y - self._size.height
            self.zRotation = CGFloat(M_PI_2 * 3)
            self.position.y -= size.height
            self._stopPoint = CGPoint(x: self.position.x, y: self.position.y + size.height/2 + 20)
        case 1:
            self._dir = Direction.WEST
            self._spawn.x = direction.pos.x + self._size.width
            self._spawn.y = direction.pos.y - self._size.height/2
            self.zRotation = 0
            self.position.x += size.height
            self._stopPoint = CGPoint(x: self.position.x - size.height/2 - 20 , y: self.position.y)
        case 2:
            self._dir = Direction.EAST
            self._spawn.x = direction.pos.x - self._size.width
            self._spawn.y = direction.pos.y - self._size.height/2
            self.zRotation = CGFloat(M_PI_2 * 2)
            self.position.x -= size.height
            self._stopPoint = CGPoint(x: self.position.x + size.height/2 + 20, y: self.position.y)
        case 3:
            self._dir = Direction.SOUTH
            self._spawn.x = direction.pos.x - self._size.width/2
            self._spawn.y = direction.pos.y + self._size.height
            self.zRotation = CGFloat(M_PI_2)
            self.position.y += size.height
            self._stopPoint = CGPoint(x: self.position.x, y: self.position.y - size.height/2 - 20)
        default:
            self._dir = Direction.WEST
            self._spawn.x = direction.pos.x + self._size.height
            self._spawn.y = direction.pos.y - self._size.width/2
            self.zRotation = 0
        }

        smokeEmitter.particleTexture!.filteringMode = .Nearest
        smokeEmitter.targetNode         = theParent
        fireSmokeEmitter.particleTexture!.filteringMode = .Nearest
        fireSmokeEmitter.targetNode     = theParent
        fireEmitter.particleTexture!.filteringMode = .Nearest
        fireEmitter.targetNode          = theParent
        self.physicsBody = physicsBody
    }
    required init?(coder aDecoder: NSCoder) {
        smokeEmitter        =  aDecoder.decodeObjectForKey("Smoke-Emitter") as! SKEmitterNode
        fireSmokeEmitter    =  aDecoder.decodeObjectForKey("fire-Emitter") as! SKEmitterNode
        fireEmitter         =  aDecoder.decodeObjectForKey("fire-Emitter") as! SKEmitterNode
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(smokeEmitter, forKey: "Smoke-Emitter")
        aCoder.encodeObject(fireSmokeEmitter, forKey: "fire-Emitter")
        aCoder.encodeObject(fireEmitter, forKey: "fire-Emitter")
    }
    

//***************************Functions*************************
    
    
    func update()
    {
        
    //println("velocity dx: \(physicsBody!.velocity.dx), dy: \(physicsBody!.velocity.dy)")
        if(self._state != State.CRASHED)
        {
        switch(self._dir)
        {
        case .NORTH:
            self._stopPoint = CGPoint(x: self.position.x, y: self.position.y + size.height/2 + 100)
        case .EAST:
            self._stopPoint = CGPoint(x: self.position.x + size.height/2 + 100, y: self.position.y)
        case .WEST:
            self._stopPoint = CGPoint(x: self.position.x - size.height/2 - 100, y: self.position.y)
        case .SOUTH:
            self._stopPoint = CGPoint(x: self.position.x, y: self.position.y - size.height/2 - 100)
        default:
            self._stopPoint = CGPoint(x: self.position.x, y: self.position.y)
            
        }
        
        self._currPos = self.position
        if(self._state == .DRIVING)
        {
            self.drive()
        }
        self.position = _currPos
        }
      
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
         self.drive()
         
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
         self.drive()
        
    }
    func wait()
    {
        if(self._state != .CRASHED)
        {
        self._currSpeed = 0
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self._state = .WAITING
        }
    }
    func drive()
    {
        if(self._state != State.CRASHED)
        {
            self._state = State.DRIVING
         
            if (self._currSpeed < self._MAXSPEED)
            {
                self._currSpeed += self._accel
            }
            
            switch(self._dir)
            {
            case .NORTH:

                    //self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: self._impulse))
                    self.physicsBody!.velocity.dy = self._currSpeed
            case .SOUTH:
                    //self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -self._impulse))
                self.physicsBody!.velocity.dy = -self._currSpeed
            case .WEST:

                    //self.physicsBody?.applyImpulse(CGVector(dx: -self._impulse, dy: 0))
               self.physicsBody!.velocity.dx = -self._currSpeed
            case .EAST:

                    //self.physicsBody?.applyImpulse(CGVector(dx: self._impulse, dy: 0))
                self.physicsBody!.velocity.dx = self._currSpeed
            default:
                println("No direction")
            }
        }
    }
    
    func goStraight()
    {
        if(self._state != State.CRASHED)
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
            

            if (self._currSpeed < self._MAXSPEED)
            {
                self._currSpeed += self._accel
            }
            
            switch(self._dir)
            {
            case .NORTH:
                
                //self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: self._impulse))
                self.physicsBody!.velocity.dy = self._currSpeed
            case .SOUTH:
                //self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -self._impulse))
                self.physicsBody!.velocity.dy = -self._currSpeed
            case .WEST:
                
                //self.physicsBody?.applyImpulse(CGVector(dx: -self._impulse, dy: 0))
                self.physicsBody!.velocity.dx = -self._currSpeed
            case .EAST:
                
                //self.physicsBody?.applyImpulse(CGVector(dx: self._impulse, dy: 0))
                self.physicsBody!.velocity.dx = self._currSpeed
                
            default:
                println("No direction")
            }
            
        }
    }
    
    func stop()
    {
        if(self._state != State.CRASHED)
        {
        self._currSpeed = 0
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self._state = .STOPPED
        }
    }
    
    
    func isDone(rect : CGRect) -> Bool
    {
        if(self._dir == .NORTH && self.position.y - 700 > rect.maxY)
        {
            return true
        }
        else if(self._dir == .SOUTH && self.position.y + 700 < rect.minY)
        {
            return true
        }
        else if(self._dir == .WEST && self.position.x + 700 < rect.minX)
        {
            return true
        }
        else if(self._dir == .EAST && self.position.x - 700 > rect.maxX)
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
            if(rand == 1){wantsLeft     = true}
            if(rand == 2){wantsRight    = true}
        }
        if(canGoStraight && canTurnLeft && !canTurnRight)
        {
            if(rand == 1){wantsStraight = true}
            if(rand == 2){wantsLeft     = true}
        }
        if(canGoStraight && canTurnRight && !canTurnLeft)
        {
            if(rand == 1){wantsStraight = true}
            if(rand == 2){wantsRight    = true}
        }
        if(canGoStraight && canTurnRight && canTurnLeft)
        {
            if(rand == 1){wantsStraight = true}
            if(rand == 2){wantsRight    = true}
            if(rand == 3){wantsLeft     = true}
        }
        choiceMade = true
        println("CHOICE MADE --> Straight:\(wantsStraight) Right: \(wantsRight)  Left: \(wantsLeft)")
    }
    
    func crashed()
    {
        
        if(self._state.hashValue != 4)
        {
           
            var hasFire = false
            for child in children
            {
                if (child.name == "fire-Emitter") {hasFire = true}
                if (child.name == "Smoke-Emitter") {smokeEmitter.removeFromParent()}
            }
            if(!hasFire)
            {
                addChild(fireSmokeEmitter)
                var rand = Int.randomNumberFrom(1...10)
                if (rand > 6) {addChild(fireEmitter)}
                fireSmokeEmitter.particleZPosition = 3
                fireEmitter.particleZPosition = 4
             
            }
        }

        
        
        self._state = .CRASHED
        //println("CRASH!")
    }
    
    
}












