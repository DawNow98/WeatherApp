//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Dawid Nowacki on 11/12/2024.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var locationDenied: Bool = false // To track denial
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Request location permission as soon as the LocationManager is initialized
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Start updating location without waiting for permission status
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    // Stop updating location
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate method when location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        // Update user location
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
            print("User's current location: \(location.coordinate.latitude), \(location.coordinate.longitude)") // Log location to console
        }
        
        // Stop updating location to save resources after getting the initial location
        locationManager.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate method when location authorization status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            self.locationStatus = status
            self.locationDenied = (status == .denied || status == .restricted)
        }
        
        // Start updating location if permission granted
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    // Handle errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed: \(error.localizedDescription)")
    }
}
