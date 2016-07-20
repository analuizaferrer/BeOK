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
    
    var sounds: [String] = []
    
    var urls: [NSURL] = []
    
    var checked: [Bool] = []
    
    var selectedSound: String!
    
    var lastSound:[NSManagedObject] = []
    var currentSound = [NSManagedObject]()
    
    let cicadasURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Cicadas noise", ofType: "mp3")!)
    let rainforestURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Rainforest sounds", ofType: "mp3")!)
    
    let lakeURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("lake", ofType: "wav")!)
    //let chuvaURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("chuva", ofType: "wav")!)
    let wavesURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("waves", ofType: "wav")!)
    
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewWillAppear(animated: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestSound = NSFetchRequest(entityName: "Sound")
        
        do {
            
            let soundRecord = try managedContext.executeFetchRequest(fetchRequestSound)
            currentSound = soundRecord as! [NSManagedObject]
            
            
        }
            
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        //lastSound.insert(currentSound[0], atIndex: 0)
       // print(" __ last sound  will appear : \(laSound[0])")
        self.selectedSound = currentSound[0].valueForKey("sound") as? String
        print(" __ selected sound will appear : \(selectedSound)")

        
        for sound in sounds {
            
            if sound == selectedSound{
                checked += [true]
            } else {
                checked += [false]
            }
        }
        print(checked)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sounds += ["Rainforest sounds", "Cicadas noise", "Lake", "Waves"]
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
        
        let soundEntity = NSEntityDescription.entityForName("Sound", inManagedObjectContext: managedContext)
        
        let sound = NSManagedObject(entity: soundEntity!, insertIntoManagedObjectContext: managedContext)
        
        //managedContext.deleteObject(currentSound[0] as NSManagedObject)
        
        sound.setValue(selectedSound, forKey: "sound")
        
        print(" __ selected sound  will disappear : \(selectedSound)")
        
        do {
            try managedContext.save()
            print("save successful")
        }
            
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        checked = []
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sounds.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        UITableViewCell.appearance().tintColor = UIColor(red:0.26, green:0.29, blue:0.61, alpha:1.0)
        
        cell.textLabel?.text = sounds[indexPath.row]
        
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
                selectedSound = sounds[indexPath.row]
//                print(" __ selected sound  did select : \(selectedSound)")

                for (index, _) in checked.enumerate() {
                    
                    if index != indexPath.row{
                        let otherCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
                        
                        otherCell?.accessoryType = .None
                    }
                }
            }
        }
    }
}
