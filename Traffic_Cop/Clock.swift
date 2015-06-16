//
//  Clock.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-15.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//
//
import Foundation
import SpriteKit


class Clock
{
    var time            : String
    let clockLabel      : Text
    let clockButt       : Button
    let clockR          : CGRect
    
    
    init(playableR: CGRect)
    {
        time = "10:00"
        
        
        clockLabel  = Text(pos: CGPoint(x: 0, y: 0),    says: time,  fontSize: 250, font: "font4", color: "green", align: "center")
        clockR      = CGRect(x: playableR.maxX/2-350, y: playableR.maxY-200, width: 700, height: 200)
        clockButt   = Button(pos: clockR, roundCorner: 100, text: clockLabel, BGcolor: "blue", OLcolor: "red", OLSize: 10, glowWidth: 20, ZoomIn: true, Bulge: false, glowBulge: true)
        
    }
    
    
    func changeText(time: String)
    {
        
    }
    
    
}