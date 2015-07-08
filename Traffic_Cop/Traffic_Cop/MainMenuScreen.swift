//
//  MainMenuScreen.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-08.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScreen: SKScene
{
    let TW : Int
    let titleLabel      : Text
    let playLabel       : Text
    let helpLabel       : Text
    let credLabel       : Text
    
    let titlButt: Button
    let playButt: Button
    let helpButt: Button
    let credButt: Button
    let soundButt: Button
    //let statsButt: Button
    
    let playableRect : CGRect
    let titlR: CGRect
    let playR: CGRect
    let helpR: CGRect
    let credR: CGRect
    var vehicleArray: [CarSprite] = []
    var spawn1 : SpawnPoint
    var spawn2 : SpawnPoint
    var spawnAction = SKAction()
   
    override init(size: CGSize)
    {
        TW = 128
        let maxAspectRatio:CGFloat = 9.0/16.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        var str : String //IF SOUND IS ALREADY ON
        if(Sound()){str = "(="}else{str = "("}
      
        //Labels
        var soundLabel   = Text(pos: CGPoint(x: 0, y:0),    says: str,               fontSize: 70,   font: "font2", color: "green",  align: "center")
        titleLabel      = Text(pos: CGPoint(x: 0, y: 0),    says: "Traffic Cop",    fontSize: 150, font: "font1", color: "yellow", align: "center")
        playLabel       = Text(pos: CGPoint(x: 0, y: 0),    says: "Play",           fontSize: 200, font: "font4", color: "black", align: "center")
        helpLabel       = Text(pos: CGPoint(x: 0, y: 0),    says: "Help",           fontSize: 200, font: "font4", color: "black", align: "center")
        credLabel       = Text(pos: CGPoint(x: 0, y: 0),    says: "Credits",        fontSize: 200, font: "font4", color: "black", align: "center")
        
        //Rects  * remember subtract half the width from the x to get true center *
        titlR = CGRect(x: size.width/2-450, y: size.height-350, width: 900, height: 300)
        playR = CGRect(x: size.width/2-300, y: size.height-790, width: 600, height: 400)
        helpR = CGRect(x: size.width/2-300, y: size.height-1215, width: 600, height: 400)
        credR = CGRect(x: size.width/2-300, y: size.height-1640, width: 600, height: 400)
        
        //Buttons
        titlButt = Button(pos: titlR, roundCorner: 100, text: titleLabel, BGcolor: "halfblack", OLcolor: "red",      OLSize: 10, glowWidth: 40, ZoomIn: true, Bulge: true,  glowBulge: false)
        playButt = Button(pos: playR, roundCorner: 200, text: playLabel, BGcolor: "green", OLcolor: "white",    OLSize: 10, glowWidth: 30, ZoomIn: true, Bulge: false, glowBulge: true)
        helpButt = Button(pos: helpR, roundCorner: 200, text: helpLabel, BGcolor: "yellow", OLcolor: "white",   OLSize: 10, glowWidth: 30, ZoomIn: true, Bulge: false, glowBulge: true)
        credButt = Button(pos: credR, roundCorner: 200, text: credLabel, BGcolor: "red", OLcolor: "white",      OLSize: 10, glowWidth: 30, ZoomIn: true, Bulge: false, glowBulge: true)
        soundButt = Button(pos: CGRect(origin: CGPoint(x: TW*7-32, y: TW*11), size: CGSize(width: 128, height: 128)),                                     roundCorner: 64, text: soundLabel,      BGcolor: "halfblack", OLcolor: "red", OLSize: 2,    glowWidth: 3, ZoomIn: true, Bulge: false, glowBulge: false)

        
        
        spawn1 = SpawnPoint(position: CGPoint(x: playableRect.width + 200, y: 180), direction: "left")
        spawn2 = SpawnPoint(position: CGPoint(x: -200, y: 48), direction: "right")
        
        

    
        
        super.init(size: size)
        
        //SET ACTIONS
        let spawn = SKAction.runBlock(){self.spawnVehicle();}
        let wait = SKAction.waitForDuration(3)                     //SPAWN TIME !
        let spawnSequence = SKAction.sequence([spawn, wait])
        spawnAction = SKAction.repeatActionForever(spawnSequence)
  
    }
    
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToView(view: SKView)
    {
        var background:SKSpriteNode
        playBackgroundMusic("Sunshine A.mp3")

        background = SKSpriteNode(imageNamed: "MainMenu")
        background.position =  CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        
        //BUTTONS / TITLE
        addChild(titlButt.getButtBG())
        addChild(titlButt.getButtOL())
        addChild(titlButt.getLabel())
        
        addChild(playButt.getButtBG())
        addChild(playButt.getButtOL())
        addChild(playButt.getLabel())
        
        addChild(helpButt.getButtBG())
        addChild(helpButt.getButtOL())
        addChild(helpButt.getLabel())
        
        addChild(credButt.getButtBG())
        addChild(credButt.getButtOL())
        addChild(credButt.getLabel())
        
        addChild(soundButt.getButtBG())
        addChild(soundButt.getButtOL())
        addChild(soundButt.getLabel())
      
        self.runAction(self.spawnAction)

        background.zPosition = -1
        addChild(background)
        
    }
    
    
    // iOS AND OSX DIFFERENT TOUCH HANDLING
    //PRE-COMPILE DIRECTIVES
    #if os(iOS)
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        //println("x = \(location.x) and y = \(location.y)")
       
        if playR.contains(location)
        {
            goToGame()
        }
        if(soundButt.origRect.contains(location))
        {
            SoundOffOn()
        }
        if helpR.contains(location)
        {
            goToHelp()
        }
        if credR.contains(location)
        {
            goToCredits()
        }
    }
    #else
    override func mouseDown(theEvent: NSEvent)
    {
        let location = theEvent.locationInNode(self)
    
        if playR.contains(location)
        {
            goToGame()
        }
        if helpR.contains(location)
        {
            goToHelp()
        }
        if credR.contains(location)
        {
            goToCredits()
        }
    }
    #endif
    
    override func update(currentTime: CFTimeInterval)
    {
            updateVehicles()
        
    }
    
    func updateVehicles()
    {
        
        for(var i = 0; i < vehicleArray.count; i++)
        {
            vehicleArray[i].update()

            if(vehicleArray[i].isDone(playableRect))
            {
                vehicleArray[i].removeFromParent()
                vehicleArray.removeAtIndex(i)
            }
            
        }
        
    }
    
    //TRANSITION
    func goToGame()
    {
    
        let transition = SKAction.group([SKAction.runBlock(){
            self.playButt.zoomOUT()
            self.titlButt.FadeAway()
            self.credButt.FadeAway()
            self.helpButt.FadeAway()
            self.soundButt.FadeAway()
            }])
        let wait = SKAction.waitForDuration(0.5)
        let block = SKAction.runBlock
        {
            let myScene = LevelScreen(size: self.size)
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
            self.view?.presentScene(myScene, transition: reveal)
        }
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
        
    }
    
    func goToHelp()
    {
        let transition = SKAction.group([SKAction.runBlock(){
            self.playButt.FadeAway()
            self.titlButt.FadeAway()
            self.credButt.FadeAway()
            self.helpButt.zoomOUT()
            self.soundButt.FadeAway()
            }])
        let wait = SKAction.waitForDuration(0.5)
        let block = SKAction.runBlock{
            let myScene = HelpScreen(size: self.size)
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
            self.view?.presentScene(myScene, transition: reveal)
        }
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
    }
    
    func goToCredits()
    {
        let transition = SKAction.group([SKAction.runBlock(){
            self.playButt.FadeAway()
            self.titlButt.FadeAway()
            self.credButt.zoomOUT()
            self.helpButt.FadeAway()
            self.soundButt.FadeAway()
            }])

        let wait = SKAction.waitForDuration(0.5)
        let block = SKAction.runBlock
        {
            let myScene = CreditsScreen(size: self.size)
            myScene.scaleMode = self.scaleMode
            let reveal = SKTransition.doorsCloseHorizontalWithDuration(1.5)
            self.view?.presentScene(myScene, transition: reveal)
        }
        let transSequence = SKAction.sequence([transition,wait,block])
        self.runAction(transSequence)
        
        
    }
    
    func SoundOffOn()
    {
        if(Sound())
        {
            backgroundMusicPlayer.pause(); TurnSound(false); soundButt.getLabel().text = "(";
        }
        else
        {
            backgroundMusicPlayer.play(); TurnSound(true); soundButt.getLabel().text = "(=";
        }
    }

    
    func spawnVehicle()
    {
        var rand  = Int.randomNumberFrom(1...2)
        var car : CarSprite
        
        if(vehicleArray.count < 15)
        {
            if(rand == 1 ){car = CarSprite(type: Int.randomNumberFrom(1...6), direction: spawn1, Parent: self)}
            else {car = CarSprite(type: Int.randomNumberFrom(1...6), direction: spawn2, Parent: self)}
            
            vehicleArray.append(car)
            car.drive()
            addChild(car)
        }
    }
}
