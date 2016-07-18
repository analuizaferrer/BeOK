//
//  RecordDetailsView.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/18/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation

class RecordDetailsView: UIView {
    
    var dateLabel = UILabel(frame: CGRectMake(15.3,91,400,18))
    var locationLabel = UILabel(frame: CGRectMake(15,400,200,18))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.dateLabel.text = "When was the panic attack?"
        self.dateLabel.textColor = UIColor(red: 0.67, green: 0.73, blue: 1.56, alpha: 1)
        self.addSubview(dateLabel)
        
        self.locationLabel.text = "Where were you?"
        self.locationLabel.textColor = UIColor(red: 0.67, green: 0.73, blue: 1.56, alpha: 1)
        self.addSubview(locationLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}