//
//  SoundsTableViewController.swift
//  BeOK
//
//  Created by Helena Leitão on 18/07/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import AVFoundation

class SoundsTableViewController: UITableViewController {
    
    var sounds: [String] = []
    
    var urls: [NSURL] = []
    
    var checked: [Bool] = []
    
    var selectedSound: String!
    
    let cicadasURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Cicadas noise", ofType: "mp3")!)
    let rainforestURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Rainforest sounds", ofType: "mp3")!)
    
    let lakeURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("lake", ofType: "wav")!)
    //let chuvaURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("chuva", ofType: "wav")!)
    let wavesURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("waves", ofType: "wav")!)
    
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sounds += ["Rainforest sounds", "Cicadas noise", "Lake", "Waves"]
        urls += [rainforestURL, cicadasURL, lakeURL, wavesURL]
        checked += [true, false, false, false]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        // salavar selectedSound no coredata
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
            print("entrou aqui 1")
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
