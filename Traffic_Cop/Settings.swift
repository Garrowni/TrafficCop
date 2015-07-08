//
//  Settings.swift
//  Traffic_Cop
//
//  Created by Justin Morritt on 2015-06-13.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import Foundation
import CoreData

var error: NSError?

//FETCH
var fetchRequest = NSFetchRequest(entityName: "SaveData")
let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as? [CoreData]



var applicationDocumentsDirectory: NSURL = {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.xxxx.ProjectName" in the application's documents Application Support directory.
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.count-1] as! NSURL
    }()

var managedObjectModel: NSManagedObjectModel = {
    // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
    let modelURL = NSBundle.mainBundle().URLForResource("CoreData", withExtension: ".momd")!
    return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
    // Create the coordinator and store
    var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    let url = applicationDocumentsDirectory.URLByAppendingPathComponent("Traffic_Cop.sqlite")
    var error: NSError? = nil
    var failureReason = "There was an error creating or loading the application's saved data."
    if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
        coordinator = nil
        // Report any error we got.
        var dict = [String: AnyObject]()
        dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
        dict[NSLocalizedFailureReasonErrorKey] = failureReason
        dict[NSUnderlyingErrorKey] = error
        error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog("Unresolved error \(error), \(error!.userInfo)")
        abort()
    }
    
    return coordinator
    }()


var managedObjectContext: NSManagedObjectContext? = {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
    let coordinator = persistentStoreCoordinator
    if coordinator == nil {
        return nil
    }
    var managedObjectContext = NSManagedObjectContext()
    managedObjectContext.persistentStoreCoordinator = coordinator
    return managedObjectContext
    }()

// MARK: - Core Data Saving support

func saveContext () {
    if let moc = managedObjectContext {
        var error: NSError? = nil
        if moc.hasChanges && !moc.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
    }
}


//*********Star Goals***********
let lv1Bronze = 50
let lv1Silver = 100
let lv1Gold   = 150

let lv2Bronze = 200
let lv2Silver = 250
let lv2Gold   = 350

let lv3Bronze = 500
let lv3Silver = 600
let lv3Gold   = 700

let lv4Bronze = 850
let lv4Silver = 950
let lv4Gold   = 1050


//*********End Star Goals*******


//GETTERS
func Lev2() -> Bool
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        return VAR.lev2.boolValue
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return false
}

func Lev3() -> Bool
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        return VAR.lev3.boolValue
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return false
}

func Lev4() -> Bool
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        return VAR.lev4.boolValue
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return false
}

func Sound() -> Bool
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        return VAR.sound.boolValue
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return false
}

func Music() -> Bool
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        return VAR.music.boolValue
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return false
}

func PeopleHit() -> Int
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        return VAR.peopleHit.integerValue
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return -1
}

func TimePlayed() -> String
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        
        var fullSecs = VAR.timePlayed.integerValue
        
        var string : String  = ""
        var hours       = fullSecs/3600
        var minutesLeft = fullSecs/60 - (hours*60)
        var secsLeft    = fullSecs - (minutesLeft*60)
        var strHours    = String(hours)
        var strSecs     = String(secsLeft)
        var strMin      = String(minutesLeft)
        
        string += "Hr: "
        if(hours < 10){string += String(0)}
        string += strHours
        
        string += "  Min: "
        if(minutesLeft < 10){string += String(0)}
        string += strMin
        
        string += "  Sec: "
        if(secsLeft < 10){string += String(0)}
        string += strSecs
        
        return string
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return ""
}

func CarsHit() -> Int
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        return VAR.carsCrashed.integerValue
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return -1
}

func LevelsBeat() -> Int
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        return VAR.levelsBeat.integerValue
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return -1
}

func HighScore(lev: Int) -> Int
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        switch(lev)
        {
        case 1: return VAR.hsLev1.integerValue
        case 2: return VAR.hsLev2.integerValue
        case 3: return VAR.hsLev3.integerValue
        case 4: return VAR.hsLev4.integerValue
        default: break
        }
    }
    return 1
}

func LongestSkid() -> Int
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        return VAR.longestSkid.integerValue
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return -1
}

func HardestCrash() -> Int
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        return VAR.hardestCrash.integerValue
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    return -1
}



//SETTERS
func NewHardestCrash(new: Int)
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        VAR.hardestCrash = NSNumber(int: Int32(new))
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
}

func NewLongestSkid(new: Int)
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        VAR.longestSkid = NSNumber(int: Int32(new))
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
}

func IncreaseCarsHit()
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        var tp = VAR.carsCrashed.integerValue + 1
        VAR.carsCrashed = NSNumber(int: Int32(tp))
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
}

func IncreasePeopleHit()
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        var tp = VAR.peopleHit.integerValue + 1
        VAR.peopleHit = NSNumber(int: Int32(tp))
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
}

func IncreaseTimePlayed()
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        var tp = VAR.timePlayed.integerValue + 1
        VAR.timePlayed = NSNumber(int: Int32(tp))
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
}

func IncreaseLevelsBeat()
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        var tp = VAR.levelsBeat.integerValue + 1
        VAR.levelsBeat = NSNumber(int: Int32(tp))
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
}

func TurnSound(on: Bool)
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        VAR.sound = NSNumber(bool: on)
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
    saveGame()
}

func TurnMusic(on: Bool)
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        VAR.music = NSNumber(bool: on)
    }
    else
    {
        println("Could not fetch \(error), \(error!.userInfo)")
    }
   saveGame()
}





func unlockLev(lev : Int)
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        switch(lev)
        {
        case 2: VAR.lev2 = NSNumber(bool: true)
        case 3: VAR.lev3 = NSNumber(bool: true)
        case 4: VAR.lev4 = NSNumber(bool: true)
        default: break;
        }
        saveGame()
    }
}

func newHighScore(lev: Int, val: Int)
{
    if let variables = fetchResults
    {
        var VAR = variables[0]
        switch(lev)
        {
        case 1: VAR.hsLev1 = NSNumber(int: Int32(val))
        case 2: VAR.hsLev2 = NSNumber(int: Int32(val))
        case 3: VAR.hsLev3 = NSNumber(int: Int32(val))
        case 4: VAR.hsLev4 = NSNumber(int: Int32(val))
        default: break;
        }
    }
    saveGame()
    
}

func saveGame()
{
    //SAVE
    if managedObjectContext!.save(&error){ println("SAVED!")
    }else{println("Could not save \(error), \(error!.userInfo)")}

}

//RESET
func ResetSaveFile()
{
    if let variables = fetchResults
    {
        var VAR         = variables[0]
            VAR.lev2    = NSNumber(bool: false)
            VAR.lev3    = NSNumber(bool: false)
            VAR.lev4    = NSNumber(bool: false)
            VAR.sound   = NSNumber(bool: false)
            VAR.music   = NSNumber(bool: false)
            VAR.hsLev1  = NSNumber(int: 0)
            VAR.hsLev2  = NSNumber(int: 0)
            VAR.hsLev3  = NSNumber(int: 0)
            VAR.hsLev4  = NSNumber(int: 0)
            VAR.initialized = NSNumber(bool: false)
            
        saveGame()
        
    }else{
        println("Could not fetch \(error), \(error!.userInfo)")
    }
}

