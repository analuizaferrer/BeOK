//
//  AddRecordViewController.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/12/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData

class AddRecordViewController: UIViewController {
    
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var triggersLabel: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    var recordsList = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueToRecords") {
            // pass data to next view
            
            let nextVC = segue.destinationViewController as! RecordsTableViewController
            
            self.saveRecord(NSDate(), location: locationTextField.text!, triggers: triggersLabel.text!, symptoms: [], description: descriptionTextField.text!)
            
            nextVC.tableView.reloadData()
            
        }
    }
    
    @IBAction func confirmButton(sender: AnyObject) {
        
        performSegueWithIdentifier("segueToRecords", sender: self)
        
    }
    
    func saveRecord(date: NSDate, location: String, triggers: String, symptoms: [Symptom], description: String) {
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Record",
                                                        inManagedObjectContext:managedContext)
        
        let record = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        //3
        record.setValue(date, forKey: "date")
        record.setValue(location, forKey: "location")
        record.setValue(triggers, forKey: "triggers")
        record.setValue("", forKey: "symptoms")
        record.setValue(description, forKey: "attackDescription")
        
        
        //4
        do {
            try managedContext.save()
            //5
            recordsList.append(record)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

}
