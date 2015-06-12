//
//  MyUtils.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-08.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import CoreGraphics


//OPERATOR OVERLOADS

func + (left:CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += (inout left: CGPoint, right: CGPoint)
{
    left = left + right
}

func -= (inout left: CGPoint, right: CGPoint)
{
    left = left - right
}

func *= (inout left: CGPoint, right: CGPoint)
{
    left = left * right
}

func *= (inout point: CGPoint, scalar: CGFloat)
{
    point = point * scalar
}

func - (left:CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (left:CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func * (point:CGPoint, scalar: CGFloat) -> CGPoint
{
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (left:CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

func / (point:CGPoint, scalar: CGFloat) -> CGPoint
{
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

func /= (inout left: CGPoint, right: CGPoint)
{
    left = left / right
}

func /= (inout point: CGPoint, scalar: CGFloat)
{
    point = point / scalar
}

func > (left : CGPoint, right : CGPoint) -> Bool
{
    if( left.x > right.x && left.y > right.y )
    {
        return true
    }
    else
    {
        return false
    }
}

func < (left : CGPoint, right : CGPoint) -> Bool
{
    if( left.x < right.x && left.y < right.y)
    {
        return true
    }
    else
    {
        return false
    }
}

func == (left : CGPoint, right : CGPoint) -> Bool
{
    if( left.x == right.x && left.y == right.y)
    {
        return true
    }
    else
    {
        return false
    }
}


//CLASS EXTENTIONS
#if !(arch(x86_64) || arch(arm64))
    
    func atan2(y: CGFloat, x: CGFloat) -> CGFloat
    {
    return CGFloat(atan2f(Float(y), Float(x)))
    }
    
    func sqrt(a: CGFloat) -> CGFloat
    {
    return CGFloat(sqrtf(Float(a)))
    }
    
#endif


extension CGPoint
{
    func length() -> CGFloat
    {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint
    {
        return self / length()
    }
    
    var angle : CGFloat
        {
            return atan2(y,x)
    }
}


let pie: CGFloat = CGFloat(M_PI)

func shortestAngleBetween(angle1: CGFloat, angle2: CGFloat) -> CGFloat
{
    let twoPie = pie * 2.0
    var angle: CGFloat = (angle2 - angle1) % twoPie
    if(angle >= pie)
    {
        angle = angle - twoPie
    }
    if(angle <= -pie)
    {
        angle = angle + twoPie
    }
    return angle
}

extension CGFloat{
    func sign() -> CGFloat {
        return (self >= 0.0) ? 1.0 : -1.0 //Return 1 if greater then 0 else return -1
    }
}


extension CGFloat
{
    static func random() -> CGFloat {
        return CGFloat((Float(arc4random()))/(Float(UInt32.max)))      //RANDOM BETWEEN 0-1
    }
    
    static func random(#min: CGFloat, max: CGFloat) -> CGFloat         //RANDOM BETWEEN Min-Max
    {
        assert(min < max)
        return CGFloat.random() * (max - min) +  min
    }
}

//GET DIRECTION from pos1 -> pos2
func getDirection(pos1: CGPoint, pos2: CGPoint) -> CGPoint
{
    let offset = pos2 - pos1
    let direction = offset.normalized()
    return offset
}


// Generate a single random number
//let n = randomNumberFrom(1...10)
// Int.randomNumberFrom(1...1000)
extension Int
{
    static func randomNumberFrom(from: Range<Int>) -> Int
    {
        return from.startIndex + Int(arc4random_uniform(UInt32(from.endIndex - from.startIndex)))
    }
}



//STRING EXTENSION FOR MULTI LINE STRINGS
extension String {
    init(sep:String, _ lines:String...){
        self = ""
        for (idx, item) in enumerate(lines) {
            self += "\(item)"
            if idx < lines.count-1 {
                self += sep
            }
        }
    }
    
    init(_ lines:String...){
        self = ""
        for (idx, item) in enumerate(lines) {
            self += "\(item)"
            if idx < lines.count-1 {
                self += "\n"
            }
        }
    }
}
//USE IT LIKE THIS
//println(
//    String(
//        "Hello",
//        "World!"
//    )
//)
//"Hello
//World!"
//
//println(
//String(sep:", ",
//"Hello",
//"World!"
//)
//)
//"Hello, World!"








//MUSIC
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String)
{
    let url = NSBundle.mainBundle().URLForResource(
        filename, withExtension: nil)
    if (url == nil) {
        println("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    backgroundMusicPlayer =
        AVAudioPlayer(contentsOfURL: url, error: &error)
    if backgroundMusicPlayer == nil {
        println("Could not create audio player: \(error!)")
        return
    }
    
    backgroundMusicPlayer.numberOfLoops = -1
    backgroundMusicPlayer.prepareToPlay()
    backgroundMusicPlayer.play()
}