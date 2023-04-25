//
//  HKActivityService.swift
//  AtchI
//
//  Created by 강민규 on 2023/04/24.
//

import Foundation
import Combine
import HealthKit

/// - Note: Protocol이 필요할까요?
protocol HKActivityServiceProtocol {
    var healthKitProvider: HealthKitProvider { get }
    var stepPublisher: PassthroughSubject<Double, Error> { get }
    var energyPublisher: PassthroughSubject<Double, Error> { get }
    var distancePublisher: PassthroughSubject<Double, Error> { get }
    func getStepCount(date: Date)
    func getEnergy(date: Date)
    func getDistance(date: Date)
}

class HKActivityService: HKActivityServiceProtocol {
    //MARK: - Properties
    var healthKitProvider: HealthKitProvider
    
    init(healthkitProvicer: HealthKitProvider) {
        self.healthKitProvider = healthkitProvicer
    }
    
    // VM에서 봐야하는 Activity Publisher
    var stepPublisher = PassthroughSubject<Double, Error>()
    var energyPublisher = PassthroughSubject<Double, Error>()
    var distancePublisher = PassthroughSubject<Double, Error>()
    
    //MARK: Binding Data
    ///  1. ViewModel 초반에 Binding 함수를 선언해줘서 service와 provider의 publisher와 연결해준다.
    ///  2. 아니면 init에 넣어버려서 굳이 선언 안해도 되긴한데 뭐가 나은지 모르겠네요
    func binding() {
        self.stepPublisher = healthKitProvider.stepPublisher
        self.energyPublisher = healthKitProvider.energyPublisher
        self.distancePublisher = healthKitProvider.distancePublisher
    }
    
    //MARK: - Sending Function
    /// - Note: 값을 구하는 기간은 다 똑같으니 predicate는 묶는게 낫겠죠?
    //MARK: 걸음 수
    func getStepCount(date: Date) {
        let now = Date()
        let startOfDay = Calendar.current.date(byAdding: .day, value: 0, to: now)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        healthKitProvider.getQuantityTypeSample(identifier: .stepCount, predicate: predicate)
    }
    
    // MARK: 열량
    func getEnergy(date: Date) {
        let now = Date()
        let startOfDay = Calendar.current.date(byAdding: .day, value: 0, to: now)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        healthKitProvider.getQuantityTypeSample(identifier: .activeEnergyBurned, predicate: predicate)
    }
    
    // MARK: 거리
    func getDistance(date: Date) {
        let now = Date()
        let startOfDay = Calendar.current.date(byAdding: .day, value: 0, to: now)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endOfDay, options: .strictStartDate)
        
        healthKitProvider.getQuantityTypeSample(identifier: .distanceWalkingRunning, predicate: predicate)
    }
}
