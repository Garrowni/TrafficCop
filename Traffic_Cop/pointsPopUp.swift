//
//  pointsPopUp.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-18.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit


class PointsPopUp
{
    var points          : Int
    var text            : Text
    var zoom            : SKAction
    var zoomO           : SKAction
    var move            : SKAction
    //var block         : SKAction
    //var sequence      : SKAction
    var done            : Bool
    
    init(Pos : CGPoint, Points: Int, goto: CGPoint)
    {
        points = Points
        done = false
        text = Text(pos: Pos, says: String(points), fontSize: 70, font: "font2", color: "green",  align: "center")
        zoom = SKAction.scaleTo(CGFloat(1.0), duration: 0.5)
        move = SKAction.moveTo(goto, duration: 2)
        zoomO = SKAction.scaleTo(CGFloat(0.0), duration: 0.5)

        start()
    }
    
    func start()
    {
        var block = SKAction.runBlock(){self.done = true}
        var sequence = SKAction.sequence([zoom,move,zoomO,block])
        text.get().runAction(sequence)
    }

    
}