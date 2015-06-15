//
//  GlowBox.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-15.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit

class GlowBox
{
    let origRect:       CGRect
    var OL:             SKShapeNode
    let zoomIn:         Bool
    let zoomOut:        Bool
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
    
    
    init(pos: CGRect, roundCorner: Int, OLcolor: String, OLSize: Int, glowWidth: Int, ZoomIn: Bool, glowBulge: Bool)
    {
        zoomIn      = ZoomIn
        zoomOut     = false
        origGlow    = glowWidth
        glowUp      = true
        glowDown    = false
        fadeOut     = false
        fadeAway    = SKAction()
        glowBulgeAC = SKAction()
        origRect    = pos
        buttonDone  = false
        
        OL              = SKShapeNode()
        
        let path2       = CGPathCreateWithRoundedRect(origRect, CGFloat(roundCorner), CGFloat(roundCorner), nil )
        
        OL.position     = CGPoint(x: origRect.maxX - origRect.width/2, y: origRect.maxY - origRect.height/2)
        OL.path         = path2
        OL.zPosition    = CGFloat(6)
        OL.lineWidth    = CGFloat(OLSize)
        OL.glowWidth    = CGFloat(glowWidth)
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
        offSetPoint     = CGPoint(x: origRect.maxX - origRect.width/2, y: origRect.maxY - origRect.height/2)
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