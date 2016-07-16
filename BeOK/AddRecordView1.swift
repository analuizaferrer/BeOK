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
    var locationLabel = UILabel(frame: CGRectMake(15,400,400,18))
    var locationTextField = UITextField(frame: CGRectMake(15,433,49,20))
    var pageCounter = UIImageView(frame: CGRectMake(121.5, 606.8, 131, 26))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.dateLabel.text = "When was the panic attack?"
        self.dateLabel.textColor = UIColor(red: 0.67, green: 0.73, blue: 1.56, alpha: 1)
        self.addSubview(dateLabel)
        self.addSubview(datePicker)
        self.durationLabel.text = "How long did it last?"
        self.durationLabel.textColor = UIColor(red: 0.67, green: 0.73, blue: 1.56, alpha: 1)
        self.addSubview(durationLabel)
        self.durationRead.text = "30 min"
        self.addSubview(durationRead)
        self.addSubview(durationPlusButton)
        self.durationPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.durationPlusButton.setTitleColor(UIColor(red: 0.67, green: 0.73, blue: 1.56, alpha: 1), forState: UIControlState.Normal)
        self.addSubview(durationMinusButton)
        self.durationMinusButton.setTitle("-", forState: UIControlState.Normal)
        self.durationMinusButton.setTitleColor(UIColor(red: 0.67, green: 0.73, blue: 1.56, alpha: 1), forState: UIControlState.Normal)
        self.locationLabel.text = "Where were you?"
        self.locationLabel.textColor = UIColor(red: 0.67, green: 0.73, blue: 1.56, alpha: 1)
        self.addSubview(locationLabel)
        self.locationTextField.text = "Office"
        self.addSubview(locationTextField)
        self.pageCounter.image = UIImage(named: "PageCounter1")
        self.addSubview(pageCounter)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}