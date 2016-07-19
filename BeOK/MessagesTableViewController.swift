//
//  MessagesTableViewController.swift
//  BeOK
//
//  Created by Helena Leitão on 14/07/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
 
    var copingMessages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        copingMessages += ["You're gonna be okay.", "You can get through this.", "I am proud of you. Good job.", "Concentrate on your breathing. Stay in the present.", "It's not the place that is bothering you; it's the thought.", "What you are feeling is scary, but it is not dangerous."]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return copingMessages.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
       
        cell.textLabel!.numberOfLines = 0
        cell.textLabel?.text = copingMessages[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }

    @IBAction func addMessage(sender: AnyObject) {
        
    }
}
