//
//  SoundsTableViewController.swift
//  BeOK
//
//  Created by Helena Leitão on 18/07/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class SoundsTableViewController: UITableViewController {
    
    var soundsNames: [String] = []
    
    var urls: [NSURL] = []
    
    var checked: [Bool] = []
    
    var selectedSound: String!
    
    var lastSound:[NSManagedObject] = []
    var sounds = [NSManagedObject]()
    
    let cicadasURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Cicadas", ofType: "mp3")!)
    
    let rainforestURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Rainforest", ofType: "mp3")!)
    
    let lakeURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Lake", ofType: "wav")!)
    
    let wavesURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Waves", ofType: "wav")!)
    
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewWillAppear(animated: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestSound = NSFetchRequest(entityName: "Sound")
        
        do {
            let soundRecord = try managedContext.executeFetchRequest(fetchRequestSound)
            sounds = soundRecord as! [NSManagedObject]
        }
            
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
 
        var i: Int = 0
        
        while i < sounds.count {
            
            if sounds[i].valueForKey("active") as? Bool == true {
                checked += [true]
            } else {
                checked += [false]
            }
            
            i += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundsNames += ["Rainforest", "Cicadas", "Lake", "Waves"]
        urls += [rainforestURL, cicadasURL, lakeURL, wavesURL]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Be Okay - personal comfort zone
    // Comfort Zone - it's gonna be okay
    //
    
    override func viewWillDisappear(animated: Bool) {
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestSound = NSFetchRequest(entityName: "Sound")
        
        do {
            let resultsSound = try managedContext.executeFetchRequest(fetchRequestSound)
            sounds = resultsSound as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        var i: Int = 0
        
        while i < sounds.count {
            sounds[i].setValue(checked[i], forKey: "active")
            
            do {
                try managedContext.save()
            }
            
            catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            i += 1
        }
        
        checked = []
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return soundsNames.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        UITableViewCell.appearance().tintColor = UIColor(red:0.26, green:0.29, blue:0.61, alpha:1.0)
        
        cell.textLabel?.text = soundsNames[indexPath.row]
        
        if !checked[indexPath.row] {
            cell.accessoryType = .None
        } else if checked[indexPath.row] {
            cell.accessoryType = .Checkmark
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: urls[indexPath.row], fileTypeHint: nil)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            }
            catch let error as NSError {
                print(error.description)
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if cell.accessoryType == .None {
                
                cell.accessoryType = .Checkmark
                checked[indexPath.row] = true

                for (index, _) in checked.enumerate() {
                    
                    if index != indexPath.row{
                        let otherCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
                        checked[index] = false
                        otherCell?.accessoryType = .None
                    }
                }
            }
        }
    }
}
