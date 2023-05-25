//
//  LocationHelper.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/24.
//

import Foundation
import CoreLocation

class LocationHelper: NSObject {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocationName(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else {
                print("Reverse geocoding error: \(error!.localizedDescription)")
                completion(nil)
                return
            }

            if let placemark = placemarks?.first {
                // 지역명 가져오기
                let locality = placemark.locality ?? ""
                let subLocality = placemark.subLocality ?? ""
                let thoroughfare = placemark.thoroughfare ?? ""
                let address = "\(subLocality) \(thoroughfare)"

                // 변환된 지역명 반환
                completion(locality + " " + address)
            } else {
                completion(nil)
            }
        }
    }
}

extension LocationHelper: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            print(coordinate.latitude)
            print(coordinate.longitude)
        }
    }
}
