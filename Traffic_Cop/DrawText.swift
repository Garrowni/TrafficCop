//
//  DrawText.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-10.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//


import SpriteKit
import UIKit

class Text : SKLabelNode
{
    init(pos: CGPoint, says: String, fontSize: Int , font: String, align: String)
    {
        super.init(fontNamed: Marion)
        {
            
        }
        
        
        let label = SKLabelNode(fontNamed: Marion)
        label.text = says;
        switch(font)
        {
            case "font1": label = SKLabelNode(fontNamed:Marion);
            case "font2": label = SKLabelNode(fontNamed:Marion);
            case "font3": label = SKLabelNode(fontNamed:Marion);
            default:println("")
        }
        switch(align)
        {
            case "center":label.verticalAlignmentMode = .Center
        case "left" : label
            
        }
        
        label.position = CGPoint(x: size.width / 2, y: (size.height * (CGFloat(idx+1))) / (CGFloat(fontNames.count)+1))
        label.fontSize = fontSize
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder: ) has not been implemented")
    }



}

