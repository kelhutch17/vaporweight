//
//  Model.swift
//  vaporweight
//
//  Created by Kelly Hutchison on 5/14/16.
//  Copyright © 2016 Kelly Hutchison. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Model
{
    var locations = [Location]()
    
    private let authorizationStatusNotificationKey = "AuthorizationStatusChanged"
    private let sessionStartedNotificationKey = "WeightSessionStarted"
    private let sessionEndedNotificationKey = "WeightSessionEnded"
    private let locationsUpdatedNotificationKey = "LocationsUpdated"
    static let sharedInstance = Model()
    
    private let defaultLocation = CLLocation(latitude: 37.762634, longitude: -122.419078)
    
    init() {
        // test locations
        locations.append(Location(title: "Noisebridge", coordinate: CLLocationCoordinate2D(latitude: 37.762634, longitude: -122.419078), description: "Coolest hacker space ever", session: WeightSession(startTime: NSDate())))
        
        locations.append(Location(title: "Craftsman and Wolves", coordinate: CLLocationCoordinate2D(latitude: 37.760928, longitude: -122.421695), description: "Delicious pastries", session: WeightSession(startTime: NSDate())))
    }
    
    // Setter and Getters
    func notificationKey() -> String {
        return authorizationStatusNotificationKey
    }
    
    func sessionStartedKey() -> String {
        return sessionStartedNotificationKey
    }
    
    func sessionEndedKey() -> String {
        return sessionEndedNotificationKey
    }
    
    func locationsUpdatedKey() -> String {
        return locationsUpdatedNotificationKey
    }
    
    func addLocation(name:String, description:String, location:CLLocationCoordinate2D?, session:WeightSession) {
        var newLocation : Location
        if let loc = location {
            newLocation = Location(title: name, coordinate: loc, description: description, session: session)
        } else {
            newLocation = Location(title: name, coordinate: CLLocationCoordinate2D(), description: description, session: session)
        }
        
        locations.append(newLocation)
    }
    
    func defaultMapLocation() -> CLLocation {
        return defaultLocation
    }
    
    func addNewSessionLocation(session: WeightSession, location: CLLocation?) {
        let name = ""
        // TODO reverse geo code coordinate and get a name and a desc
        let desc = ""
        if let coord = location?.coordinate {
            addLocation(name, description: desc, location: coord, session: session)
        } else {
            addLocation(name, description: desc, location: nil, session: session)
        }
    }

}