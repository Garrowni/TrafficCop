//
//  pointsPopUp.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-18.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit


class PointsPopUp : SKNode
{
    let points          : Int
    var text            : Text
    var zoom            : SKAction
    var zoomO           : SKAction
    var move            : SKAction
    var done            : Bool
    var addPoints       : Bool
    var sparkEmitter    : SKEmitterNode
    var theParent       : SKNode
    

    
    init(Pos : CGPoint, Points: Int, goto: CGPoint, Parent: SKNode)
    {
        
        sparkEmitter = SKEmitterNode(fileNamed: "PointSparks.sks")
        points = Points
        done = false
        addPoints = false
        if(Points > 0)  {text = Text(pos: Pos, says: String(points), fontSize: 100, font: "font3", color: "green",  align: "center")}else
                        {text = Text(pos: Pos, says: String(points), fontSize: 100, font: "font3", color: "red",  align: "center")}
        move = SKAction.moveTo(goto, duration: 1)
        zoom = SKAction.scaleTo(CGFloat(1.0), duration: 0.6)
        zoomO = SKAction.scaleTo(CGFloat(0.0), duration: 0.3)
        sparkEmitter.position = Pos
        theParent = Parent
        super.init()
        start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        sparkEmitter =  aDecoder.decodeObjectForKey("Point-Emitter") as! SKEmitterNode
        points = 0
        addPoints = false
        text = Text(pos: CGPoint(x:0,y:0), says: String(points), fontSize: 100, font: "font3", color: "green",  align: "center")
        zoom = SKAction.scaleTo(CGFloat(1.0), duration: 0.6)
        move = SKAction.moveTo(CGPoint(x:0,y:0), duration: 1)
        zoomO = SKAction.scaleTo(CGFloat(0.0), duration: 0.3)
        sparkEmitter.position = CGPoint(x:0,y:0)
        text.get().xScale = CGFloat(0.0)
        text.get().yScale = CGFloat(0.0)
        theParent = SKNode()
        done = false
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeObject(sparkEmitter, forKey: "Point-Emitter")
    }
    
    func start()
    {
        var scale2 = SKAction.fadeInWithDuration(0.6)
        var scale3 = SKAction.scaleTo(CGFloat(0.0), duration: 0.3)
        var wait = SKAction.waitForDuration(2)
        var addPoints = SKAction.runBlock(){self.addPoints = true}
        var block = SKAction.runBlock(){self.done = true}
        var sequence = SKAction.sequence([zoom,move,zoomO,addPoints,wait,block])
        var sequence2 = SKAction.sequence([scale2,move,scale3])
       
        sparkEmitter.particleTexture!.filteringMode = .Nearest
        sparkEmitter.targetNode = theParent
        sparkEmitter.runAction(sequence2)
        text.get().runAction(sequence)
    }
    
    func getAddPoints() -> Bool
    {
        if(!addPoints){return false}
        else{addPoints = false; return true;}
    }

    
}