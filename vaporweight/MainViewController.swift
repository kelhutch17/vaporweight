//
//  MainViewController.swift
//  vaporweight
//
//  Created by Kelly Hutchison on 5/14/16.
//  Copyright © 2016 Kelly Hutchison. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {

    let locationManager = LocationManagerSingleton.sharedInstance
    let model = Model.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // subscripe to weight session notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sessionStarted", name: model.sessionStartedKey(), object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sessionEnded", name: model.sessionEndedKey(), object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        // Request location permission from user
        if locationManager.locationServicesEnabled()  {
            if  locationManager.authorizationStatus() == .NotDetermined {
                locationManager.locationManager.requestWhenInUseAuthorization()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sessionStartedKey(notification: NSNotification) {
        let newSession = WeightSession(startTime: notification.object as! NSDate)
        
        if locationManager.authorizationStatus() == .AuthorizedWhenInUse {
            if let location = locationManager.currentLocation {
                model.addNewSessionLocation(newSession, location: location)
            }
        } else {
            model.addNewSessionLocation(newSession, location: nil)
        }
        
        // add a new entry to the table view and update it with a notification
        NSNotificationCenter.defaultCenter().postNotificationName(model.locationsUpdatedKey(), object: nil)
        
        // update the current timer vc with a notification
    }

    func sessionEndedKey(notification: NSNotification) {
        // add end time to current session
        // kill current timer VC
        // update table view and mapview if they are loaded ?? end time view
        
        // push the session + map data back up to the server
    }
}

