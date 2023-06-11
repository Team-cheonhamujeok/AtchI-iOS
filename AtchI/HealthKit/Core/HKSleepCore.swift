//
//  HKSleepCore.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/09.
//

import Foundation


protocol HKSleepCoreProtocol {
    /// 애플워치 측정 데이터에 대해 수면 데이터 종류에 따라 수면 총량(분)을 구합니다.
    ///
    /// 어제 오후 6시~ 오늘 오후 6시 사이에 모든 수면 데이터 중 해당 종류의
    /// 수면데이터의 startDate와 endDate의 차이를 분으로 환산해 합산합니다.
    /// - Important: 애플워치로 측정된 데이터를 우선적으로 반환하고, 없다면 아이폰으로 측정한 데이터를 반환합니다. 만약, 애플워치로만 접근 가능한 데이터라면 nil을 반환합니다.
    ///
    /// - Parameters:
    ///    - sleepType: 구하고자 하는 수면 데이터 종류의 식별자입니다.
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 총량을 Int형(단위: 분)으로 반환합니다.
    func calculateSleepTimeQuentity(
        sleepType: HKSleepType,
        samples: [HKSleepEntity]
    ) -> Int?
    
    /// 수면 시작 시간을 구합니다.
    ///
    /// - Parameter samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 시작 시간을 Date 형으로 반환합니다.
    func calculateSleepStartDate(
        samples: [HKSleepEntity]
    ) -> Date
    
    /// 수면 종료 시간을 구합니다.
    /// - Parameter samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 종료 시간을 Date 형으로 반환합니다.
    func calculateSleepEndDate(
        samples: [HKSleepEntity]
    ) -> Date
    
    /// 애플 워치로 측정한 수면 데이터들의 시작시간과 종료시간을 반환합니다.
    /// 즉, 각각의 수면 텀을 구합니다.
    /// - Important: 애플워치로 측정된 데이터만 반환합니다. 애플워치로 측정한 데이터가 없다면 빈 배열을 반환합니다.
    ///
    /// - Parameter samples: HealthKit데이터를 매핑한 엔티티를 받습니다.
    /// - Returns: 결과를 Model에 매핑해 반환합니다.
    func getSleepInterval(
        input samples: [HKSleepEntity]
    ) throws -> [HKSleepIntervalModel]
}

class HKSleepCore: HKSleepCoreProtocol {
    
    func calculateSleepTimeQuentity(
        sleepType: HKSleepType,
        samples: [HKSleepEntity]
    ) -> Int? {
        
        let watchSamples = samples
            .filter{
                $0.dateSourceProductType == .watch
            }
        var claculatedSampels: [HKSleepEntity]
        
        // 애플워치 데이터가 없으면 전체에서 합산해서 반환
        if watchSamples.isEmpty {
            if sleepType != .inbed { // inbed 외에는 워치 데이터 필수
                return nil
            }
            claculatedSampels = samples
        }
        // 있으면 애플워치 데이터 중 계산
        else {
            claculatedSampels = watchSamples
        }
        
        let calendar = Calendar.current
        let sum = claculatedSampels
            .filter{ $0.sleepType == sleepType }
            .reduce(into: 0) { (result, sample) in
                let minutes = calendar
                    .dateComponents(
                    [.minute],
                    from: sample.startDate,
                    to: sample.endDate)
                    .minute ?? 0
                result += minutes
            }
        
        // 데이터가 없으면 nil 반환 (애플워치 데이터가 없는 경우 등)
        return sum == 0 ? nil : sum
    }

    
    func calculateSleepStartDate(
        samples: [HKSleepEntity]
    ) -> Date {
        if let stratDate = samples.first?.startDate {
            return stratDate
        } else {
            fatalError("올바른 수면 데이터가 아닙니다")
        }
    }
    
    
    func calculateSleepEndDate(
        samples: [HKSleepEntity]
    ) -> Date {
        if let endDate = samples.last?.endDate {
            return endDate
        } else {
            fatalError("올바른 수면 데이터가 아닙니다")
        }
    }
    
    func getSleepInterval(
        input samples: [HKSleepEntity]
    ) throws -> [HKSleepIntervalModel] {
        
        let watchSampels = samples
            .filter{
                $0.dateSourceProductType == .watch
            } // 워치 착용만
            .filter { $0.sleepType == .inbed } // inbed만
        if watchSampels.isEmpty {
            throw HKError.watchDataNotFound
        }
        
        return watchSampels
            .map {
                HKSleepIntervalModel(startDate: $0.startDate,
                                        endDate: $0.endDate)
            }
    }
}
