//
//  DrawText.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-10.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//


import SpriteKit
import UIKit

class Text : SKNode
{
    let label: SKLabelNode(fontNamed:"Marion")
    
    init(pos: CGPoint, says: String, fontSize: Int , font: String, color: String, align: String)
    {
        self.label.text = says;
        switch(font)
        {
            case "font1": label = SKLabelNode(fontNamed:"Marion");
            case "font2": label = SKLabelNode(fontNamed:"Marion");
            case "font3": label = SKLabelNode(fontNamed:"Marion");
            default:println("")
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
            case "blue":    label.color = UIColor.blueColor()
            case "green":   label.color = UIColor.greenColor()
            case "red":     label.color = UIColor.redColor()
            case "yellow":  label.color = UIColor.yellowColor()
            case "cyan":    label.color = UIColor.cyanColor()
            case "magenta": label.color = UIColor.magentaColor()
            case "gray":    label.color = UIColor.grayColor()
            case "white":   label.color = UIColor.whiteColor()
            case "black":   label.color = UIColor.blackColor()
            case "purple":  label.color = UIColor.purpleColor()
            case "brown":   label.color = UIColor.brownColor()
            default:        label.color = UIColor.blackColor()
        }
        self.label.position = pos
        self.label.fontSize = CGFloat(fontSize)
        addChild(self.label)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder: ) has not been implemented")
    }



}

