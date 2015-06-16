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
    var countOrigin     : Int
    var countDownFrom   : Int
    var countDownDone   : Bool
    
    init(playableR: CGRect, countFrom: Int)
    {
        time          = "10:00"
        countOrigin   = countFrom
        countDownFrom = countFrom
        countDownDone = false
        
        clockLabel  = Text(pos: CGPoint(x: 0, y: 0),    says: time,  fontSize: 250, font: "font4", color: "green", align: "center")
        clockR      = CGRect(x: playableR.maxX/2-350, y: playableR.maxY-200, width: 700, height: 200)
        clockButt   = Button(pos: clockR, roundCorner: 100, text: clockLabel, BGcolor: "black", OLcolor: "red", OLSize: 5, glowWidth: 5, ZoomIn: true, Bulge: true, glowBulge: true)
    }
    
    func changeText(time: String)
    {
        clockLabel.get().text = time
    }
    
    func upDateTime(inc: Int)
    {
        countDownFrom += inc
        if(countDownFrom <= 0)
        {
            countDownFrom = 0
            countDownDone = true;
        }
        
        var string : String  = ""
        var minutes     = countDownFrom/60
        var secsLeft    = countDownFrom - (minutes*60)
        var strSecs     = String(secsLeft)
        var strMin      = String(minutes)
        string += strMin
        string += ":"
        string += strSecs
        clockLabel.get().text = string
    }
    
    func restart()
    {
        countDownFrom = countOrigin
        countDownDone = false
    }
    
}