//
//  Settings.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-13.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import SpriteKit




class Settings
{
    var music  : Bool
    var sound  : Bool

    //UNLOCKED/LOCKED
    var lev1 : Bool
    var lev2 : Bool
    var lev3 : Bool
    var lev4 : Bool
    
    //GOTO LEVEL
    var goLev1 : Bool
    var goLev2 : Bool
    var goLev3 : Bool
    var goLev4 : Bool
    
    init()
    {
        music      = true
        sound      = true
        
        lev1       = true
        lev2       = true
        lev3       = true
        lev4       = true
        
        goLev1     = false
        goLev2     = false
        goLev3     = false
        goLev4     = false
    }
    
    func goto(lev: Int)
    {
        switch(lev)
        {
        case 1:
            goLev1     = true
            goLev2     = false
            goLev3     = false
            goLev4     = false
        case 2:
            goLev1     = false
            goLev2     = true
            goLev3     = false
            goLev4     = false
        case 3:
            goLev1     = false
            goLev2     = false
            goLev3     = true
            goLev4     = false
        case 4:
            goLev1     = false
            goLev2     = false
            goLev3     = false
            goLev4     = true
        default: println("error in the level goto function")
        }
        
    }
    
}