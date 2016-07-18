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
    
    var firstView : AddRecordView1!
    var secondView : AddRecordView2!
    var thirdView: AddRecordView3!
    
    var recordsList = [NSManagedObject]()
    
    var recordSymptoms: [String]!
    
    var leftNavBarButton: UIBarButtonItem!
    var rightNavBarButton: UIBarButtonItem!
    
    var navItem: UINavigationItem!
    
//    var locationManager: CLLocationManager!
//    
//    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
//    let apikey = "YOUR_API_KEY"
//    
//    var location: CLLocation! {
//        
//        didSet {
//        
//            reverseGeocoding(location.coordinate.latitude, longitude: location.coordinate.longitude)
//            
//        }
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstView = AddRecordView1(frame: CGRectMake(0,0,view.frame.width,view.frame.height))
        self.secondView = AddRecordView2(frame: CGRectMake(0,0,view.frame.width,view.frame.height))
        self.thirdView = AddRecordView3(frame: CGRectMake(0,0,view.frame.width,view.frame.height))
        
        self.view = firstView
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
       
        navItem = UINavigationItem(title: "New Record")
        
        rightNavBarButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(self.rightBarButtonAction))
        navItem.rightBarButtonItem = rightNavBarButton
        
       
        leftNavBarButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(self.leftBarButtonAction))
        navItem.leftBarButtonItem = leftNavBarButton
        
        self.navigationController?.navigationBar.setItems([navItem], animated: false)

    }
    
    func rightBarButtonAction(sender: UIBarButtonItem) {
        
        if self.view == firstView {
            self.view = secondView
            leftNavBarButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(self.leftBarButtonAction))
            navItem.leftBarButtonItem = leftNavBarButton
        }
        
        else {
            
            if self.view == secondView {
                rightNavBarButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(self.rightBarButtonAction))
                navItem.rightBarButtonItem = rightNavBarButton
                self.view = thirdView
            }
            
            else {
                if self.view == thirdView {
                    performSegueWithIdentifier("segueToRecords", sender: self)
                }
            }
        }
        
    }
    
    func leftBarButtonAction(sender: UIBarButtonItem) {
        
        if self.view == thirdView {
            self.view = secondView
            rightNavBarButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(self.rightBarButtonAction))
            navItem.rightBarButtonItem = rightNavBarButton
        }
        
        else {
            
            if self.view == secondView {
                self.view = firstView
                leftNavBarButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(self.leftBarButtonAction))
                navItem.leftBarButtonItem = leftNavBarButton
            }
            
            else {
                if self.view == firstView {
                    performSegueWithIdentifier("segueToRecords", sender: self)
                }
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueToRecords") {
            // pass data to next view
            
            let nextVC = segue.destinationViewController as! RecordsTableViewController
            
            if self.view == thirdView {
                self.saveRecord(firstView.date, duration: firstView.durationValue, location: firstView.locationTextField.text!, symptoms: [], description: thirdView.descriptionTextField.text!)
            }
            
            nextVC.tableView.reloadData()
            
        }
    }
    
    func saveRecord(date: NSDate, duration: Int, location: String, symptoms: [Symptom], description: String) {
        
        loadSymptomsArray(secondView.symptoms, symptomsBool: secondView.checked, other: secondView.otherSymptomTextField.text!)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Record", inManagedObjectContext:managedContext)
        
        let record = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
    
        record.setValue(date, forKey: "date")
        record.setValue(duration, forKey: "duration")
        record.setValue(location, forKey: "location")
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
    
    func loadSymptomsArray (symptomsNames: [String], symptomsBool: [Bool], other: String) {
        
        var i = 0
        
        for symptom in symptomsBool {
            
            if symptom == true {
                recordSymptoms.append(symptomsNames[i])
            }
            
            i += 1
        }
        
        if other != "Other" {
            recordSymptoms.append(other)
        }
        
    }

//
//    @IBAction func updateLocationAction(sender: AnyObject) {
//        
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        checkCoreLocationPermission()
//        
//    }
//    
//    func checkCoreLocationPermission () {
//        
//        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
//            
//            locationManager.startUpdatingLocation()
//            
//        }
//        
//        else if CLLocationManager.authorizationStatus() == .NotDetermined {
//            
//            locationManager.requestWhenInUseAuthorization()
//            
//            locationManager.startUpdatingLocation()
//            
//        }
//        
//        else {
//            
//            let alert = UIAlertController(title: "Hold Up...", message: "Before you continue, Be OK wants access to your location. Turn on Location Services in your device settings.", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//            
//        }
//        
//    }
    
    // MARK: - CLLocatioManagerDelegate
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        location = locations.last
//        
//        locationManager.stopUpdatingLocation()
//        
//    }
//    
//    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
//            if error != nil {
//                print(error)
//                return
//            }
//            else if placemarks?.count > 0 {
//                let pm = placemarks![0]
//                let address = ABCreateStringWithAddressDictionary(pm.addressDictionary!, false)
//                self.locationTextField.text = "\(address)"
//                if pm.areasOfInterest?.count > 0 {
//                    let areaOfInterest = pm.areasOfInterest?[0]
//                    self.locationTextField.text = "\(areaOfInterest!)"
//                }
//            }
//        })
//    }

}
