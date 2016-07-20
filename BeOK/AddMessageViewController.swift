//
//  AddMessageViewController.swift
//  BeOK
//
//  Created by Helena Leitão on 20/07/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData

class AddMessageViewController: UIViewController, UITextViewDelegate {
    
    var placeholder: UILabel = UILabel()
    
    @IBOutlet weak var newMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // Do any additional setup after loading the view.
        placeholder.frame = CGRectMake(5.0, 0, newMessage.bounds.width - 5, 30)
        placeholder.text = "Enter your coping message..."
        placeholder.textColor = UIColor.lightGrayColor()
        placeholder.textAlignment = .Left
        
        newMessage.addSubview(placeholder)
        newMessage.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        newMessage.contentOffset = CGPointZero
    }
    
    func textViewDidChange(textView: UITextView) {
        if newMessage.text.characters.count != 0 {
            placeholder.text = ""
        } else {
            placeholder.text = "Enter your coping message..."
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        if newMessage.text.characters.count != 0 {
            let alert = UIAlertController(title: "Are you sure you want to delete your message registration?", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let removeCurrentProduct = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction) in
                self.performSegueWithIdentifier("backToMessages", sender: self)
            })
            
            alert.addAction(removeCurrentProduct)
            
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(cancel)
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
                performSegueWithIdentifier("backToMessages", sender: self)
        }
    }
    
    @IBAction func done(sender: AnyObject) {
        saveRecord(newMessage.text)
        performSegueWithIdentifier("backToMessages", sender: self)
    }
    
    func saveRecord(newMessage: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let messageEntity = NSEntityDescription.entityForName("Message", inManagedObjectContext: managedContext)
        
        let message = NSManagedObject(entity: messageEntity!, insertIntoManagedObjectContext: managedContext)
            
            message.setValue(newMessage, forKey: "message")
        
        do {
            try managedContext.save()
            print("save successful")
        }
            
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
