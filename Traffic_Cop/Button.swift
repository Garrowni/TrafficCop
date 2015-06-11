//
//  Button.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-11.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class RectButton
{
    let label:  SKLabelNode
    let shape:  SKShapeNode
    let OL:     SKShapeNode
    let zoomIn: Bool
    let zoomOut: Bool
    let zoom: SKAction
    let offset: SKAction
    
    
    init(pos: CGRect, roundCorner: Int, text: Text , BGcolor: String, OLcolor: String, OLSize: Int, glowWidth: Int)
    {
        label = text.get()
        zoomIn = true
        zoomOut = false
        
        shape           = SKShapeNode()
        OL              = SKShapeNode()
        
        let path        = CGPathCreateWithRoundedRect(pos, CGFloat(roundCorner), CGFloat(roundCorner), nil )
        let path2       = CGPathCreateWithRoundedRect(pos, CGFloat(roundCorner), CGFloat(roundCorner), nil )
  
        

        shape.position  = CGPoint(x: pos.maxX - pos.width/2, y: pos.maxY - pos.height/2)
        OL.position  = CGPoint(x: pos.maxX - pos.width/2, y: pos.maxY - pos.height/2)
        shape.path      = path
        shape.zPosition = CGFloat(5)
        OL.zPosition    = CGFloat(6)
        label.zPosition = CGFloat(7)
        OL.path         = path2
        OL.lineWidth    = CGFloat(OLSize)
        OL.glowWidth    = CGFloat(glowWidth)
        label.position.x = pos.minX + pos.width/2
        label.position.y = pos.minY + pos.height/2
        label.xScale = 0
        label.yScale = 0
        shape.xScale = 0
        shape.yScale = 0
        OL.xScale = 0
        OL.yScale = 0
        
        
        
        zoom = SKAction.scaleTo(1, duration: 4)
        offset = SKAction.moveTo(CGPoint(x: 0 , y: 0),  duration:4)
      
        
        
        
        
        
        switch(BGcolor)
        {
        case "blue":    shape.fillColor = SKColor.blueColor()
        case "green":   shape.fillColor = SKColor.greenColor()
        case "red":     shape.fillColor = SKColor.redColor()
        case "yellow":  shape.fillColor = SKColor.yellowColor()
        case "cyan":    shape.fillColor = SKColor.cyanColor()
        case "magenta": shape.fillColor = SKColor.magentaColor()
        case "gray":    shape.fillColor = SKColor.grayColor()
        case "white":   shape.fillColor = SKColor.whiteColor()
        case "black":   shape.fillColor = SKColor.blackColor()
        case "purple":  shape.fillColor = SKColor.purpleColor()
        case "brown":   shape.fillColor = SKColor.brownColor()
        default:        shape.fillColor = SKColor.blackColor()
        }

        switch(OLcolor)
        {
        case "blue":    OL.strokeColor = SKColor.blueColor()
        case "green":   OL.strokeColor = SKColor.greenColor()
        case "red":     OL.strokeColor = SKColor.redColor()
        case "yellow":  OL.strokeColor = SKColor.yellowColor()
        case "cyan":    OL.strokeColor = SKColor.cyanColor()
        case "magenta": OL.strokeColor = SKColor.magentaColor()
        case "gray":    OL.strokeColor = SKColor.grayColor()
        case "white":   OL.strokeColor = SKColor.whiteColor()
        case "black":   OL.strokeColor = SKColor.blackColor()
        case "purple":  OL.strokeColor = SKColor.purpleColor()
        case "brown":   OL.strokeColor = SKColor.brownColor()
        default:        OL.strokeColor = SKColor.blackColor()
        }
        
      zoomIN()
        
    }
    
    func zoomIN()
    {
        shape.runAction(offset)
        shape.runAction(zoom)
        OL.runAction(zoom)
        OL.runAction(offset)
        label.runAction(zoom)
    }
    
    func zoomOUT()
    {
        shape.runAction(zoom.reversedAction())
        OL.runAction(zoom.reversedAction())
        label.runAction(zoom.reversedAction())
    }
    
    func buttonClicked()
    {
        zoomOUT()
    }
    
    func getLabel() -> SKLabelNode
    {
        return label
    }
    func getButtBG() -> SKShapeNode
    {
        return shape
    }
    func getButtOL() -> SKShapeNode
    {
        return OL
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder: ) has not been implemented")
    }
    
    
    
}
