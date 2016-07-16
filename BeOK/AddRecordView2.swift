//
//  AddRecordView2.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/16/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation

class AddRecordView2: UIView {
    
    var symptomsLabel = UILabel(frame: CGRectMake(15,91,400,18))
    var otherSymptomTextField = UITextField(frame: CGRectMake(50,133,50,24))
    var symptom1Label = UIButton(frame: CGRectMake(51,167,300,24))
    var symptom2Label = UIButton(frame: CGRectMake(51,201,300,24))
    var symptom3Label = UIButton(frame: CGRectMake(51,235,300,24))
    var symptom4Label = UIButton(frame: CGRectMake(51,269,300,24))
    var symptom5Label = UIButton(frame: CGRectMake(51,303,300,24))
    var pageCounter = UIImageView(frame: CGRectMake(121.5, 606.8, 131, 26))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.symptomsLabel.text = "What symptoms did you experience?"
        self.symptomsLabel.textColor = UIColor(red: 0.67, green: 0.73, blue: 1.56, alpha: 1)
        self.addSubview(symptomsLabel)
        self.otherSymptomTextField.text = "Other"
        self.addSubview(otherSymptomTextField)
        self.symptom1Label.setTitle("Hyperventilation", forState: UIControlState.Normal)
        self.symptom1Label.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.symptom1Label.contentHorizontalAlignment = .Left
        self.addSubview(symptom1Label)
        self.symptom2Label.setTitle("Dizziness", forState: UIControlState.Normal)
        self.symptom2Label.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.symptom2Label.contentHorizontalAlignment = .Left
        self.addSubview(symptom2Label)
        self.symptom3Label.setTitle("Nausea", forState: UIControlState.Normal)
        self.symptom3Label.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.symptom3Label.contentHorizontalAlignment = .Left
        self.addSubview(symptom3Label)
        self.symptom4Label.setTitle("Chest Pain", forState: UIControlState.Normal)
        self.symptom4Label.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.symptom4Label.contentHorizontalAlignment = .Left
        self.addSubview(symptom4Label)
        self.symptom5Label.setTitle("Accelerated Heartbeat", forState: UIControlState.Normal)
        self.symptom5Label.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.symptom5Label.contentHorizontalAlignment = .Left
        self.addSubview(symptom5Label)
        self.pageCounter.image = UIImage(named: "PageCounter2")
        self.addSubview(pageCounter)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}