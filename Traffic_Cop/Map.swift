//
//  Map.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-13.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit

class Map
{
    let TW              : Int
    let level           : Int
    var spawnArray      : [SpawnPoint]
    var humanSpawnArray : [SpawnPoint]
    var roadArray       : [Road]
	var crossWArray     : [Crosswalk]
    var cornerArray     : [Corner]
    
    //LEVEL1 SPAWNS/ROAD CHOICES
    
    
    
    init(lvl: Int)
    {
        level           = lvl
        TW              = 128
        spawnArray      = []
        humanSpawnArray = []
        roadArray       = []
		crossWArray     = []
        cornerArray     = []
        
        
        //SET SPAWNS   (point set to center of tile at edge of map)
        switch (level)
        {
        case 1:
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*2+TW/2 ,y:TW*15),   direction: "down")) //TOP
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*3+TW/2 ,y:0 ),      direction: "up"))   //BOTTOM
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*8 ,y:TW*6+TW/2),    direction: "left")) //RIGHT
        case 2:
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*3+TW/2 ,y:TW*15),   direction: "down")) //TOP
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*4+TW/2 ,y:0),       direction: "up"))   //BOTTOM
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*8 ,y:TW*6+TW/2),    direction: "left")) //RIGHT
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*5+TW/2),    direction: "right"))//LEFT
        case 3:
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*3+TW/2 ,y:TW*15),   direction: "down")) //TOP
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*4+TW/2 ,y:TW*15),   direction: "down")) //TOP2
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*5+TW/2 ,y:0),       direction: "up"))   //BOTTOM
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*6+TW/2 ,y:0),       direction: "up"))   //BOTTOM2
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*4+TW/2),    direction: "right"))//LEFT
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*5+TW/2),    direction: "right"))//LEFT2
        case 4:
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*2+TW/2 ,y:TW*15),   direction: "down")) //TOP
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*3+TW/2 ,y:TW*15),   direction: "down")) //TOP2
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*4+TW/2 ,y:0),       direction: "up"))   //BOTTOM
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*5+TW/2 ,y:0),       direction: "up"))   //BOTTOM2
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*8 ,y:TW*7+TW/2),    direction: "left")) //RIGHT
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*8 ,y:TW*8+TW/2),    direction: "left")) //RIGHT2
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*5+TW/2),    direction: "right"))//LEFT
            self.spawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*6+TW/2),    direction: "right"))//LEFT2
        default:
            spawnArray.append(SpawnPoint(position: CGPoint(x:TW*2+TW/2 ,y:TW*15),   direction: "down")); println("error in setting the spawns: Map init")
        }
        
		//SET HUMAN SPAWNS
		switch (level)
        {
        case 1:
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*1+TW/2 ,y:TW*15),   direction: "down")) //TOP
			self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*4+TW/2 ,y:TW*15),   direction: "down")) //TOP2
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*1+TW/2 ,y:0 ),      direction: "up"))   //BOTTOM
			self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*4+TW/2 ,y:0 ),      direction: "up"))   //BOTTOM2
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*8 ,y:TW*4+TW/2),    direction: "left")) //RIGHT
			self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*8 ,y:TW*7+TW/2),    direction: "left")) //RIGHT2
        case 2:  
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*2+TW/2 ,y:TW*15),   direction: "down")) //TOP
			self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*5+TW/2 ,y:TW*15),   direction: "down")) //TOP2
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*2+TW/2 ,y:0),       direction: "up"))   //BOTTOM
			self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*5+TW/2 ,y:0),       direction: "up"))   //BOTTOM2
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*8 ,y:TW*4+TW/2),    direction: "left")) //RIGHT
			self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*8 ,y:TW*7+TW/2),    direction: "left")) //RIGHT
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*4+TW/2),    direction: "right"))//LEFT
			self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*7+TW/2),    direction: "right"))//LEFT
        case 3:  
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*2+TW/2 ,y:TW*15),   direction: "down")) //TOP
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*7+TW/2 ,y:TW*15),   direction: "down")) //TOP2
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*2+TW/2 ,y:0),       direction: "up"))   //BOTTOM
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*7+TW/2 ,y:0),       direction: "up"))   //BOTTOM2
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*3+TW/2),    direction: "right"))//LEFT
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*8+TW/2),    direction: "right"))//LEFT2
        case 4:  
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*1+TW/2 ,y:TW*15),   direction: "down")) //TOP
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*6+TW/2 ,y:TW*15),   direction: "down")) //TOP2
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*1+TW/2 ,y:0),       direction: "up"))   //BOTTOM
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*6+TW/2 ,y:0),       direction: "up"))   //BOTTOM2
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*8 ,y:TW*4+TW/2),    direction: "left")) //RIGHT
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*8 ,y:TW*9+TW/2),    direction: "left")) //RIGHT2
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*4+TW/2),    direction: "right"))//LEFT
            self.humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*0 ,y:TW*9+TW/2),    direction: "right"))//LEFT2
        default:
            humanSpawnArray.append(SpawnPoint(position: CGPoint(x:TW*2+TW/2 ,y:TW*15),   direction: "down")); println("error in setting the spawns: Map init")
        }
        
        //SET ROAD RECTS
        switch (level)
        {
        case 1:
            self.roadArray.append(Road(goto: CGPoint(x:TW*2+TW/2 ,y:TW*8+TW/2), roadRect: CGRect(x: TW*2, y: TW*8, width: TW, height: TW*7), side: "top"))//TOP
            self.roadArray.append(Road(goto: CGPoint(x:TW*3+TW/2 ,y:TW*8+TW/2), roadRect: CGRect(x: TW*3, y: TW*8, width: TW, height: TW*7), side: "top"))//TOP2
            self.roadArray.append(Road(goto: CGPoint(x:TW*2+TW/2 ,y:TW*3+TW/2), roadRect: CGRect(x: TW*2, y: TW*0, width: TW, height: TW*4), side: "bottom"))//BOTTOM
            self.roadArray.append(Road(goto: CGPoint(x:TW*3+TW/2 ,y:TW*3+TW/2), roadRect: CGRect(x: TW*3, y: TW*0, width: TW, height: TW*4), side: "bottom"))//BOTTOM2
            self.roadArray.append(Road(goto: CGPoint(x:TW*5+TW/2 ,y:TW*6+TW/2), roadRect: CGRect(x: TW*5, y: TW*6, width: TW*3, height: TW), side: "right"))//RIGHT
            self.roadArray.append(Road(goto: CGPoint(x:TW*5+TW/2 ,y:TW*5+TW/2), roadRect: CGRect(x: TW*5, y: TW*5, width: TW*3, height: TW), side: "right"))//RIGHT2
        case 2:
            self.roadArray.append(Road(goto: CGPoint(x:TW*3+TW/2 ,y:TW*8+TW/2), roadRect: CGRect(x: TW*3, y: TW*8, width: TW, height: TW*7), side: "top"))//TOP
            self.roadArray.append(Road(goto: CGPoint(x:TW*4+TW/2 ,y:TW*8+TW/2), roadRect: CGRect(x: TW*4, y: TW*8, width: TW, height: TW*7), side: "top"))//TOP2
            self.roadArray.append(Road(goto: CGPoint(x:TW*3+TW/2 ,y:TW*3+TW/2), roadRect: CGRect(x: TW*3, y: TW*0, width: TW, height: TW*4), side: "bottom"))//BOTTOM
            self.roadArray.append(Road(goto: CGPoint(x:TW*4+TW/2 ,y:TW*3+TW/2), roadRect: CGRect(x: TW*4, y: TW*0, width: TW, height: TW*4), side: "bottom"))//BOTTOM2
            self.roadArray.append(Road(goto: CGPoint(x:TW*6+TW/2 ,y:TW*6+TW/2), roadRect: CGRect(x: TW*6, y: TW*6, width: TW*2, height: TW), side: "right"))//RIGHT
            self.roadArray.append(Road(goto: CGPoint(x:TW*6+TW/2 ,y:TW*5+TW/2), roadRect: CGRect(x: TW*6, y: TW*5, width: TW*2, height: TW), side: "right"))//RIGHT2
            self.roadArray.append(Road(goto: CGPoint(x:TW*1+TW/2 ,y:TW*6+TW/2), roadRect: CGRect(x: TW*0, y: TW*6, width: TW*2, height: TW), side: "left"))//LEFT
            self.roadArray.append(Road(goto: CGPoint(x:TW*1+TW/2 ,y:TW*5+TW/2), roadRect: CGRect(x: TW*0, y: TW*5, width: TW*2, height: TW), side: "left"))//LEFT2
            
        case 3:
            self.roadArray.append(Road(goto: CGPoint(x:TW*3+TW/2 ,y:TW*9+TW/2), roadRect: CGRect(x: TW*3, y: TW*9, width: TW, height: TW*6), side: "top"))//TOP
            self.roadArray.append(Road(goto: CGPoint(x:TW*4+TW/2 ,y:TW*9+TW/2), roadRect: CGRect(x: TW*4, y: TW*9, width: TW, height: TW*6), side: "top"))//TOP2
            self.roadArray.append(Road(goto: CGPoint(x:TW*5+TW/2 ,y:TW*9+TW/2), roadRect: CGRect(x: TW*5, y: TW*9, width: TW, height: TW*6), side: "top"))//TOP3
            self.roadArray.append(Road(goto: CGPoint(x:TW*6+TW/2 ,y:TW*9+TW/2), roadRect: CGRect(x: TW*6, y: TW*9, width: TW, height: TW*6), side: "top"))//TOP4
            
            self.roadArray.append(Road(goto: CGPoint(x:TW*3+TW/2 ,y:TW*2+TW/2), roadRect: CGRect(x: TW*3, y: TW*0, width: TW, height: TW*3), side: "bottom"))//BOTTOM
            self.roadArray.append(Road(goto: CGPoint(x:TW*4+TW/2 ,y:TW*2+TW/2), roadRect: CGRect(x: TW*4, y: TW*0, width: TW, height: TW*3), side: "bottom"))//BOTTOM2
            self.roadArray.append(Road(goto: CGPoint(x:TW*5+TW/2 ,y:TW*2+TW/2), roadRect: CGRect(x: TW*5, y: TW*0, width: TW, height: TW*3), side: "bottom"))//BOTTOM3
            self.roadArray.append(Road(goto: CGPoint(x:TW*6+TW/2 ,y:TW*2+TW/2), roadRect: CGRect(x: TW*6, y: TW*0, width: TW, height: TW*3), side: "bottom"))//BOTTOM4
            
            self.roadArray.append(Road(goto: CGPoint(x:TW*1+TW/2 ,y:TW*7+TW/2), roadRect: CGRect(x: TW*0, y: TW*7, width: TW*2, height: TW), side: "left"))//LEFT
            self.roadArray.append(Road(goto: CGPoint(x:TW*1+TW/2 ,y:TW*6+TW/2), roadRect: CGRect(x: TW*0, y: TW*6, width: TW*2, height: TW), side: "left"))//LEFT2
            self.roadArray.append(Road(goto: CGPoint(x:TW*1+TW/2 ,y:TW*5+TW/2), roadRect: CGRect(x: TW*0, y: TW*5, width: TW*2, height: TW), side: "left"))//LEFT3
            self.roadArray.append(Road(goto: CGPoint(x:TW*1+TW/2 ,y:TW*4+TW/2), roadRect: CGRect(x: TW*0, y: TW*4, width: TW*2, height: TW), side: "left"))//LEFT4
            
        case 4:
            self.roadArray.append(Road(goto: CGPoint(x:TW*2+TW/2 ,y:TW*10+TW/2), roadRect: CGRect(x: TW*2, y: TW*10, width: TW, height: TW*5), side: "top"))//TOP
            self.roadArray.append(Road(goto: CGPoint(x:TW*3+TW/2 ,y:TW*10+TW/2), roadRect: CGRect(x: TW*3, y: TW*10, width: TW, height: TW*5), side: "top"))//TOP2
            self.roadArray.append(Road(goto: CGPoint(x:TW*4+TW/2 ,y:TW*10+TW/2), roadRect: CGRect(x: TW*4, y: TW*10, width: TW, height: TW*5), side: "top"))//TOP3
            self.roadArray.append(Road(goto: CGPoint(x:TW*5+TW/2 ,y:TW*10+TW/2), roadRect: CGRect(x: TW*5, y: TW*10, width: TW, height: TW*5), side: "top"))//TOP4
            
            self.roadArray.append(Road(goto: CGPoint(x:TW*2+TW/2 ,y:TW*3+TW/2), roadRect: CGRect(x: TW*2, y: TW*0, width: TW, height: TW*4), side: "bottom"))//BOTTOM
            self.roadArray.append(Road(goto: CGPoint(x:TW*3+TW/2 ,y:TW*3+TW/2), roadRect: CGRect(x: TW*3, y: TW*0, width: TW, height: TW*4), side: "bottom"))//BOTTOM2
            self.roadArray.append(Road(goto: CGPoint(x:TW*4+TW/2 ,y:TW*3+TW/2), roadRect: CGRect(x: TW*4, y: TW*0, width: TW, height: TW*4), side: "bottom"))//BOTTOM3
            self.roadArray.append(Road(goto: CGPoint(x:TW*5+TW/2 ,y:TW*3+TW/2), roadRect: CGRect(x: TW*5, y: TW*0, width: TW, height: TW*4), side: "bottom"))//BOTTOM4
            
            self.roadArray.append(Road(goto: CGPoint(x:TW*7+TW/2 ,y:TW*8+TW/2), roadRect: CGRect(x: TW*7, y: TW*8, width: TW, height: TW), side: "right"))//RIGHT
            self.roadArray.append(Road(goto: CGPoint(x:TW*7+TW/2 ,y:TW*7+TW/2), roadRect: CGRect(x: TW*7, y: TW*7, width: TW, height: TW), side: "right"))//RIGHT2
            self.roadArray.append(Road(goto: CGPoint(x:TW*7+TW/2 ,y:TW*6+TW/2), roadRect: CGRect(x: TW*7, y: TW*6, width: TW, height: TW), side: "right"))//RIGHT3
            self.roadArray.append(Road(goto: CGPoint(x:TW*7+TW/2 ,y:TW*5+TW/2), roadRect: CGRect(x: TW*7, y: TW*5, width: TW, height: TW), side: "right"))//RIGHT4
            
            self.roadArray.append(Road(goto: CGPoint(x:TW*0+TW/2 ,y:TW*8+TW/2), roadRect: CGRect(x: TW*0, y: TW*8, width: TW, height: TW), side: "left"))//LEFT
            self.roadArray.append(Road(goto: CGPoint(x:TW*0+TW/2 ,y:TW*7+TW/2), roadRect: CGRect(x: TW*0, y: TW*7, width: TW, height: TW), side: "left"))//LEFT2
            self.roadArray.append(Road(goto: CGPoint(x:TW*0+TW/2 ,y:TW*6+TW/2), roadRect: CGRect(x: TW*0, y: TW*6, width: TW, height: TW), side: "left"))//LEFT3
            self.roadArray.append(Road(goto: CGPoint(x:TW*0+TW/2 ,y:TW*5+TW/2), roadRect: CGRect(x: TW*0, y: TW*5, width: TW, height: TW), side: "left"))//LEFT4
            
        default:
            self.roadArray.append(Road(goto: CGPoint(x:0 ,y:0), roadRect: CGRect(x:0, y:0, width: TW, height: TW), side: "error")); println("Error in Setting Roads...Level Not compatible")
           
        
            
        }
        
		//SET CROSSWALK RECTS
        switch (level)
        {
        case 1:
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*2, y: TW*7, width: TW, height: TW)))//TOP

            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*3, y: TW*7, width: TW, height: TW)))//TOP2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*2, y: TW*4, width: TW, height: TW)))//BOTTOM
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*3, y: TW*4, width: TW, height: TW)))//BOTTOM2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*4, y: TW*6, width: TW, height: TW)))//RIGHT
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*4, y: TW*5, width: TW, height: TW)))//RIGHT2
        
		case 2:                     
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*3, y: TW*7, width: TW, height: TW)))//TOP
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*4, y: TW*7, width: TW, height: TW)))//TOP2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*3, y: TW*4, width: TW, height: TW)))//BOTTOM
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*4, y: TW*4, width: TW, height: TW)))//BOTTOM2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*5, y: TW*6, width: TW, height: TW)))//RIGHT
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*5, y: TW*5, width: TW, height: TW)))//RIGHT2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*2, y: TW*6, width: TW, height: TW)))//LEFT
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*2, y: TW*5, width: TW, height: TW)))//LEFT2
        
		case 3:                           
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*3, y: TW*8, width: TW, height: TW)))//TOP
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*4, y: TW*8, width: TW, height: TW)))//TOP2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*5, y: TW*8, width: TW, height: TW)))//TOP3
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*6, y: TW*8, width: TW, height: TW)))//TOP4
                                    
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*3, y: TW*3, width: TW, height: TW)))//BOTTOM
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*4, y: TW*3, width: TW, height: TW)))//BOTTOM2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*5, y: TW*3, width: TW, height: TW)))//BOTTOM3
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*6, y: TW*3, width: TW, height: TW)))//BOTTOM4
                                    
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*2, y: TW*7, width: TW, height: TW)))//LEFT
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*2, y: TW*6, width: TW, height: TW)))//LEFT2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*2, y: TW*5, width: TW, height: TW)))//LEFT3
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*2, y: TW*4, width: TW, height: TW)))//LEFT4
                
        case 4:  
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*2, y: TW*9, width: TW, height: TW)))//TOP
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*3, y: TW*9, width: TW, height: TW)))//TOP2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*4, y: TW*9, width: TW, height: TW)))//TOP3
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*5, y: TW*9, width: TW, height: TW)))//TOP4
                                         
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*2, y: TW*4, width: TW, height: TW)))//BOTTOM
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*3, y: TW*4, width: TW, height: TW)))//BOTTOM2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*4, y: TW*4, width: TW, height: TW)))//BOTTOM3
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*5, y: TW*4, width: TW, height: TW)))//BOTTOM4
                                          
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*6, y: TW*8, width: TW, height: TW)))//RIGHT
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*6, y: TW*7, width: TW, height: TW)))//RIGHT2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*6, y: TW*6, width: TW, height: TW)))//RIGHT3
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*6, y: TW*5, width: TW, height: TW)))//RIGHT4
                                          
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*1, y: TW*8, width: TW, height: TW)))//LEFT
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*1, y: TW*7, width: TW, height: TW)))//LEFT2
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*1, y: TW*6, width: TW, height: TW)))//LEFT3
            self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*1, y: TW*5, width: TW, height: TW)))//LEFT4
                 
        default: 
             self.crossWArray.append(Crosswalk(Rect: CGRect(x: TW*1, y: TW*5, width: TW, height: TW)))//LEFT4;println("Error in Setting Roads...Level Not compatible")
            
        }
		
        //SET Corner RECTS
       switch (level)
       {
            case 1:
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*1, y: TW*7, width: TW, height: TW)))//TOPLeft
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*4, y: TW*7, width: TW, height: TW)))//TOPRIGHT
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*1, y: TW*4, width: TW, height: TW)))//BOTTOMLEFT
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*4, y: TW*4, width: TW, height: TW)))//BOTTOMRIGHT
        
          
            case 2:
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*2, y: TW*7, width: TW, height: TW)))//TOPLeft
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*5, y: TW*7, width: TW, height: TW)))//TOPRIGHT
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*2, y: TW*10, width: TW, height: TW)))//BOTTOMLEFT
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*5, y: TW*10, width: TW, height: TW)))//BOTTOMRIGHT
            
            case 3:
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*2, y: TW*6, width: TW, height: TW)))//TOPLeft
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*7, y: TW*6, width: TW, height: TW)))//TOPRIGHT
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*2, y: TW*11, width: TW, height: TW)))//BOTTOMLEFT
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*7, y: TW*11, width: TW, height: TW)))//BOTTOMRIGHT
            
            case 4:
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*1, y: TW*5, width: TW, height: TW)))//TOPLeft
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*6, y: TW*5, width: TW, height: TW)))//TOPRIGHT
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*1, y: TW*10, width: TW, height: TW)))//BOTTOMLEFT
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*6, y: TW*10, width: TW, height: TW)))//BOTTOMRIGHT
        
            default:
                self.cornerArray.append(Corner(CornerRect: CGRect(x: TW*1, y: TW*5, width: TW, height: TW)))
  
        }
		
        
    }
    
    func getSpawns() -> [SpawnPoint]
    {
        return spawnArray
    }
    
    func getRoads() -> [Road]
    {
        return roadArray
    }
    
	func getCrossWalks() -> [Crosswalk]
    {
        return crossWArray
    }
    func getCorners() -> [Corner]
    {
        return cornerArray
    }
    
    func getPeopleSpawns() -> [SpawnPoint]
    {
        return humanSpawnArray
    }
    
    func randomSpawn() -> SpawnPoint
    {
        let randSpawn: Int = Int.randomNumberFrom(0...spawnArray.count)
        return spawnArray[randSpawn]
    }
    
    func humanRandomSpawn() -> SpawnPoint
    {
        let randSpawn: Int = Int.randomNumberFrom(0...humanSpawnArray.count)
        return humanSpawnArray[randSpawn]
    }
    
    func atIntersection(rect: CGRect) ->Bool
    {
        for Rec in crossWArray
        {
            if(rect.intersects(Rec.rect)){return true}
        }
        return false
    }
    
    //USE THIS TO CHECK IF ON A ROAD FIRST THEN
    func isOnRoad(pos: CGPoint) -> Bool
    {
        for road in roadArray
        {
            if(road.rect.contains(pos)){return true}
        }
        return false
    }
    
    //USE THIS TO GET ROAD IF THEY ARE ON ONE USED IN TURNING CALCULATION
    func getCurRoad(pos: CGPoint) -> Road
    {
        for road in roadArray
        {
            if(road.rect.contains(pos)){return road}
        }
        println("ERROR POINT WASNT ON ANY ROAD")
        return roadArray[0]
    }
  
    
    
}




struct Road
{
    var rect: CGRect
    var gotoPoint: CGPoint  //CENTER OF THE TILE CLOSEST TO THE CROSSWALK ..USED FOR TURNING CALCULATION
    var Side : String
    
    init(goto: CGPoint, roadRect: CGRect, side: String)
    {
     Side       = side
     gotoPoint  = goto
     rect       = roadRect
    }
}


struct Crosswalk
{
    let rect: CGRect
    init(Rect: CGRect)
    {
     rect       = Rect
    }
}
struct Corner
{
    var rect: CGRect

    init (CornerRect: CGRect)
    {
    rect    = CornerRect
    }
}


//CENTER POINT OF THE SPAWN LOCATION WILL HAVE TO OFFSET FROM IT THE HEIGHT/OR WIDTH OF VEHICLE DEPENDING ON DIRECTION
struct SpawnPoint
{
    let pos: CGPoint
    let dir: Int
    
    init(position: CGPoint, direction: String)
    {
        pos = position
        switch(direction)
        {
            case "up":      dir = 0
            case "left":    dir = 1
            case "right":   dir = 2
            case "down":    dir = 3
            
        default: dir  = 0; println("Mis-Spell on the Spawn Point Direction")
        }
    }
    func getDir() -> Int
    {
        return dir
    }
    func getPos() -> CGPoint
    {
        return pos
    }
}

