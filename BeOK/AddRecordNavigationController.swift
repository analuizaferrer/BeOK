//
//  AddRecordNavigationController.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/16/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation

class AddRecordNavigationController: UINavigationController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status bar white font
        self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.tintColor = UIColor.whiteColor()
        
        let btnName = UIButton()
        btnName.setTitle("jfewlf", forState: UIControlState.Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: Selector("action"), forControlEvents: .TouchUpInside)
    }
}