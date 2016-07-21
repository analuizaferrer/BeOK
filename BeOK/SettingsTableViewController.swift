//
//  SettingsTableViewController.swift
//  BeOK
//
//  Created by Helena Leitão on 14/07/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            performSegueWithIdentifier("segueToMessages", sender: self)
        } else if indexPath.section == 0 && indexPath.row == 1 {
            performSegueWithIdentifier("segueToSounds", sender: self)
        } else if indexPath.section == 1 && indexPath.row == 0 {
            performSegueWithIdentifier("segueToLicense", sender: self)
        }
    }
}
