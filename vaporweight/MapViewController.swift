//
//  MapViewController.swift
//  vaporweight
//
//  Created by Kelly Hutchison on 5/14/16.
//  Copyright © 2016 Kelly Hutchison. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // constants
    let regionRadius: CLLocationDistance = 300
    let model = Model.sharedInstance
    var locationManager = LocationManagerSingleton.sharedInstance
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "authorizationChanged", name: model.notificationKey(), object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reload", name: model.locationsUpdatedKey(), object: nil)
        
        if let userLocation = locationManager.currentLocation {
            centerMapOnLocation(userLocation)
        } else {
            centerMapOnLocation(model.defaultMapLocation())
        }
        
        mapView.addAnnotations(model.locations)
        mapView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location:CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpanMake(0.01, 0.01))
        
        mapView.setRegion(region, animated: true)
        mapView.regionThatFits(region)
    }
    
    func reload (notification: NSNotification) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(model.locations)
    }
    
    func authorizationChanged (notification: NSNotification) {
        if let _ = notification.object {
            let status = notification.object as! CLAuthorizationStatus
            if status == CLAuthorizationStatus.AuthorizedWhenInUse {
                mapView.showsUserLocation = true
            } else {
                NSLog("Cannot get user location info")
                mapView.showsUserLocation = false
            }
        }
    }
    
    // MARK: Helper Functions
    func showErrorAlert(title:String, message:String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alertViewController.addAction(alertAction)
        presentViewController(alertViewController, animated: true, completion: nil)
    }
    
    // This function gets called for every annotation you add to the map, to return the view for each annotation.
    func mapView(mapView: MKMapView,
        viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation {
                //return nil so map view draws "blue dot" for standard user location
                return nil
            }
            if let annotation = annotation as? Location {
                let identifier = "pin"
                var view: MKPinAnnotationView
                if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                    as? MKPinAnnotationView { // check to see if a reusable annotation view is available before creating a new one
                        dequeuedView.annotation = annotation
                        view = dequeuedView
                } else {
                    // 3
                    view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    view.canShowCallout = true
                    view.calloutOffset = CGPoint(x: -5, y: 5)
                    view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                }
                
                return view
            }
            return nil
    }
    
    // Info button pressed for a building
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //        let bldgInfoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("BuildingInfoViewController") as! BuildingInfoViewController
        //
        //        // do any setup you need for myNewVC
        //        bldgInfoViewController.model = model
        //
        //        // set the singleton instances
        //        bldgInfoViewController.delegate = self
        //        bldgInfoViewController.locationManager = locationManager
        //        bldgInfoViewController.mapView = mapView
        //        bldgInfoViewController.building = view.annotation as? Model.Building
        //
        //        // present the view controller
        //        self.presentViewController(bldgInfoViewController, animated: true, completion: nil)
        //    }
    }
}
