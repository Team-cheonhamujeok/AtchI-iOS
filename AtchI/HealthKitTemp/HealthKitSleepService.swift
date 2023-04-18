//
//  HealthKitSleepService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/16.
//

import Foundation
import HealthKit

class HealthKitSleepService{
    
    let healthKitProvider: HealthKitProvider
    
    init(healthkitProvicer: HealthKitProvider) {
        self.healthKitProvider = healthkitProvicer
    }
    

    // MARK: - Fetch Function
    
    /// Healthkit Provider를 통해 데이터를 가져옵니다. 결과는 completion으로 전달합니다.
    /// - Parameters:
    ///    - date: 데이터를 가져오고자 하는 날짜를 주입합니다.
    ///    - completion: sample을 전달받는 콜백 클로저입니다.
    func fetchSleepData(date: Date, completion: @escaping ([HKCategorySample]) -> Void) {
        // 조건 날짜 정의 (그날 오후 6시 - 다음날 오후 6시)
        let endDate = getTodaySixPM(date)
        let startDate = getYesterdaySixPM(date)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)

        // 수면 데이터 가져오기
        healthKitProvider.getCategoryTypeSample(identifier: .sleepAnalysis,
                                                predicate: predicate) { samples in
            completion(samples)
        }
    }
    
    // MARK: - Get Function
    
    /// 전체 수면 시간 중 InBed 상태인 시간의 총시간(단위: 분)을 구합니다.
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 총 시간을 Int(단위: 분)로 반환합니다.
    func getSleepInBedQuentity(samples: [HKCategorySample]) -> Int {
        return calculateSleepTimeQuentity(sleepType: .inBed, samples: samples)
    }
    
    /// 전체 수면 시간 중 REM 상태인 시간의 총시간(단위: 분)을 구합니다.
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 총 시간을 Int(단위: 분)로 반환합니다.
    func getSleepREMQuentity(samples: [HKCategorySample])-> Int {
        return calculateSleepTimeQuentity(sleepType: .asleepREM, samples: samples)
    }
    
    /// 전체 수면 시간 중 Core 상태인 시간의 총시간(단위: 분)을 구합니다.
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 총 시간을 Int(단위: 분)로 반환합니다.
    func getSleepCoreQuentity(samples: [HKCategorySample])-> Int {
        return calculateSleepTimeQuentity(sleepType: .asleepCore, samples: samples)
    }
    
    /// 전체 수면 시간 중 Deep 상태인 시간의 총시간(단위: 분)을 구합니다.
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 총 시간을 Int(단위: 분)로 반환합니다.
    func getSleepDeepQuentity(samples: [HKCategorySample])-> Int {
        return calculateSleepTimeQuentity(sleepType: .asleepDeep, samples: samples)
    }
    
    /// 전체 수면 시간 중 awake 상태인 시간의 총시간(단위: 분)을 구합니다.
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 총 시간을 Int(단위: 분)로 반환합니다.
    func getSleepAwakeQeuntity(samples: [HKCategorySample])-> Int {
        return calculateSleepTimeQuentity(sleepType: .awake, samples: samples)
    }
    
    /// 수면 시작 시간을 구합니다.
    ///
    /// 어제 오후 6시~ 오늘 오후 6시 사이에 첫 수면 데이터를 수면 시작 시간으로 판단합니다.
    ///
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 시작 시간을 Date형으로 반환합니다.
    func getSleepStartDate(samples: [HKCategorySample]) -> Date? {
        return samples.first?.startDate
    }
    
    /// 수면 종료 시간을 구합니다.
    ///
    /// 어제 오후 6시~ 오늘 오후 6시 사이에 첫 마지막 수면 데이터를 수면 종료 시간으로 판단합니다.
    ///
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 종료 시간을 Date형으로 반환합니다.
    func getSleepEndDate(samples: [HKCategorySample]) -> Date? {
        return samples.last?.endDate
    }
    
    // MARK: - Calculation Logic
    /// 수면 데이터 종류에 따라 수면 총량(분)을 구합니다.
    ///
    /// 어제 오후 6시~ 오늘 오후 6시 사이에 모든 수면 데이터 중 해당 종류의
    /// 수면데이터의 startDate와 endDate의 차이를 분으로 환산해 합산합니다.
    ///
    /// - Parameters:
    ///    - sleepType: 구하고자 하는 수면 데이터 종류의 식별자입니다.
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 시작 시간을 Date형으로 반환합니다.
    private func calculateSleepTimeQuentity(sleepType: HKCategoryValueSleepAnalysis,
                              samples: [HKCategorySample]) -> Int {
        let calendar = Calendar.current
        let sum = samples.filter{ $0.value == sleepType.rawValue }
            .reduce(into: 0) { (result, sample) in
                let minutes = calendar.dateComponents([.minute], from: sample.startDate, to: sample.endDate).minute ?? 0
                result += minutes
            }
        return sum
    }
    
    // MARK: - Date logic
    /// today를 기준으로 한 오후 6시 시각을 구해서 Date형으로 반환합니다.
    ///
    /// - Parameters:
    ///    - date: 데이터를 가져오고자 하는 날짜를 주입합니다.
    /// - Returns: today를 기준으로 한 오늘 오후 6시 시간을 Date형으로 반환합니다.
    private func getTodaySixPM(_ date: Date) -> Date {
        let calendar = Calendar.current
        // 그날 오후 6시
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        components.hour = 18
        components.minute = 0
        components.second = 0
        let todaySixPM = calendar.date(from: components)!
        
        return todaySixPM
    }
    
    /// today를 기준으로 한 어제 오후 6시 시각을 구합니다.
    ///
    /// - Parameters:
    ///    - date: 데이터를 가져오고자 하는 날짜를 주입합니다.
    /// - Returns: today를 기준으로 한 어제 오후 6시 시간을 Date형으로 반환합니다.
    private func getYesterdaySixPM(_ date: Date) -> Date {
        let calendar = Calendar.current
        // 전날 오후 6시
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: date)!
        components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: yesterday)
        components.hour = 18
        components.minute = 0
        components.second = 0
        let yesterdaySixPM = calendar.date(from: components)!
        
        return yesterdaySixPM
    }
    
}
