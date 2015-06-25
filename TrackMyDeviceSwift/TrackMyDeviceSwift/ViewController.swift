//
//  ViewController.swift
//  TrackMyDeviceSwift
//
//  Created by Muthuraj M on 2/20/15.
//  Copyright (c) 2015 Market Simplified. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    let locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization();
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 2
        if status == .AuthorizedWhenInUse {
            
            NSLog("location authorized");
            
            // 3
            locationManger.startUpdatingLocation()
            
            //4
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    // 5
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.first as? CLLocation {
            
            NSLog("location updates \(locations)");
            
            // 6
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 7
            locationManger.stopUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

