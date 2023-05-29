//
//  LocationHelper.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/24.
//

import Foundation
import CoreLocation

/// CoreLocation을 이용해 사용자의 위치정보를 받아오는 헬퍼클래스입니다.
class LocationHelper: NSObject {
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    /// 위치 접근 권한 허용 기능입니다.
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    /// 위도와 경도를 받아 지역명으로 변환합니다.
    func getLocationName(locationType: LocationNameType,
                         completion: @escaping (String?) -> Void) {
        
        guard let location = locationManager.location
        else { completion(nil); return }
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else {
                print("Reverse geocoding error: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first {
                // 주소 정보 가져오기
                switch locationType {
                case .country:
                    completion(placemark.country ?? "") // FIXME: 예외처리
                    return
                case .locality:
                    completion(placemark.locality)
                    return
                case .subLocality:
                    completion("\(placemark.subLocality ?? "") \(placemark.thoroughfare ?? "")")
                case .address:
                    completion("\(placemark.locality ?? "") \(placemark.subLocality ?? "") \(placemark.thoroughfare ?? "")")
                }
            } else { completion(nil) }
        }
    }
}

extension LocationHelper: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            // print(coordinate.latitude)
            // print(coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 위치 정보 가져오기 실패 시 처리할 내용
        print("위치 정보 로딩 실패")
    }
}

extension LocationHelper {
    /// 위치, 지역명 종류입니다.
    enum LocationNameType {
        /// 나라명
        case country
        /// 시/도
        case locality
        /// 동/읍/면
        case subLocality
        /// 시/도 + 동/읍/면
        case address
    }
}
