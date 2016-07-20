//
//  RecordsTableViewController.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/11/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData

class RecordsTableViewController: UITableViewController {
    
    var recordsList = [NSManagedObject]()
    var symptomsList = [NSManagedObject]()
    var recordSymptomList = [NSManagedObject]()
    
    var symptomsCountArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! RecordsTableViewCell
        
        let thisRecord = recordsList[indexPath.row]
        
        cell.dayLabel.textColor = UIColor(red: 123/255, green: 123/255, blue: 123/255, alpha: 1)
        let dayFormatter: NSDateFormatter = NSDateFormatter()
        dayFormatter.dateFormat = "dd"
        let selectedDay: NSString = dayFormatter.stringFromDate(thisRecord.valueForKey("date") as! NSDate)
        cell.dayLabel.text = selectedDay as String
        
        cell.monthLabel.textColor = UIColor(red: 123/255, green: 123/255, blue: 123/255, alpha: 1)
        let monthFormatter: NSDateFormatter = NSDateFormatter()
        monthFormatter.dateFormat = "MMM"
        let selectedMonth: NSString = monthFormatter.stringFromDate(thisRecord.valueForKey("date") as! NSDate)
        cell.monthLabel.text = selectedMonth as String
        
        cell.descriptionLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        cell.descriptionLabel.text = thisRecord.valueForKey("attackDescription") as? String
        
//        let thisSymptomsCount = symptomsCountArray[indexPath.row]
//        
//        if thisSymptomsCount > 1 {
//            cell.symptomsLabel.text = "\(thisSymptomsCount) symptoms"
//        }
//        
//        else {
//            if thisSymptomsCount == 1 {
//                cell.symptomsLabel.text = "1 symptom"
//            }
//            
//            else {
//                cell.symptomsLabel.text = "No symptoms"
//            }
//        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordsList.count
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestRecord = NSFetchRequest(entityName: "Record")
        let fetchRequestSymptom = NSFetchRequest(entityName: "Symptom")
        let fetchRequestRecordSymptom = NSFetchRequest(entityName: "RecordSymptom")

        do {
            
            let resultsRecord = try managedContext.executeFetchRequest(fetchRequestRecord)
            recordsList = resultsRecord as! [NSManagedObject]
            
            let resultsSymptom = try managedContext.executeFetchRequest(fetchRequestSymptom)
            symptomsList = resultsSymptom as! [NSManagedObject]
            
            let resultsRecordSymptom = try managedContext.executeFetchRequest(fetchRequestRecordSymptom)
            recordSymptomList = resultsRecordSymptom as! [NSManagedObject]
        }
        
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
//        countSymptoms()
        
        self.tableView.reloadData()
    }
    
    func countSymptoms() {
        
        var i = 0
        while i < recordsList.count {
            
            var symptomsCount = 0
            
            var j = 0
            while j < recordSymptomList.count {
                
                if recordsList[i].objectID.description == recordSymptomList[j].valueForKey("recordID") as! String {
                    
                    var k = 0
                    while k < symptomsList.count {
                        
                        if recordSymptomList[j].valueForKey("symptomID") as! String == symptomsList[k].objectID.description {
                            
                            symptomsCount += 1
                            
                        }
                        
                        k += 1
                        
                    }
                    
                }
                
                j += 1
                
            }
            
            symptomsCountArray[i] = symptomsCount
            
            i += 1
            
        }

        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "segueToDetails" {
            
            let detailsVC = segue.destinationViewController as! RecordDetailsViewController
            detailsVC.record = recordsList[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

}
