//
//  CLLocationManager.swift
//  WeatherTest
//
//  Created by Hasan Serdar on 7.06.2018.
//  Copyright © 2018 STRV. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import FirebaseDatabase

class LocationHelper: NSObject, CLLocationManagerDelegate {
    private static var instance: LocationHelper?
    private let locationManager: CLLocationManager!


    override init() {
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100.0

        super.init()
    }

    class func updateLocation() {
        if LocationHelper.instance == nil {
            LocationHelper.instance = LocationHelper()
            LocationHelper.instance?.locationManager.delegate = instance
            LocationHelper.instance?.locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil

        Redux.store.dispatch(AppState.updateLocation(lat: newLocation.coordinate.latitude, long: newLocation.coordinate.longitude))
    }
}



