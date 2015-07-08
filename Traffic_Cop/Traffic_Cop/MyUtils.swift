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
    func lengthBetween(a: CGPoint, b: CGPoint) ->CGFloat
    {
        var x = pow((a.x-b.x), CGFloat(2.0))
        var y = pow((a.y-b.y), CGFloat(2.0))
        return sqrt(x + y)
    }
    
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


//FLOAT EXTENTIONS

extension CGFloat
{
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)   //RANDOM BETWEEN 0-1
    }
    
    static func random(#min: CGFloat, max: CGFloat) -> CGFloat         //RANDOM BETWEEN Min-Max
    {
        assert(min < max)
        return CGFloat.random() * (max - min) +  min
    }
    /**
    * Converts an angle in degrees to radians.
    */
    public func degreesToRadians() -> CGFloat {
        return pie * self / 180.0
    }
    
    /**
    * Converts an angle in radians to degrees.
    */
    public func radiansToDegrees() -> CGFloat {
        return self * 180.0 / pie
    }
    
    /**
    * Ensures that the float value stays between the given values, inclusive.
    */
    public func clamped(v1: CGFloat, _ v2: CGFloat) -> CGFloat {
        let min = v1 < v2 ? v1 : v2
        let max = v1 > v2 ? v1 : v2
        return self < min ? min : (self > max ? max : self)
    }
    
    /**
    * Ensures that the float value stays between the given values, inclusive.
    */
    public mutating func clamp(v1: CGFloat, _ v2: CGFloat) -> CGFloat {
        self = clamped(v1, v2)
        return self
    }

    
    /**
    * Randomly returns either 1.0 or -1.0.
    */
    public static func randomSign() -> CGFloat {
        return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
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





//CUSTOM COLORS
public func SKColorWithRGB(r: Int, g: Int, b: Int) -> SKColor
{
    return SKColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
}

public func SKColorWithRGBA(r: Int, g: Int, b: Int, a: Int) -> SKColor
{
    return SKColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a)/255.0)
}

//RANDOM CAR COLOR--(ALL POPULAR CAR COLOURS ON REAL VEHICLES)
public func randCarColour() ->SKColor
{
    var randNum = Int.randomNumberFrom(1...19)
    switch(randNum)
    {
        case 1 :  return SKColorWithRGB(252, 229, 23)   //yellow
        case 2 :  return SKColorWithRGB(247, 110, 47)   //orange
        case 3 :  return SKColorWithRGB(230, 53, 53)    //red
        case 4 :  return SKColorWithRGB(199, 44, 52)    //darker red
        case 5 :  return SKColorWithRGB(240, 120, 168)  //pink
        case 6 :  return SKColorWithRGB(217, 48, 110)   //fucia
        case 7 :  return SKColorWithRGB(105, 68, 150)   //purple
        case 8 :  return SKColorWithRGB(127, 199, 86)   //light green
        case 9 :  return SKColorWithRGB(0, 181, 94)     //mint green
        case 10 : return SKColorWithRGB(0, 97, 66)      //darker green
        case 11 : return SKColorWithRGB(0, 160, 209)    //cloud blue
        case 12 : return SKColorWithRGB(50, 69, 128)    //saphire blue
        case 13 : return SKColorWithRGB(47, 54, 105)    //navy blue
        case 14 : return SKColorWithRGB(87, 94, 92)     //grey
        case 15 : return SKColorWithRGB(163, 145, 103)  //sandy
        case 16 : return SKColorWithRGB(79, 52, 31)     //brown
        case 17 : return UIColor.whiteColor()
        case 18 : return UIColor.cyanColor()
        case 19 : return UIColor.magentaColor()

        default:  return SKColorWithRGB(79, 52, 31)     //brown
    }
}






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
    if(!Sound()){ backgroundMusicPlayer.pause()}
}
