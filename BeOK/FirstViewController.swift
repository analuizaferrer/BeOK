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
      

        
    }

  
  
  func animateBreathing() {
    
    let bigger:CGAffineTransform = CGAffineTransformMakeScale(2.0, 2.0)
    let smaller:CGAffineTransform = CGAffineTransformMakeScale(0.5, 0.5)

    let center:CGPoint = breathingCircle.center
    
    UIView.animateWithDuration(4.0, delay: 0.0, options: [], animations: {
      
      self.breathingCircle.transform = bigger
      self.breathingCircle.center = center
      

      }, completion: { _ in
        
        UIView.animateWithDuration(7.0, delay: 3.0, options: [], animations: {
          
          self.breathingCircle.transform = smaller
          self.breathingCircle.center = center
          
          
          }, completion: nil)
        
    })

    
    
    
  }

  
  override func viewDidAppear(animated: Bool) {
    

    
    let timer = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: #selector(FirstViewController.animateBreathing), userInfo: nil, repeats: true)
    timer.fire()
  
    

    
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidLayoutSubviews() {
//        playerLayer.frame = videoView.bounds
//    }
    
}

