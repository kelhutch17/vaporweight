//
//  LocationSingleton.swift
//  vaporweight
//
//  Created by Kelly Hutchison on 5/14/16.
//  Copyright © 2016 Kelly Hutchison. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManagerSingleton: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationManagerSingleton()
    var locationManager = CLLocationManager()
    var currentLocation:CLLocation?
    let model = Model.sharedInstance
    
    var notificationKey:String?
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        notificationKey = model.notificationKey()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: nil, name: notificationKey, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.currentLocation = newLocation
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
    }
    
    // If location authorization changes, handle it here
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        // Conform to user's preferences
        if status == .AuthorizedWhenInUse {
            startUpdatingLocation()
        } else {
            stopUpdatingLocation()
        }
        
        // send notification here to alert other view controllers using the location manager singleton
        NSNotificationCenter.defaultCenter().postNotificationName(notificationKey!, object: status as? AnyObject)
    }
}
