/*
* Copyright (c) 2013-2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/
//stuff

import Foundation
import GameKit

class AchievementsHelper {
  
  struct Constants
  {
    static let MaxCollisions = 200
    static let MaxLevelsCompleted = 50
    static let MaxPeopleHit = 300
    static let MaxPlayTime = 3600
    //Play 1 Hour
    static let DailyDriverId = "DailyDriver"
    //3000+ Skid
    static let AnyTreadLeftId = "AnyTreadLeft"
    //200 Crashes
    static let BentMetalId = "BentMetal"
    //Beat 50 Levels
    static let CompletionistId = "Completionist"
    //3000+ NS
    static let HeadOnCollisionId = "HeadOnCollision"
    //300 people hit
    static let VehicularManSlaughterId = "VehicularManslaughter"
    }
  
  class func bentMetalAchievement(noOfCollisions: Int) -> GKAchievement
  {
    //1
    let percent = (noOfCollisions/Constants.MaxCollisions) * 100
    
    //2
    let collisionAchievement =
    GKAchievement(identifier:
      Constants.BentMetalId)
    
    //3
    collisionAchievement.percentComplete = Double(percent)
    collisionAchievement.showsCompletionBanner = true
    return collisionAchievement
  }
  
    class func completionistAchievement(noOfLevelsBeaten : Int) -> GKAchievement
    {
    let percent = (noOfLevelsBeaten/Constants.MaxLevelsCompleted) * 100
        
    let levelAchievement =
        GKAchievement(identifier:
            Constants.BentMetalId)

    
    levelAchievement.percentComplete = Double(percent)
    levelAchievement.showsCompletionBanner = true
    return levelAchievement
  }
    
    class func vehicularManslaughterAchievement(noOfPeoplehit : Int) -> GKAchievement
    {
        let percent = (noOfPeoplehit / Constants.MaxPeopleHit) * 100
        
        let peopleHitAchievement =
            GKAchievement(identifier: Constants.VehicularManSlaughterId)
        
        peopleHitAchievement.percentComplete = Double(percent)
        peopleHitAchievement.showsCompletionBanner = true
        return peopleHitAchievement
    }

        
    class func dailyDriverachievement(TotalTimePlayed : Int) -> GKAchievement
    {
            
                let percent = (TotalTimePlayed / Constants.MaxPlayTime) * 100
                
                let dailyDriverAchievement =
                GKAchievement(identifier: Constants.DailyDriverId)
                
                dailyDriverAchievement.percentComplete = Double(percent)
                dailyDriverAchievement.showsCompletionBanner = true
                return dailyDriverAchievement
    }
    
    class func anyTreadLeftAchievement() -> GKAchievement
    {
        let skidAchievement = GKAchievement(identifier: Constants.AnyTreadLeftId)
        
        
        skidAchievement.percentComplete = 100
        
        skidAchievement.showsCompletionBanner = true
        return skidAchievement
    }
    
    class func headOnCollisionAchievement() -> GKAchievement
    {
        let headOnAchievement = GKAchievement(identifier: Constants.HeadOnCollisionId)
                
        headOnAchievement.percentComplete = 100
        
        headOnAchievement.showsCompletionBanner = true
        return headOnAchievement
    }



}