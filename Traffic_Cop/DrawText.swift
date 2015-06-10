//
//  DrawText.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-10.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import UIKit
import SpriteKit

class Text : SKLabelNode
{
    var says: String = ""
    var fontSize : Int = 0
    var align : String = ""
    
    
    init(says: String, fontSize: Int , font: String, align: String)
    {
        

        let label = SKLabelNode(fontNamed: Marion)
        
//        switch(font)
//        {
//            case "font1":label = SKLabelNode(fontNamed:Marion)
//                label.text = says
//                label.position = CGPoint(x: size.width / 2, y: (size.height * (CGFloat(idx+1))) / (CGFloat(fontNames.count)+1))
//                label.fontSize = fontSize
//                switch(align)
//                {
//                    case "center":label.verticalAlignmentMode = .Center
//                }
//            
//            
//                addChild(label)
//            
//            
//            
//            
//            
//            default:println("")
//        }
//
       
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder: ) has not been implemented")
    }



}

