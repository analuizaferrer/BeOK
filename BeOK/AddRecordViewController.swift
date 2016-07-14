//
//  AddRecordViewController.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/12/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import AddressBookUI

class AddRecordViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var triggersLabel: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    var recordsList = [NSManagedObject]()
    
    var locationManager: CLLocationManager!
    
    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    let apikey = "YOUR_API_KEY"
    
    var location: CLLocation! {
        
        didSet {
        
            reverseGeocoding(location.coordinate.latitude, longitude: location.coordinate.longitude)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueToRecords") {
            // pass data to next view
            
            let nextVC = segue.destinationViewController as! RecordsTableViewController
            
            self.saveRecord(NSDate(), location: locationTextField.text!, triggers: triggersLabel.text!, symptoms: [], description: descriptionTextField.text!)
            
            nextVC.tableView.reloadData()
            
        }
    }
    
    @IBAction func confirmButton(sender: AnyObject) {
        
        performSegueWithIdentifier("segueToRecords", sender: self)
        
    }
    
    func saveRecord(date: NSDate, location: String, triggers: String, symptoms: [Symptom], description: String) {
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Record",
                                                        inManagedObjectContext:managedContext)
        
        let record = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
    
        record.setValue(date, forKey: "date")
        record.setValue(location, forKey: "location")
        record.setValue(triggers, forKey: "triggers")
        record.setValue("", forKey: "symptoms")
        record.setValue(description, forKey: "attackDescription")
        
        do {
            try managedContext.save()
            
            recordsList.append(record)
            
        }
        
        catch let error as NSError  {
            
            print("Could not save \(error), \(error.userInfo)")
        
        }
    }
    
    @IBAction func updateLocationAction(sender: AnyObject) {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()
        
    }
    
    func checkCoreLocationPermission () {
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
        }
        
        else if CLLocationManager.authorizationStatus() == .NotDetermined {
            
            locationManager.requestWhenInUseAuthorization()
            
            locationManager.startUpdatingLocation()
            
        }
        
        else {
            
            let alert = UIAlertController(title: "Hold Up...", message: "Before you continue, Be OK wants access to your location. Turn on Location Services in your device settings.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    // MARK: - CLLocatioManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        location = locations.last
        
        locationManager.stopUpdatingLocation()
        
    }
    
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            else if placemarks?.count > 0 {
                let pm = placemarks![0]
                let address = ABCreateStringWithAddressDictionary(pm.addressDictionary!, false)
                self.locationTextField.text = "\(address)"
                if pm.areasOfInterest?.count > 0 {
                    let areaOfInterest = pm.areasOfInterest?[0]
                    self.locationTextField.text = "\(areaOfInterest!)"
                }
            }
        })
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }


}
