//
//  AddRecordView1.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/15/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation

class AddRecordView1: UIView {
    
    var dateLabel = UILabel(frame: CGRectMake(15.3,91,400,18))
    var datePicker = UIDatePicker(frame: CGRectMake(15,129,323,146))
    var durationLabel = UILabel(frame: CGRectMake(15,308,400,18))
    var durationRead = UILabel(frame: CGRectMake(48,349,65,24))
    var durationPlusButton = UIButton(frame: CGRectMake(130,343,18,36))
    var durationMinusButton = UIButton(frame: CGRectMake(15,337,18,48))
    var locationLabel = UILabel(frame: CGRectMake(15,400,200,18))
    var locationTextField = UITextField(frame: CGRectMake(15,433,49,20))
    var getLocationButton = UIButton(frame: CGRectMake(170,400,200,18))
    var pageCounter = UIImageView(frame: CGRectMake(121.5, 606.8, 131, 26))
    
    var durationValue = 30
    var date: NSDate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.dateLabel.text = "When was the panic attack?"
        self.dateLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.addSubview(dateLabel)
        
        date = NSDate()
        self.datePicker.addTarget(self, action: #selector(datePickerAction), forControlEvents: .ValueChanged)
        self.addSubview(datePicker)
        
        self.durationLabel.text = "How long did it last?"
        self.durationLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.addSubview(durationLabel)
        
        self.durationRead.text = "\(durationValue) min"
        self.addSubview(durationRead)
        
        self.addSubview(durationPlusButton)
        self.durationPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.durationPlusButton.setTitleColor(UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1), forState: UIControlState.Normal)
        self.durationPlusButton.addTarget(self, action: #selector(increaseDurationValue), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(durationMinusButton)
        self.durationMinusButton.setTitle("-", forState: UIControlState.Normal)
        self.durationMinusButton.setTitleColor(UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1), forState: UIControlState.Normal)
        self.durationMinusButton.addTarget(self, action: #selector(decreaseDurationValue), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.locationLabel.text = "Where were you?"
        self.locationLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.addSubview(locationLabel)
        
        self.locationTextField.text = "Office"
        self.addSubview(locationTextField)
        
        self.getLocationButton.setTitle("Get Current Location", forState: UIControlState.Normal)
        self.getLocationButton.setTitleColor(UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1), forState: UIControlState.Normal)
        self.addSubview(getLocationButton)
        
        self.pageCounter.image = UIImage(named: "PageCounter1")
        self.addSubview(pageCounter)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func datePickerAction(sender: UIDatePicker){
        
        date = sender.date
        
    }
    
    func increaseDurationValue (sender: UIButton) {
        durationValue += 1
        durationRead.text = "\(durationValue) min"
    }
    
    func decreaseDurationValue (sender: UIButton) {
        durationValue -= 1
        durationRead.text = "\(durationValue) min"
    }
    
}