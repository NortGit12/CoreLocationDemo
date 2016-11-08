//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by Jeff Norton on 11/8/16.
//  Copyright © 2016 JeffCryst. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //==================================================
    // MARK: - _Properties
    //==================================================
    
    var locationManager: CLLocationManager?
    var startLocation: CLLocation?
    
    //==================================================
    // MARK: - General
    //==================================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        
        calculateHomeToPointsOfInterest()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // If we don't have a start location, take the first one that comes in
        
        if startLocation == nil {
            
            startLocation = locations.first
            
        } else {
            
            // Calculate the differenc between the new location and the start location
            
            guard let latestLocation = locations.first
            else {
                
                NSLog("Error unwrapping the latest location.")
                return
            }
            
            let distanceInMeters = startLocation?.distance(from: latestLocation)
            print("Distance in meters: \(distanceInMeters)")
        }
    }
}

extension ViewController {
    
    func calculateHomeToPointsOfInterest() {
        
        let homeLocation = CLLocation(latitude: 40.399651, longitude: -111.809411)
        let hairballLocation = CLLocation(latitude: 37.960759, longitude: -100.870290)
        let devMountainLocation = CLLocation(latitude: 40.761980, longitude: -111.890581)
        
        let distanceInMetersToHairball = homeLocation.distance(from: hairballLocation)
        print("Distance (in meters) from my home to the largest hairball in the world: \(distanceInMetersToHairball)")
        
        let distanceInMetersToDevMountain = homeLocation.distance(from: devMountainLocation)
        print("Distance (in meters) from my home to DevMountain: \(distanceInMetersToDevMountain)")
    }
}




































