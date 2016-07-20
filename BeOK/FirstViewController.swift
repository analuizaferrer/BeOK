//
//  FirstViewController.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/11/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import CoreData

class FirstViewController: UIViewController {
    
    @IBOutlet weak var copingMessage: UILabel!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var outButton: UIButton!
    
    var audioURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("waves", ofType: "wav")!)
    
    var audioPlayer = AVAudioPlayer()
    
    var breathingTimer = NSTimer()
    
    @IBOutlet weak var breathingCircle: UIImageView!
    
    var copingMessages = [NSManagedObject]()
    
    var index = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.outButton.hidden = true
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequestMessages = NSFetchRequest(entityName: "Message")

        do {
            
            let resultsMessages = try managedContext.executeFetchRequest(fetchRequestMessages)
            copingMessages = resultsMessages as! [NSManagedObject]

        }
            
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
    }
    
    func animateBreathing() {
        
        let bigger:CGAffineTransform = CGAffineTransformMakeScale(2.0, 2.0)
        let smaller:CGAffineTransform = CGAffineTransformMakeScale(0.7, 0.7)
        
        let center:CGPoint = breathingCircle.center
        
        if index == copingMessages.count {
            index = 0
        }
        
        let thisMessage = copingMessages[index]
        
        self.copingMessage.text = thisMessage.valueForKey("message") as? String
        
        UIView.animateWithDuration(4.0, delay: 0.0, options: [], animations: {
            
            self.centerButton.hidden = false
            self.outButton.hidden = true
            
            self.breathingCircle.transform = bigger
            self.breathingCircle.center = center
            
            
            }, completion: { _ in
                
                
                UIView.animateWithDuration(3.0, delay: 0.0, options: [], animations: {
                    
                    self.centerButton.setTitle("HOLD", forState: .Normal)
                    
                    if self.centerButton.alpha == 1.0{
                        self.centerButton.alpha = 0.9
                    } else {
                        self.centerButton.alpha = 1.0
                    }
                    
                    }, completion: { _ in
                        
                        self.centerButton.hidden = true
                        self.outButton.hidden = false
                        
                        UIView.animateWithDuration(7.0, delay: 0.0, options: [], animations: {
                            
                            self.breathingCircle.transform = smaller
                            self.breathingCircle.center = center
                            self.centerButton.setTitle("IN", forState: .Normal)
                            
                            }, completion: nil)
                })
        })
        
        self.index += 1
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        breathingTimer = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: #selector(FirstViewController.animateBreathing), userInfo: nil, repeats: true)
        
        breathingTimer.fire()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: audioURL, fileTypeHint: nil)
            audioPlayer.play()
        }
        catch let error as NSError {
            print(error.description)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        audioPlayer.stop()
        breathingTimer.invalidate()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

