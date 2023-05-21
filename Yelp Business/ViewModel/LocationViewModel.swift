//
//  LocationViewModel.swift
//  Yelp Business
//
//  Created by mmbs on 21/05/23.
//

import Foundation
import MapKit

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location = CLLocationCoordinate2D()
    @Published var loadingLocation = true
    
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    let locationManager = CLLocationManager()
    
    func requestAllowOnceLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            return
        }
        
        DispatchQueue.main.async {
            self.location = latestLocation.coordinate
            self.loadingLocation.toggle()
            print("\(latestLocation.coordinate.latitude), \(latestLocation.coordinate.longitude)")
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    

}
