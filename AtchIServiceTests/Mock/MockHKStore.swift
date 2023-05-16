//
//  MockHKStore.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/05/15.
//

import Foundation
import HealthKit

// https://stackoverflow.com/questions/74637260/unit-test-requestauthorization-for-healthkit

class MockHKStore: HKHealthStore {
    
    var sleepData = MockHKData.sleepData
    var energyData = MockHKData.energyData
    var stepData = MockHKData.stepData
    var distanceData = MockHKData.distanceData
    var heartData = MockHKData.heartData
    
    var requestAuthorizationArgs: [(typesToShare: Set<HKSampleType>?,
                                    typesToRead: Set<HKObjectType>?,
                                    completion: (Bool, Error?) -> Void)] = []
    
    override func requestAuthorization(toShare typesToShare: Set<HKSampleType>?,
                                       read typesToRead: Set<HKObjectType>?,
                                       completion: @escaping (Bool, Error?) -> Void) {
        requestAuthorizationArgs.append((typesToShare, typesToRead, completion))
    }
    
    override func execute(_ query: HKQuery) {
        let type = query.objectType
        
        // mockQuery.resultsHandler(Query, Value, Err) 값을 넣어주면 됩니다.
        if type == HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
            var mockQuery = query as! MockHKQuery
            mockQuery.resultsHandler(mockQuery, sleepData, nil)
        }
        else if type == HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) {
            var mockQuery = query as! MockHKStatisticsQuery
            mockQuery.resultsHandler(mockQuery, energyData, nil)
        }
        else if type == HKObjectType.quantityType(forIdentifier: .stepCount) {
            var mockQuery = query as! MockHKStatisticsQuery
            mockQuery.resultsHandler(mockQuery, stepData, nil)
        }
        else if type == HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) {
            var mockQuery = query as! MockHKStatisticsQuery
            mockQuery.resultsHandler(mockQuery, distanceData, nil)
        }
        else if type == HKObjectType.quantityType(forIdentifier: .heartRate) {
            var mockQuery = query as! MockHKQuery
            mockQuery.resultsHandler(mockQuery, nil, nil)
        }
    }
}
