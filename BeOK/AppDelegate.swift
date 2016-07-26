//
//  AppDelegate.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/11/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let defaultSymptomsList: [String] = ["Accelerated Heartbeat", "Sweat", "Shaking/Trembling", "Hyperventilation", "Choking", "Chest Pain", "Nausea", "Dizziness", "Derealization/Depersonalization", "Loss of Control", "Fear of Death", "Numbness", "Chills"]

    let defaultCopingMessages: [String] = ["You're gonna be okay.", "You can get through this.", "I am proud of you. Good job.", "Concentrate on your breathing.", "Stay in the present.", "It's not the place that is bothering you; it's the thought.", "What you are feeling is scary, but it is not dangerous.", "Look around: everything is just fine.", "Pay attention to your breathing."]
    
    let defaultSounds: [String:Bool] = ["Rainforest":false, "Cicadas":false, "Lake":false, "Waves":true]
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor(red:0.26, green:0.29, blue:0.61, alpha:1.0)
        UITabBar.appearance().tintColor = UIColor(red:0.26, green:0.29, blue:0.61, alpha:1.0)
        
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Badge, .Alert, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        self.createLocalNotification()
        
        let hasLaunchedKey = "HasLaunched"
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasLaunched = defaults.boolForKey(hasLaunchedKey)
        
        if !hasLaunched {
            
            //Executed only on first run
            
            defaults.setBool(true, forKey: hasLaunchedKey)
            
            for i in defaultSymptomsList {
                saveDefaultSymptomsInCoreData(i)
            }
            
            for i in defaultCopingMessages {
                saveDefaultMessagesInCoreData(i)
            }
            
            for i in defaultSounds {
                saveDefaultSoundsInCoreData(i.0, isActive: i.1)
            }
        }

        return true
    }
    
    func saveDefaultSoundsInCoreData(sound: String, isActive: Bool) {
       
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let soundEntity =  NSEntityDescription.entityForName("Sound", inManagedObjectContext: managedContext)
        let newSound = NSManagedObject(entity: soundEntity!, insertIntoManagedObjectContext: managedContext)
        
        newSound.setValue(sound, forKey: "sound")
        newSound.setValue(isActive, forKey: "active")
        
        do {
            try managedContext.save()
        }
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func saveDefaultMessagesInCoreData(message: String) {
      
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let messageEntity =  NSEntityDescription.entityForName("Message", inManagedObjectContext: managedContext)
        let newMessage = NSManagedObject(entity: messageEntity!, insertIntoManagedObjectContext: managedContext)
        
        newMessage.setValue(message, forKey: "message")
        
        do {
            try managedContext.save()
        }
            
        catch let error as NSError  {
            
            print("Could not save \(error), \(error.userInfo)")
            
        }

    }
    
    func saveDefaultSymptomsInCoreData(symptom: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let symptomEntity =  NSEntityDescription.entityForName("Symptom", inManagedObjectContext: managedContext)
        let newSymptom = NSManagedObject(entity: symptomEntity!, insertIntoManagedObjectContext: managedContext)
        
        newSymptom.setValue(symptom, forKey: "symptom")
        
        do {
            try managedContext.save()
        }
            
        catch let error as NSError  {
            
            print("Could not save \(error), \(error.userInfo)")
            
        }
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
    }
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "uk.co.plymouthsoftware.core_data" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("BeOK", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

    func createLocalNotification() {
      
        let localNotification = UILocalNotification()
        
        // The notification will show up 6 seconds after the app was launched
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 6)
        
        // The notification will show up 24 hours after the app was lauched
//        localNotification.fireDate = NSDate(timeIntervalSinceNow: 86400)
        
        localNotification.applicationIconBadgeNumber = 1
        localNotification.soundName = UILocalNotificationDefaultSoundName
        
        localNotification.userInfo = [
            "message":"Would like to register a record?"
        ]
        
        localNotification.alertBody = "How was your day?"
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        if application.applicationState == .Active {
        
        }
//        } else {
//            
//        }
        
        self.takeActionWithNotification(notification)
    }
    
    func takeActionWithNotification(localNotification: UILocalNotification) {
        
        let notificationMessage = localNotification.userInfo!["message"] as! String
        
        let alertController = UIAlertController(title: "Hey!", message: notificationMessage, preferredStyle: .Alert)
        let remindMeLaterAction = UIAlertAction(title: "Remind me later", style: .Default, handler: nil)
        let sureAction = UIAlertAction(title: "Sure", style: .Default) { (action) -> Void in
            let tabBarController = self.window?.rootViewController as! UITabBarController
            tabBarController.selectedIndex = 1
        }
        
        alertController.addAction(remindMeLaterAction)
        alertController.addAction(sureAction)
        
        self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
        localNotification.applicationIconBadgeNumber = 0
    }
}

