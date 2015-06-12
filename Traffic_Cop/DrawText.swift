//
//  DrawText.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-10.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

//label.fontColor = [SKColor colorWithRed:0.1 green:1 blue:0.1 alpha:1.0];

import SpriteKit
import UIKit

class Text
{
    let label: SKLabelNode
    
    init(pos: CGPoint, says: String, fontSize: Int , font: String, color: String, align: String)
    {
        
        switch(font)
        {
            case "font1":   label = SKLabelNode(fontNamed:"District");
            case "font2":   label = SKLabelNode(fontNamed:"launica");
            case "font3":   label = SKLabelNode(fontNamed:"Lintsec");
            case "font4":   label = SKLabelNode(fontNamed:"Operatinginstructions");
            case "font5":   label = SKLabelNode(fontNamed:"RADIOLAND");
            default:        label = SKLabelNode(fontNamed:"launica");
        }
        switch(align)
        {
            case "center"   :label.verticalAlignmentMode    = .Center
            case "left"     :label.horizontalAlignmentMode  = .Left
            case "right"    :label.horizontalAlignmentMode  = .Right
            default         :label.horizontalAlignmentMode  = .Left
        }
        switch(color)
        {
            case "blue":    label.fontColor = SKColor.blueColor()
            case "green":   label.fontColor = SKColor.greenColor()
            case "red":     label.fontColor = SKColor.redColor()
            case "yellow":  label.fontColor = SKColor.yellowColor()
            case "cyan":    label.fontColor = SKColor.cyanColor()
            case "magenta": label.fontColor = SKColor.magentaColor()
            case "gray":    label.fontColor = SKColor.grayColor()
            case "white":   label.fontColor = SKColor.whiteColor()
            case "black":   label.fontColor = SKColor.blackColor()
            case "purple":  label.fontColor = SKColor.purpleColor()
            case "brown":   label.fontColor = SKColor.brownColor()
            default:        label.fontColor = SKColor.blackColor()
        }
        label.text = says;
        label.position = pos
        label.fontSize = CGFloat(fontSize)
      
    }
    
    func get() -> SKLabelNode
    {
        return label
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder: ) has not been implemented")
    }



}

