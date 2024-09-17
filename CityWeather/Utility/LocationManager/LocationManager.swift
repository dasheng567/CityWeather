//
//  LocationManager.swift
//  CityWeather
//
//  Created by Chen Big on 9/16/24.
//

import CoreLocation

final class LocationManager: NSObject {
    // Provide a global access point
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    private(set) var permissionStatus: CLAuthorizationStatus?
    private(set) var location: CLLocation?

    override init() {
        super.init()

        setupManager()
    }

    // Make basic setup to the CLLocationManager
    private func setupManager() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }

    // Method to request user's permission of location
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }

    // Method to start tracing user's location
    func startTracking() {
        manager.startUpdatingLocation()
    }

    // Method to stop tracing user's location
    func stopTracking() {
        manager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Setup the location permission status
        self.permissionStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        // Stop tracking the user's location since we only need once to show the default city weather
        self.stopTracking()
    }
}
