//
//  AddRecordViewController.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/12/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import AddressBookUI

class AddRecordViewController: UIViewController, CLLocationManagerDelegate, AddRecordDelegate {
    
    var firstView : AddRecordView1!
    var secondView : AddRecordView2!
    var thirdView: AddRecordView3!
    
    var recordsList = [NSManagedObject]()
    var symptomsList = [NSManagedObject]()
    
    var recordSymptoms: [String]!
    
    var leftNavBarButton: UIBarButtonItem!
    var rightNavBarButton: UIBarButtonItem!
    
    var navItem: UINavigationItem!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddRecordViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddRecordViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
    
        self.firstView = AddRecordView1(frame: CGRectMake(0,0,view.frame.width,view.frame.height))
        firstView.delegate = self
        self.secondView = AddRecordView2(frame: CGRectMake(0,0,view.frame.width,view.frame.height))
        self.thirdView = AddRecordView3(frame: CGRectMake(0,0,view.frame.width,view.frame.height))
        
        self.view = firstView
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
       
        navItem = UINavigationItem(title: "New Record")
        
        rightNavBarButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(self.rightBarButtonAction))
        navItem.rightBarButtonItem = rightNavBarButton
        
       
        leftNavBarButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(self.leftBarButtonAction))
        navItem.leftBarButtonItem = leftNavBarButton
        
        self.navigationController?.navigationBar.setItems([navItem], animated: false)

    }
    
    func keyboardWillShow(sender: NSNotification) {
        if self.view == firstView {
             self.view.frame.origin.y -= 150
        }
    }
    func keyboardWillHide(sender: NSNotification) {
        if self.view == firstView {
            self.view.frame.origin.y += 150
        }
    }
    
    func rightBarButtonAction(sender: UIBarButtonItem) {
        
        if self.view == firstView {
            
            self.view = secondView
            leftNavBarButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(self.leftBarButtonAction))
            navItem.leftBarButtonItem = leftNavBarButton
        } else {
            
            if self.view == secondView {
                
                rightNavBarButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(self.rightBarButtonAction))
                navItem.rightBarButtonItem = rightNavBarButton
                self.view = thirdView
                
            } else {
                
                if self.view == thirdView {
                    performSegueWithIdentifier("segueToRecords", sender: self)
                }
            }
        }
    }
    
    func leftBarButtonAction(sender: UIBarButtonItem) {
        
        if self.view == thirdView {
            self.view = secondView
            rightNavBarButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(self.rightBarButtonAction))
            navItem.rightBarButtonItem = rightNavBarButton
        }
        
        else {
            
            if self.view == secondView {
                self.view = firstView
                leftNavBarButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(self.leftBarButtonAction))
                navItem.leftBarButtonItem = leftNavBarButton
            }
            
            else {
                if self.view == firstView {
                    performSegueWithIdentifier("segueToRecords", sender: self)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueToRecords") {
            // pass data to next view
            
            let nextVC = segue.destinationViewController as! RecordsTableViewController
            
            if self.view == thirdView {
                self.saveRecord(firstView.date, duration: firstView.durationValue, location: firstView.locationTextView.text!, description: thirdView.descriptionTextView.text!, otherSymptom: secondView.otherSymptomTextField.text!)
            }
            
            nextVC.tableView.reloadData()
        }
    }
    
    func saveRecord(date: NSDate, duration: Int, location: String, description: String, otherSymptom: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let recordEntity =  NSEntityDescription.entityForName("Record", inManagedObjectContext: managedContext)
        let record = NSManagedObject(entity: recordEntity!, insertIntoManagedObjectContext: managedContext)
        
        if otherSymptom != "" {
         
            let symptomEntity = NSEntityDescription.entityForName("Symptom", inManagedObjectContext: managedContext)
            let symptom = NSManagedObject(entity: symptomEntity!, insertIntoManagedObjectContext: managedContext)
            
            symptom.setValue(otherSymptom, forKey: "symptom")
        }
    
        record.setValue(date, forKey: "date")
        record.setValue(duration, forKey: "duration")
        record.setValue(location, forKey: "location")
        
        if description != "" {
           record.setValue(description, forKey: "attackDescription")
        }
        
        else {
            record.setValue("No description", forKey: "attackDescription")
        }
        
        do {
            try managedContext.save()
        }
        
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        saveRecordSymptom(record)
    }
    
    func saveRecordSymptom(record: NSManagedObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestSymptom = NSFetchRequest(entityName: "Symptom")
        
        do {
            let resultsSymptom = try managedContext.executeFetchRequest(fetchRequestSymptom)
            symptomsList = resultsSymptom as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

        let recordSymptomEntity =  NSEntityDescription.entityForName("RecordSymptom", inManagedObjectContext: managedContext)
        
        var i: Int = 0
        while i < secondView.checked.count {
            
            if secondView.checked[i] == true {
                
                let recordSymptom = NSManagedObject(entity: recordSymptomEntity!, insertIntoManagedObjectContext: managedContext)
                
                recordSymptom.setValue(record.objectID.URIRepresentation().absoluteString, forKey: "recordID")
                
                recordSymptom.setValue(self.symptomsList[i].objectID.URIRepresentation().absoluteString, forKey: "symptomID")
                
                do {
                    try managedContext.save()
                }
                catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
            
            i += 1
        }
        
        if secondView.otherSymptomTextField.text != "" {
            
            let recordSymptom = NSManagedObject(entity: recordSymptomEntity!, insertIntoManagedObjectContext: managedContext)
            
            recordSymptom.setValue(record.objectID.description, forKey: "recordID")
            recordSymptom.setValue(self.symptomsList[i].objectID.description, forKey: "symptomID")
            
            do {
                try managedContext.save()
            }
            catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Hold Up...", message: "Before you continue, Be OK wants access to your location. Turn on Location Services in your device settings.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
