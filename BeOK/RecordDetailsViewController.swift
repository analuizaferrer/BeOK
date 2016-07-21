//
//  RecordDetailsViewController.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/18/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData

class RecordDetailsViewController: UIViewController {
    
    var record: NSManagedObject!
    
    var symptomsList = [NSManagedObject]()
    var recordSymptomList = [NSManagedObject]()
    
    var thisRecordSymptomsList: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        getLists()
        
        let weekDayLabel = UILabel(frame: CGRectMake(14.5,91.5,300,18))
        let weekDayFormatter: NSDateFormatter = NSDateFormatter()
        weekDayFormatter.dateFormat = "EEEE"
        let selectedWeekDay: NSString = weekDayFormatter.stringFromDate(record.valueForKey("date") as! NSDate)
        weekDayLabel.text = selectedWeekDay as String
        self.view.addSubview(weekDayLabel)
        
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM d H:mm a"
        let selectedDate: NSString = dateFormatter.stringFromDate(record.valueForKey("date") as! NSDate)
        let dateLabel = UILabel(frame: CGRectMake(14.5,106.5,400,24))
        dateLabel.text = selectedDate as String
        self.view.addSubview(dateLabel)
        
        var height: CGFloat = 150.5
        
        let locationLabel = UILabel(frame: CGRectMake(15,height,400,20))
        locationLabel.text = record.valueForKey("location") as? String
        self.view.addSubview(locationLabel)
        if record.valueForKey("location") as? String != "" {
            height = 191
        }
        
        let symptomsLabel = UILabel(frame: CGRectMake(15.59,height,400,18))
        if thisRecordSymptomsList.count > 1 {
            symptomsLabel.text = "\(thisRecordSymptomsList.count) symptoms"
            height += 8
        }
        else {
            if thisRecordSymptomsList.count == 1 {
                symptomsLabel.text = "1 symptom"
                height += 8
            }
            else {
                symptomsLabel.text = "No symptoms"
            }
        }
        symptomsLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.view.addSubview(symptomsLabel)
        
        var i = 0
        while i < thisRecordSymptomsList.count {
            height += 20
            let symptomsListLabel = UILabel(frame: CGRectMake(15.39,height,400,20))
            symptomsListLabel.text = "\(thisRecordSymptomsList[i])"
            symptomsListLabel.sizeToFit()
            symptomsListLabel.numberOfLines = 0
            self.view.addSubview(symptomsListLabel)
            
            i += 1
        }
        
        height += 40
        
        let descriptionHeaderLabel = UILabel(frame: CGRectMake(15.2,height,400,18))
        descriptionHeaderLabel.text = "What went through your head?"
        descriptionHeaderLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.view.addSubview(descriptionHeaderLabel)
        
        height += 28
        
        let descriptionBodyLabel = UILabel(frame: CGRectMake(15.2,height,299,80))
        descriptionBodyLabel.text = record.valueForKey("attackDescription") as? String
        descriptionBodyLabel.numberOfLines = 0
        descriptionBodyLabel.sizeToFit()
        self.view.addSubview(descriptionBodyLabel)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getLists() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
    
        let fetchRequestSymptom = NSFetchRequest(entityName: "Symptom")
        let fetchRequestRecordSymptom = NSFetchRequest(entityName: "RecordSymptom")
        
        do {
            
            let resultsSymptom = try managedContext.executeFetchRequest(fetchRequestSymptom)
            symptomsList = resultsSymptom as! [NSManagedObject]
            
            let resultsRecordSymptom = try managedContext.executeFetchRequest(fetchRequestRecordSymptom)
            recordSymptomList = resultsRecordSymptom as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        getSymptoms()
    }
    
    func getSymptoms() {
        
        thisRecordSymptomsList = [String]()
    
        var j = 0
        while j < recordSymptomList.count {
                
            if record.objectID.URIRepresentation().absoluteString == recordSymptomList[j].valueForKey("recordID") as! String {
                    
                var k = 0
                while k < symptomsList.count {
                        
                    if recordSymptomList[j].valueForKey("symptomID") as! String == symptomsList[k].objectID.URIRepresentation().absoluteString {
                    
                        thisRecordSymptomsList.append(symptomsList[k].valueForKey("symptom") as! String)
                    }
                        
                    k += 1
                }
            }
                
            j += 1
        }
    }
}