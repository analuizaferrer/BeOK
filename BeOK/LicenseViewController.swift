//
//  LicenseViewController.swift
//  BeOK
//
//  Created by Helena Leitão on 21/07/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit

class LicenseViewController: UIViewController {

    @IBOutlet weak var licensesText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        licensesText.contentOffset = CGPointZero
    }
}
