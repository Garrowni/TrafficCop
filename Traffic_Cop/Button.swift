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

class Button
{
    let origRect:       CGRect
    let label:          SKLabelNode
    let shape:          SKShapeNode
    var OL:             SKShapeNode
    let zoomIn:         Bool
    let zoomOut:        Bool
    let bulge:          Bool
    var zoom:           SKAction
    var zoomO:          SKAction
    let offset:         SKAction
    let bulgeAction:    SKAction
    var glowBulgeAC:    SKAction
    var fadeAway:       SKAction
    let origGlow :      Int
    var glowUp :        Bool
    var glowDown :      Bool
    var fadeOut:        Bool
    var offSetPoint:    CGPoint
    var buttonDone:     Bool
    
    
    init(pos: CGRect, roundCorner: Int, text: Text , BGcolor: String, OLcolor: String, OLSize: Int, glowWidth: Int, ZoomIn: Bool, Bulge: Bool, glowBulge: Bool)
    {
        label       = text.get()
        zoomIn      = ZoomIn
        zoomOut     = false
        bulge       = Bulge
        origGlow    = glowWidth
        glowUp      = true
        glowDown    = false
        fadeOut     = false
        fadeAway    = SKAction()
        glowBulgeAC = SKAction()
        origRect    = pos
        buttonDone  = false
        
        
        shape           = SKShapeNode()
        OL              = SKShapeNode()
        
        let path        = CGPathCreateWithRoundedRect(origRect, CGFloat(roundCorner), CGFloat(roundCorner), nil )
        let path2       = CGPathCreateWithRoundedRect(origRect, CGFloat(roundCorner), CGFloat(roundCorner), nil )
  
        
        shape.position  = CGPoint(x: origRect.maxX - origRect.width/2, y: origRect.maxY - origRect.height/2)
        OL.position     = CGPoint(x: origRect.maxX - origRect.width/2, y: origRect.maxY - origRect.height/2)
        shape.path      = path
        shape.zPosition = CGFloat(5)
        OL.zPosition    = CGFloat(6)
        label.zPosition = CGFloat(7)
        OL.path         = path2
        OL.lineWidth    = CGFloat(OLSize)
        OL.glowWidth    = CGFloat(glowWidth)
        label.position.x = origRect.minX + origRect.width/2
        label.position.y = origRect.minY + origRect.height/2
        label.xScale    = 0
        label.yScale    = 0
        shape.xScale    = 0
        shape.yScale    = 0
        OL.xScale       = 0
        OL.yScale       = 0
        offSetPoint     = CGPoint(x: 0,y: 0)
        
        
        
        
        zoom  = SKAction.scaleTo(1, duration: 0.5)
        zoomO = SKAction.scaleTo(0, duration: 0.3)
        
        offset = SKAction.moveTo(offSetPoint,  duration:0.5)
        let scaleUp = SKAction.scaleTo(CGFloat(1.1), duration: 0.5)
        let scaleDown = SKAction.scaleTo(CGFloat(0.9), duration: 0.5)
        let fullBulge = SKAction.sequence([scaleUp, scaleDown])
        bulgeAction = SKAction.repeatActionForever(fullBulge)
        
      
        let glowOn = SKAction.runBlock(){self.glowAway()}
        let wait = SKAction.waitForDuration(0.1)
        let glowSequence = SKAction.sequence([glowOn, wait])
        glowBulgeAC = SKAction.repeatActionForever(glowSequence)
        
        
        let FO = SKAction.runBlock(){self.fadeOutNow()}
        let wait2 = SKAction.waitForDuration(0.1)
        let fadeSequence = SKAction.sequence([FO, wait2])
        fadeAway = SKAction.repeatActionForever(fadeSequence)
        
        
        
        
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
        case "halfblack": shape.fillColor = SKColor.blackColor(); shape.alpha = CGFloat(0.5)
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
        
        if zoomIn {zoomIN()}
        if bulge  {BulgeOn()}
        if glowBulge {OL.runAction(glowBulgeAC)}
        
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
        offSetPoint     = CGPoint(x: origRect.maxX - origRect.width/2, y: origRect.maxY - origRect.height/2)
        let offsetFirst = SKAction.moveTo(offSetPoint, duration: 0.3)
        let offsetSec   = SKAction.runBlock(){self.buttonDone = true;}
        let offset2     = SKAction.sequence([offsetFirst,offsetSec])
        shape.runAction(zoomO)
        shape.runAction(offset2)
        OL.runAction(zoomO)
        OL.runAction(offset2)
        label.runAction(zoomO)
 
    }
    
    func glowAway()
    {
        if OL.glowWidth > (CGFloat(origGlow + 10))  {glowDown = true; glowUp = false;}
        if OL.glowWidth < (CGFloat(origGlow))       {glowDown = false; glowUp = true;}
        if glowUp   {OL.glowWidth += CGFloat(3)}
        if glowDown {OL.glowWidth -= CGFloat(3)}
        //println("GW: \(OL.glowWidth)")
    }
    
    func BulgeOn()
    {
        label.runAction(bulgeAction)
    }
    
    func FadeAway()
    {
        fadeOut = true;
        shape.runAction(fadeAway)
    }
    
    func buttonIsDone() -> Bool
    {
        return buttonDone
    }
    
    func fadeOutNow()
    {
        if (fadeOut)
        {
            if(shape.alpha > 0)
            {
                if(shape.alpha - 0.2 < 0)
                {
                    shape.alpha     = 0
                    OL.alpha        = 0
                    label.alpha     = 0
                }
                else
                {
                    shape.alpha     -= 0.2
                    OL.alpha        -= 0.2
                    label.alpha     -= 0.2
                }
            }
        }
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
    
    
}

