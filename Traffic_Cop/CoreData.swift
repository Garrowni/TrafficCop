//
//  CoreData.swift
//  
//
//  Created by Justin Morritt on 2015-07-07.
//
//

import Foundation
import CoreData

class CoreData: NSManagedObject {

    @NSManaged var lev2: NSNumber
    @NSManaged var lev3: NSNumber
    @NSManaged var lev4: NSNumber
    @NSManaged var sound: NSNumber
    @NSManaged var music: NSNumber
    @NSManaged var hsLev1: NSNumber
    @NSManaged var hsLev2: NSNumber
    @NSManaged var hsLev3: NSNumber
    @NSManaged var hsLev4: NSNumber
    @NSManaged var initialized: NSNumber
    
    //STATS
    @NSManaged var carsCrashed: NSNumber
    @NSManaged var levelsBeat: NSNumber
    @NSManaged var peopleHit: NSNumber
    @NSManaged var timePlayed: NSNumber
    @NSManaged var longestSkid: NSNumber
    @NSManaged var hardestCrash: NSNumber

    //ACHIEVEMENTS
    @NSManaged var completionist: NSNumber
    @NSManaged var dailyDriver: NSNumber
    @NSManaged var lotsOfCrashes: NSNumber
    @NSManaged var lotsPeopleHit: NSNumber
    @NSManaged var treadLeft: NSNumber
    @NSManaged var hardHit: NSNumber
    
}
