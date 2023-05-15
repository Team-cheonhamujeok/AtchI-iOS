//
//  MockHKQuery.swift
//  AtchIServiceTests
//
//  Created by 강민규 on 2023/05/15.
//

import HealthKit

/// MockHKData를 검색하는 MockHKQuery
/// - Parameter :
///     - type: HKSampleType
///     - resultsHandler: (HKSampleQuery, [HKSample]?, Error?) -> Void
class MockHKQuery: HKSampleQuery {
    var type: HKSampleType?
    var resultsHandler: (HKSampleQuery, [HKSample]?, Error?) -> Void
    
    
    init(
        type: HKSampleType,
        resultsHandler: @escaping (HKSampleQuery, [HKSample]?, Error?) -> Void)
    {
        self.type = type
        self.resultsHandler = resultsHandler
        super.init(sampleType: type, predicate: nil, limit: 0, sortDescriptors: nil, resultsHandler: resultsHandler)
    }
}

/// MockHKStatisticsData를 검색하는 MockHKQuery
///- Parameter :
///     - type: HKQuantityType
///     - resultsHandler: (HKStatisticsQuery, HKStatistics?, Error?) -> Void
class MockHKStatisticsQuery: HKStatisticsQuery {
    var type: HKQuantityType?
    var resultsHandler: (HKStatisticsQuery, HKStatistics?, Error?) -> Void
    
    init(
        type: HKQuantityType,
        resultsHandler: @escaping (HKStatisticsQuery, HKStatistics?, Error?) -> Void)
    {
        self.type = type
        self.resultsHandler = resultsHandler
        super.init(quantityType: type, quantitySamplePredicate: nil, completionHandler: resultsHandler)
    }
    
}
