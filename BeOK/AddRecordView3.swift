//
//  AddRecordView3.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/16/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation

class AddRecordView3: UIView {
    
    var descriptionLabel = UILabel(frame: CGRectMake(14.53,91,400,18))
    var descriptionTextField = UITextField(frame: CGRectMake(14.53,121,327.55,200))
    var pageCounter = UIImageView(frame: CGRectMake(121.5, 606.8, 131, 26))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.descriptionLabel.text = "What went through your head?"
        self.descriptionLabel.textColor = UIColor(red: 0.67, green: 0.73, blue: 1.56, alpha: 1)
        self.addSubview(descriptionLabel)
        self.descriptionTextField.text = "kwlmel"
        self.descriptionTextField.contentVerticalAlignment = .Top
        self.addSubview(descriptionTextField)
        self.pageCounter.image = UIImage(named: "PageCounter3")
        self.addSubview(pageCounter)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.addGestureRecognizer(tap)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
}