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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
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
        
        let locationLabel = UILabel(frame: CGRectMake(15,150.5,400,20))
        locationLabel.text = record.valueForKey("location") as! String
        self.view.addSubview(locationLabel)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
