//
//  HealthKitSleepService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/16.
//

import Foundation
import HealthKit

class HealthKitSleepService: HealthKitServiceType {
    
    let healthKitProvicer: HealthKitProvider
    let sleepIdentifier: [HKCategoryValueSleepAnalysis]
    
    init(healthkitProvicer: HealthKitProvider) {
        self.healthKitProvicer = healthkitProvicer
        sleepIdentifier = [.inBed, .asleepREM, .asleepCore, .asleepDeep, .awake]
    }
    
    /// Healthkit에서 필요한 정보 계산해서 HealthKitModel 형으로 변경합니다.
    ///
    /// - Parameters:
    ///    - today: 오늘 날짜를 주입합니다.
    ///    - completion: HealthKitModel 배열을 인자로 받는 클로저를 주입합니다. 이 클로저를 통해 Service 상위 레벨에서 데이터를 다룹니다.
    func getData(today: Date, completion: @escaping ([HealthKitModel])->Void){
        // 조건 날짜 정의 (그날 오후 6시 - 다음날 오후 6시)
        let endDate = getTodaySixPM(today)
        let startDate = getYesterdaySixPM(today)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        
        // 수면 데이터 가져오기
        healthKitProvicer.getCategoryTypeSample(identifier: .sleepAnalysis,
                                                predicate: predicate) { [weak self] samples in
            // self 캡쳐 방지
            if let self = self {
                // 기존 수면 총량 구하기
                var sleepQuentities: [HealthKitModel] = self.sleepIdentifier.map { identifier in
                    let quentity: Double
                    = self.getSleepTimeQuentity(sleepType: identifier,
                                                samples: samples)
                    return HealthKitQuentityModel(
                        identifier: HealthKitIdentifier.fromHKSleepIdentifier(identifier)!,
                        quentity: quentity)
                }
                
                // 수면 시작 시간 및 종료 시간 구하기
                let sleepStart = self.getSleepStartDate(samples: samples)
                let sleepEnd = self.getSleepEndDate(samples: samples)
                
                // 기존 수면 총량과 수면 시작&종료 시간 합치기
                sleepQuentities.append(HealthKitDateModel(identifier: .sleepStartTime, time: sleepStart))
                sleepQuentities.append(HealthKitDateModel(identifier: .sleepStartTime, time: sleepEnd))
                
                // 결과값 콜백으로 전달
                completion(sleepQuentities)
            }
        }
    }
    
    // MARK: - Computation logic
    /// 수면 데이터 종류에 따라 수면 총량(분)을 구합니다.
    ///
    /// 어제 오후 6시~ 오늘 오후 6시 사이에 모든 수면 데이터 중 해당 종류의
    /// 수면데이터의 startDate와 endDate의 차이를 분으로 환산해 합산합니다.
    ///
    /// - Parameters:
    ///    - sleepType: 구하고자 하는 수면 데이터 종류의 식별자입니다.
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 시작 시간을 Date형으로 반환합니다.
    func getSleepTimeQuentity(sleepType: HKCategoryValueSleepAnalysis,
                              samples: [HKCategorySample]) -> Double {
        let calendar = Calendar.current
        let sum = samples.filter{ $0.value == sleepType.rawValue }
            .reduce(into: 0) { (result, sample) in
                let minutes = calendar.dateComponents([.minute], from: sample.startDate, to: sample.endDate).minute ?? 0
                result += minutes
            }
        return Double(sum)
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
    
    // MARK: - Date logic
    /// today를 기준으로 한 오후 6시 시각을 구해서 Date형으로 반환합니다.
    ///
    /// - Parameters:
    ///    - today: 오늘 날짜를 주입합니다.
    /// - Returns: today를 기준으로 한 오늘 오후 6시 시간을 Date형으로 반환합니다.
    private func getTodaySixPM(_ today: Date) -> Date {
        let calendar = Calendar.current
        // 그날 오후 6시
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: today)
        components.hour = 18
        components.minute = 0
        components.second = 0
        let todaySixPM = calendar.date(from: components)!
        
        return todaySixPM
    }
    
    /// today를 기준으로 한 어제 오후 6시 시각을 구합니다.
    ///
    /// - Parameters:
    ///    - today: 오늘 날짜를 주입합니다.
    /// - Returns: today를 기준으로 한 어제 오후 6시 시간을 Date형으로 반환합니다.
    private func getYesterdaySixPM(_ today: Date) -> Date {
        let calendar = Calendar.current
        // 전날 오후 6시
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: today)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: yesterday)
        components.hour = 18
        components.minute = 0
        components.second = 0
        let yesterdaySixPM = calendar.date(from: components)!
        
        return yesterdaySixPM
    }
    
}
