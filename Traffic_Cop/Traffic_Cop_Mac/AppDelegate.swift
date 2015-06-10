//
//  AppDelegate.swift
//  Traffic_Cop_Mac
//
//  Created by Justin Morritt on 2015-06-10.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//


import Cocoa
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    func applicationDidFinishLaunching(aNotification: NSNotification)
    {
            let scene               = MainMenuScreen(size: CGSize(width: 1024, height: 1920)) // 16*64 = WIDTH 30*64 = HEIGHT
            scene.scaleMode         = .AspectFit
            
            self.skView!.presentScene(scene)
            self.skView!.ignoresSiblingOrder = true
            self.skView!.showsFPS = true
            self.skView!.showsNodeCount = true
        
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
