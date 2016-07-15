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
    
//    var recordsList: [Item] = []
    
    var recordsList = [NSManagedObject]()
    
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
        
        cell.dateLabel.text = "No date yet"
        cell.descriptionLabel.text = thisRecord.valueForKey("attackDescription") as? String
        
//        let symptomsCount = thisRecord.symptoms?.count
//        
//        if symptomsCount > 1 {
//            cell.symptomsLabel.text = "\(symptomsCount!) symptoms"
//        }
//        
//        else {
//            if symptomsCount == 1 {
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
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Record")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            recordsList = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        self.tableView.reloadData()
    }
}
