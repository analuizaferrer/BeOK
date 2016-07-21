//
//  AddRecordView2.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/16/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AddRecordView2: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var symptomsLabel = UILabel(frame: CGRectMake(15,91,400,18))
    var otherSymptomTextField = UITextField(frame: CGRectMake(50,133,300,24))
    var symptomsTableView = UITableView()
    var pageCounter = UIImageView()
    
    var symptomsList = [NSManagedObject]()
    
    var checked: [Bool] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        symptomsTableView.frame = CGRectMake(0, 133, self.frame.width, 400)
        pageCounter = UIImageView(frame: CGRectMake(self.frame.midX - 65.5, self.frame.height - 39, 131, 26))
        
        self.symptomsLabel.text = "What symptoms did you experience?"
        self.symptomsLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.addSubview(symptomsLabel)
        
        self.otherSymptomTextField.placeholder = "Other"
        self.addSubview(otherSymptomTextField)
        
        self.symptomsTableView.delegate = self
        self.symptomsTableView.dataSource = self
        self.symptomsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.addSubview(symptomsTableView)
        
        self.pageCounter.image = UIImage(named: "PageCounter2")
        self.addSubview(pageCounter)
        
        loadSymptomsList()
        
        loadCheckedArray()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadSymptomsList () {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Symptom")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            symptomsList = results as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.symptomsList.count
    }
    
    func loadCheckedArray () {
       
        var i: Int = 0
       
        while i < symptomsList.count {
            checked.append(false)
            i += 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = self.symptomsTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
       
        UITableViewCell.appearance().tintColor = UIColor(red:0.26, green:0.29, blue:0.61, alpha:1.0)
        
        let thisSymptom = symptomsList[indexPath.row]
        cell.textLabel?.text = thisSymptom.valueForKey("symptom") as? String
        
        if !checked[indexPath.row] {
            cell.accessoryType = .None
        } else if checked[indexPath.row] {
            cell.accessoryType = .Checkmark
        }
       
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        if let cell = symptomsTableView.cellForRowAtIndexPath(indexPath) {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if cell.accessoryType == .Checkmark {
                cell.accessoryType = .None
                checked[indexPath.row] = false
            } else {
                cell.accessoryType = .Checkmark
                checked[indexPath.row] = true
            }
        }    
    }
}