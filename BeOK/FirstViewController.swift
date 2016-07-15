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

class FirstViewController: UIViewController {

    @IBOutlet weak var copingMessage: UILabel!
    
    @IBOutlet weak var videoView: UIView!
    
    var videoName: String!
    
  @IBOutlet weak var breathingCircle: UIImageView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
      UIView.animateWithDuration(1.6, delay: 0.0, options: [], animations: {
        
        //breathingCircle.
        
        
        }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidLayoutSubviews() {
//        playerLayer.frame = videoView.bounds
//    }
    
}

