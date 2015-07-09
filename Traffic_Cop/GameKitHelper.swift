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

import GameKit
import Foundation

let PresentAuthenticationViewController = "PresentAuthenticationViewController"
let singleton = GameKitHelper()

class GameKitHelper: NSObject, GKGameCenterControllerDelegate {
  var authenticationViewController: UIViewController?
  var lastError: NSError?
  var gameCenterEnabled: Bool
  
  class var sharedInstance: GameKitHelper {
    return singleton
  }
  
  override init() {
    gameCenterEnabled = true
    super.init()
  }
  
  func authenticateLocalPlayer () {
    
    //1
    let localPlayer = GKLocalPlayer.localPlayer()
    localPlayer.authenticateHandler = {(viewController, error) in
      
      //2
      self.lastError = error
      
      if viewController != nil {
        //3
        self.authenticationViewController = viewController
        
        NSNotificationCenter.defaultCenter().postNotificationName(PresentAuthenticationViewController,
          object: self)
      } else if localPlayer.authenticated {
        //4
        self.gameCenterEnabled = true
      } else {
        //5
        self.gameCenterEnabled = false
      }
    }
  }
  
  func showGKGameCenterViewController(viewController: UIViewController!) {
    
    if !gameCenterEnabled {
      println("Local player is not authenticated")
      return
    }
    
    //1
    let gameCenterViewController = GKGameCenterViewController()
    
    //2
    gameCenterViewController.gameCenterDelegate = self
    
    //3
    gameCenterViewController.viewState = .Achievements
    
    //4
    viewController.presentViewController(gameCenterViewController,
      animated: true, completion: nil)
  }
  
  func reportAchievements(achievements: [GKAchievement]) {
    if !gameCenterEnabled {
      println("Local player is not authenticated")
      return
    }
    GKAchievement.reportAchievements(achievements) {(error) in
      self.lastError = error
    }
  }
  
  // MARK: GKGameCenterControllerDelegate methods
  func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
    
    gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
  }
    
    
   func reportScore(score: Int64, leaderBoardId: String)
   {
        
        if !gameCenterEnabled {
            println("Local player is not authenticated")
            return
        }
        
        //1
        let scoreReporter = GKScore(leaderboardIdentifier: leaderBoardId)
        scoreReporter.value = score
        scoreReporter.context = 0
        
        let scores = [scoreReporter]
        
        //2
        GKScore.reportScores(scores) {(error) in
            self.lastError = error
        }
    }
  
    
}