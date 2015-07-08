//
//  AppDelegate.swift
//  Traffic_Cop
//
//  Created by Mathew  Manton on 2015-06-05.
//  Copyright (c) 2015 Mat_Nicole_Justin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var error: NSError?

    
    
    func saveSomething()
    {
        
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //FETCH
        let entity = NSEntityDescription.entityForName("SaveData", inManagedObjectContext: managedObjectContext!)
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext!)
        
        
        var fetchRequest = NSFetchRequest(entityName: "SaveData")
        let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: &error) as? [CoreData]
        if let variables = fetchResults{
        var VAR = variables[0]
        //println("\(VAR.initialized.boolValue)")
        if(!VAR.initialized.boolValue)
            {
                VAR.lev2 = NSNumber(bool: false)
                VAR.lev3 = NSNumber(bool: false)
                VAR.lev4 = NSNumber(bool: false)
                VAR.sound = NSNumber(bool: false)
                VAR.music = NSNumber(bool: false)
                VAR.hsLev1 = NSNumber(int: 0)
                VAR.hsLev2 = NSNumber(int: 0)
                VAR.hsLev3 = NSNumber(int: 0)
                VAR.hsLev4 = NSNumber(int: 0)
                VAR.initialized = NSNumber(bool: true)
                
                //println("\(VAR.initialized.boolValue)")
                
                //SAVE
                if managedObjectContext!.save(&error){ println("TRUE !! WAS INITIALIZED")
                }else{println("Could not save \(error), \(error!.userInfo)")}
            }
            
        }else{
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
    
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.xxxx.ProjectName" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("CoreData", withExtension: ".momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Traffic_Cop.sqlite")
        var error: NSError? = nil
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            // What to do when it fails
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}

