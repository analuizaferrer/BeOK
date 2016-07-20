//
//  AddRecordView1.swift
//  BeOK
//
//  Created by Ana Luiza Ferrer on 7/15/16.
//  Copyright © 2016 Ana Luiza Ferrer. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import AddressBookUI

protocol AddRecordDelegate {
    func showAlert ()
}

class AddRecordView1: UIView, CLLocationManagerDelegate {
    
    var delegate: AddRecordDelegate?
    
    var dateLabel = UILabel(frame: CGRectMake(15.3,91,400,18))
    var datePicker = UIDatePicker(frame: CGRectMake(15,129,323,146))
    var durationLabel = UILabel(frame: CGRectMake(15,308,400,18))
    var durationRead = UILabel(frame: CGRectMake(48,349,65,24))
    var durationPlusButton = UIButton(frame: CGRectMake(130,343,18,36))
    var durationMinusButton = UIButton(frame: CGRectMake(15,337,18,48))
    var locationLabel = UILabel(frame: CGRectMake(15,400,200,18))
    var locationTextField = UITextField(frame: CGRectMake(15,433,350,20))
    var getLocationButton = UIButton(frame: CGRectMake(170,400,200,18))
    var pageCounter = UIImageView()
  
    var durationValue = 30
    var date: NSDate!
    
    var locationManager: CLLocationManager!
    
    let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
    let apikey = "YOUR_API_KEY"
    
    var location: CLLocation! {
        
        didSet {
            
            reverseGeocoding(location.coordinate.latitude, longitude: location.coordinate.longitude)
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        pageCounter = UIImageView(frame: CGRectMake(self.frame.midX - 65.5, self.frame.height - 39, 131, 26))
        
        self.dateLabel.text = "When was the panic attack?"
        self.dateLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.addSubview(dateLabel)
        
        date = NSDate()
        self.datePicker.frame = CGRectMake(0, 129, self.frame.width, 146)
        self.datePicker.addTarget(self, action: #selector(datePickerAction), forControlEvents: .ValueChanged)
        self.datePicker.maximumDate = NSDate()
        self.addSubview(datePicker)
        
        self.durationLabel.text = "How long did it last?"
        self.durationLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.addSubview(durationLabel)
        
        self.durationRead.text = "\(durationValue) min"
        self.addSubview(durationRead)
        
        self.addSubview(durationPlusButton)
        self.durationPlusButton.setTitle("+", forState: UIControlState.Normal)
        self.durationPlusButton.setTitleColor(UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1), forState: UIControlState.Normal)
        self.durationPlusButton.addTarget(self, action: #selector(increaseDurationValue), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(durationMinusButton)
        self.durationMinusButton.setTitle("-", forState: UIControlState.Normal)
        self.durationMinusButton.setTitleColor(UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1), forState: UIControlState.Normal)
        self.durationMinusButton.addTarget(self, action: #selector(decreaseDurationValue), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.locationLabel.text = "Where were you?"
        self.locationLabel.textColor = UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1)
        self.addSubview(locationLabel)
        
        self.getLocationButton.setTitle("Get Current Location", forState: UIControlState.Normal)
        self.getLocationButton.setTitleColor(UIColor(red: 67/255, green: 73/255, blue: 156/255, alpha: 1), forState: UIControlState.Normal)
        self.getLocationButton.addTarget(self, action: #selector(updateLocationAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(getLocationButton)
        
        self.locationTextField.placeholder = "i.e. office, home etc"
        self.addSubview(locationTextField)
        
        self.pageCounter.image = UIImage(named: "PageCounter1")
        self.addSubview(pageCounter)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func datePickerAction(sender: UIDatePicker){
        
        date = sender.date
        
    }
    
    func increaseDurationValue (sender: UIButton) {
        durationValue += 5
        durationRead.text = "\(durationValue) min"
    }
    
    func decreaseDurationValue (sender: UIButton) {
        durationValue -= 5
        if durationValue < 0 {
            durationValue = 0
        }
        durationRead.text = "\(durationValue) min"
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
            self.delegate?.showAlert()
        }
        
    }
    
    //MARK: - CLLocatioManagerDelegate
    
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

    
}