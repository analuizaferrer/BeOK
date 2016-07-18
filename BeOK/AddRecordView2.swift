//
//  AddRecordView2.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/16/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation

class AddRecordView2: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var symptomsLabel = UILabel(frame: CGRectMake(15,91,400,18))
    var otherSymptomTextField = UITextField(frame: CGRectMake(50,133,300,24))
    var symptomsTableView = UITableView(frame: CGRectMake(15, 172, 338, 300))
    var pageCounter = UIImageView(frame: CGRectMake(121.5, 606.8, 131, 26))
    
    var symptoms: [String] = ["Hyperventilation", "Dizziness", "Nausea", "Chest Pain", "Accelerated Heartbeat"]
    
    var recordSymptoms: [String]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.symptomsLabel.text = "What symptoms did you experience?"
        self.symptomsLabel.textColor = UIColor(red: 0.67, green: 0.73, blue: 1.56, alpha: 1)
        self.addSubview(symptomsLabel)
        
        self.otherSymptomTextField.text = "Other"
        self.addSubview(otherSymptomTextField)
        
        self.symptomsTableView.delegate = self
        self.symptomsTableView.dataSource = self
        self.symptomsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.addSubview(symptomsTableView)
        
        self.pageCounter.image = UIImage(named: "PageCounter2")
        self.addSubview(pageCounter)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.symptoms.count
    }
    
    var checked: [Bool] = [false, false, false, false, false]
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.symptomsTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
       
        UITableViewCell.appearance().tintColor = UIColor(red:0.26, green:0.29, blue:0.61, alpha:1.0)
        
        cell.textLabel?.text = self.symptoms[indexPath.row]
        
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