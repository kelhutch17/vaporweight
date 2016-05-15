//
//  Location.swift
//  vaporweight
//
//  Created by Kelly Hutchison on 5/14/16.
//  Copyright © 2016 Kelly Hutchison. All rights reserved.
//

import Foundation
import MapKit

class Location: NSObject, MKAnnotation {
    let title: String?
    let locationDescription: String?
    let coordinate: CLLocationCoordinate2D
    let session: WeightSession
    
    init(title: String, coordinate: CLLocationCoordinate2D, description: String, session: WeightSession) {
        self.title = title
        self.coordinate = coordinate
        locationDescription = description
        self.session = session
        
        super.init()
    }
    
    var subtitle: String? {
        return locationDescription
    }
    
    func mapItem() -> MKMapItem {
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}