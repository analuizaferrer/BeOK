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
        
        let symptomsLabel = UILabel(frame: CGRectMake(15.59,259,400,18))
        symptomsLabel.text = "# symptoms"
        symptomsLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.view.addSubview(symptomsLabel)
        
        let descriptionHeaderLabel = UILabel(frame: CGRectMake(15.2,367,400,18))
        descriptionHeaderLabel.text = "What went through your head?"
        descriptionHeaderLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.view.addSubview(descriptionHeaderLabel)
        
        let descriptionBodyLabel = UILabel(frame: CGRectMake(15.2,395,299,80))
        descriptionBodyLabel.text = record.valueForKey("attackDescription") as! String
        descriptionBodyLabel.numberOfLines = 3
        descriptionBodyLabel.sizeToFit()
        self.view.addSubview(descriptionBodyLabel)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
