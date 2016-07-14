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
    
    let playerLayer = AVPlayerLayer()
    
    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
//        let filePath = NSBundle.mainBundle().pathForResource(videoName, ofType: "mov")
//        
//        let fileUrl = NSURL(fileURLWithPath: filePath!)
//        player = AVPlayer(URL: fileUrl)
//        
//        playerLayer.player = player
//        videoView.layer.addSublayer(playerLayer)
//        
//        player.play()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidLayoutSubviews() {
//        playerLayer.frame = videoView.bounds
//    }
    
}

