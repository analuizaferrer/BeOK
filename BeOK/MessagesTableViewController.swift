//
//  MessagesTableViewController.swift
//  BeOK
//
//  Created by Helena Leitão on 14/07/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData

class MessagesTableViewController: UITableViewController {
    
    var messagesList = [NSManagedObject]()
    
    var checked: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSymptomsList()
        
        loadCheckedArray()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestMessage = NSFetchRequest(entityName: "Message")
        
        do {
            let resultsMessage = try managedContext.executeFetchRequest(fetchRequestMessage)
            messagesList = resultsMessage as! [NSManagedObject]
        }
        
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadSymptomsList () {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Message")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            messagesList = results as! [NSManagedObject]
        }
            
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func loadCheckedArray () {
        var i = 0
        while i < messagesList.count {
            checked.append(false)
            i += 1
        }
    }
    
    @IBAction func prepareForUnwindToMessages(segue: UIStoryboardSegue) {
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel!.numberOfLines = 0
    
        let thisMessage = messagesList[indexPath.row]
        cell.textLabel?.text = thisMessage.valueForKey("message") as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            let AppDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let context: NSManagedObjectContext = AppDel.managedObjectContext
            
            context.deleteObject(messagesList[indexPath.row] as NSManagedObject)
            messagesList.removeAtIndex(indexPath.row)
            
            do{
                try context.save()
            } catch {
                print("error")
            }
            
            self.tableView.reloadData()
        }
    }
}
