//
//  RecordViewController.swift
//  BeOK
//
//  Created by Helena Leitão on 14/07/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let V1: View1 = View1(nibName: "View1", bundle: nil)
        
        let V2: View2 = View2(nibName: "View2", bundle: nil)
        
        let V3: View3 = View3(nibName: "View3", bundle: nil)
    
        self.addChildViewController(V1)
        self.recordScrollView.addSubview(V1.view)
        V1.didMoveToParentViewController(self)
        
        self.addChildViewController(V2)
        self.recordScrollView.addSubview(V2.view)
        V2.didMoveToParentViewController(self)
        
        self.addChildViewController(V3)
        self.recordScrollView.addSubview(V3.view)
        V3.didMoveToParentViewController(self)
        
        var V2Frame: CGRect = V2.view.frame
        V2Frame.origin.x = self.view.frame.width
        V2.view.frame = V2Frame
        
        var V3Frame: CGRect = V3.view.frame
        V3Frame.origin.x = 2 * self.view.frame.width
        V3.view.frame = V3Frame
        
        self.recordScrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
