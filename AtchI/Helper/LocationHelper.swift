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
    
    func getCurrentLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // 위치 정보 업데이트를 위한 클로저 내에서 외부로 위치 정보를 반환
        locationManager.didUpdateLocationsCallback = { locations in
            guard let coordinate = locations.last?.coordinate else {
                completion(nil)
                return
            }
            
            completion(coordinate)
        }
        
        locationManager.stopUpdatingLocation()
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 위치 정보 가져오기 실패 시 처리할 내용
        print("위치 정보 로딩 실패")
    }
}

extension CLLocationManager {
    // 위치 정보 업데이트 시 외부로 위치 정보를 반환하기 위한 콜백 클로저
    fileprivate var didUpdateLocationsCallback: (([CLLocation]) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.didUpdateLocationsCallback) as? ([CLLocation]) -> Void
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.didUpdateLocationsCallback, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    private struct AssociatedKeys {
        static var didUpdateLocationsCallback = "didUpdateLocationsCallback"
    }
}
