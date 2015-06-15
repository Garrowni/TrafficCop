//
//  GlowCircle.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-15.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit

class GlowCircle
{
    var OL:             SKShapeNode
    var zoomIn:         Bool
    var zoomOut:        Bool
    var zoom:           SKAction
    var zoomO:          SKAction
    var offset:         SKAction
    var bulgeAction:    SKAction
    var glowBulgeAC:    SKAction
    var fadeAway:       SKAction
    var origGlow :      Int
    var glowUp :        Bool
    var glowDown :      Bool
    var fadeOut:        Bool
    var offSetPoint:    CGPoint
    var buttonDone:     Bool
    var Alpha:          CGFloat

    
    
    init(pos: CGPoint, radius: Int, OLcolor: String, OLSize: Int, glowWidth: Int, ZoomIn: Bool, glowBulge: Bool, alpha: CGFloat)
    {
        zoomIn      = ZoomIn
        zoomOut     = false
        origGlow    = glowWidth
        glowUp      = true
        glowDown    = false
        fadeOut     = false
        fadeAway    = SKAction()
        glowBulgeAC = SKAction()
        buttonDone  = false
        Alpha       = alpha
 
        
        OL              = SKShapeNode()
        
     
        
        let path2  =  CGPathCreateWithEllipseInRect(CGRect(x: pos.x-CGFloat(radius), y: pos.y-CGFloat(radius), width: CGFloat(radius)*2, height: CGFloat(radius)*2), nil)
        

        OL.position     = pos
        OL.path         = path2
        
        OL.zPosition    = CGFloat(6)
        OL.lineWidth    = CGFloat(OLSize)
        OL.glowWidth    = CGFloat(glowWidth)
        OL.xScale       = 0
        OL.yScale       = 0
        OL.alpha        = Alpha
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
        if glowBulge {OL.runAction(glowBulgeAC)}
        
    }
    
    func zoomIN()
    {
        OL.runAction(zoom)
        OL.runAction(offset)
    }
    
    func zoomOUT()
    {
        let offsetFirst = SKAction.moveTo(offSetPoint, duration: 0.3)
        let offsetSec   = SKAction.runBlock(){self.buttonDone = true;}
        let offset2     = SKAction.sequence([offsetFirst,offsetSec])
        OL.runAction(zoomO)
        OL.runAction(offset2)
    }
    
    func glowAway()
    {
        if OL.glowWidth > (CGFloat(origGlow + 10))  {glowDown = true; glowUp = false;}
        if OL.glowWidth < (CGFloat(origGlow))       {glowDown = false; glowUp = true;}
        if glowUp   {OL.glowWidth += CGFloat(3)}
        if glowDown {OL.glowWidth -= CGFloat(3)}
        //println("GW: \(OL.glowWidth)")
    }
    
    
    func FadeAway()
    {
        fadeOut = true;
        OL.runAction(fadeAway)
    }
    
    func buttonIsDone() -> Bool
    {
        return buttonDone
    }
    
    func fadeOutNow()
    {
        if (fadeOut)
        {
            if(OL.alpha > 0)
            {
                if(OL.alpha - 0.2 < 0)
                {
                    OL.alpha        = 0
                }
                else
                {
                    OL.alpha        -= 0.2
                }
            }
        }
    }
    
    
    func getOL() -> SKShapeNode
    {
        return OL
    }
    
}