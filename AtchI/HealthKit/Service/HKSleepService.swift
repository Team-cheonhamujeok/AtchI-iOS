//
//  HKSleepService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/16.
//

import Foundation
import HealthKit
import Combine

/// HealthKit의 수면 샘플을 가져오는 클래스입니다.
///
/// provider를 통해 sample을 가져오는 `fetchSleepSamples(date:)` 함수와
/// 그 외 수면 데이터 가공을 위한 메서드들로 구성되어 있습니다.
///
/// 먼저, fetch함수를 통해 데이터를 가져온 후 가져온 데이터를 이용해 게산 메서드를 이용할 수 있습니다.
///
/// ```swift
/// let service = HKSleepService(hkProvider: HKProvider())
///
/// service.fetchSleepSamples(date: Date()) { samples in
///   let awakeTime = service.getSleepAwakeQeuntity(samples: samples)
///    // ... 이후 작업
/// }
/// ```
///
/// - SeeAlso: HKProvider
///
class HKSleepService {
    private var provider: HKProvider
    private var dateHelper: DateHelperType

    init(provider: HKProvider, dateHelper: DateHelperType) {
        self.provider = provider
        self.dateHelper = dateHelper
    }

    // MARK: - Fetch Function

    /// 내부적으로 Healthkit Provider를 통해 데이터를 가져옵니다. 결과는 completion으로 전달합니다.
    ///
    /// - Parameters:
    ///    - date: 데이터를 가져오고자 하는 날짜를 주입합니다.
    ///    - completion: sample을 전달받는 콜백 클로저입니다.
    /// - Returns: 수면 데이터를 [HKCategorySample] 형으로 Future에 담아 반환합니다.
    private func fetchSleepSamples(date: Date) -> Future<[HKCategorySample], Error> {
        return Future() { [weak self] promise in
            // 조건 날짜 정의 (그날 오후 6시 - 다음날 오후 6시)
            let endDate = self?.dateHelper.getTodaySixPM(date)
            let startDate = self?.dateHelper.getYesterdaySixPM(date)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)

            // 수면 데이터 가져오기
            self?.provider.getCategoryTypeSample(identifier: .sleepAnalysis,
                                                              predicate: predicate) { samples, error  in
                if let error = error { promise(Result.failure(error)) }
                promise(Result.success(samples))
            }
        }
    }
    
    /// 내부적으로 수면 데이터 종류에 따라 수면 총량(분)을 구합니다.
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
}


extension HKSleepService: HKSleepOverallServiceType {
    
    /// 수면 시작 시간을 구합니다.
    ///
    /// 어제 오후 6시~ 오늘 오후 6시 사이에 첫 수면 데이터를 수면 시작 시간으로 판단합니다.
    ///
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 시작 시간을 Date형으로 반환합니다.
    func getSleepOverall(date: Date) -> Future <HKSleepModel, Error> {
        return Future { promise in
            self.fetchSleepSamples(date: date)
                .sink(receiveCompletion: { _ in },
                      receiveValue: { samples in

                    let sleepModel =
                    HKSleepModel(startTime: self.getSleepStartDate(samples: samples) ?? Date(), // 에러 처리해야함
                                 endTime: self.getSleepEndDate(samples: samples) ?? Date(),
                                 inbedQuentity: self.calculateSleepTimeQuentity(sleepType: .inBed, samples: samples),
                                 remQuentity: self.calculateSleepTimeQuentity(sleepType: .asleepREM, samples: samples),
                                 coreQuentity: self.calculateSleepTimeQuentity(sleepType: .asleepCore, samples: samples),
                                 deepQuentity: self.calculateSleepTimeQuentity(sleepType: .asleepDeep, samples: samples),
                                 awakeQuentity: self.calculateSleepTimeQuentity(sleepType: .awake, samples: samples))

                    promise(Result.success(sleepModel))
                })
        }
    }

    /// 수면 시작 시간을 구합니다.
    ///
    /// 어제 오후 6시~ 오늘 오후 6시 사이에 첫 수면 데이터를 수면 시작 시간으로 판단합니다.
    ///
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 시작 시간을 Date형으로 반환합니다.
    private func getSleepStartDate(samples: [HKCategorySample]) -> Date? {
        return samples.first?.startDate
    }

    /// 수면 종료 시간을 구합니다.
    ///
    /// 어제 오후 6시~ 오늘 오후 6시 사이에 첫 마지막 수면 데이터를 수면 종료 시간으로 판단합니다.
    ///
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 종료 시간을 Date형으로 반환합니다.
    private func getSleepEndDate(samples: [HKCategorySample]) -> Date? {
        return samples.last?.endDate
    }
}

extension HKSleepService: HKSleepIndividualServiceType {
    // MARK: - Get Function
    
    enum HKSleepCategory {
        case total
        case inbed
        case rem
        case core
        case deep
        case awake
        
        fileprivate var origin: HKCategoryValueSleepAnalysis? {
            switch self {
            case .total:
                return nil
            case .inbed:
                return .inBed
            case .rem:
                return .asleepREM
            case .core:
                return .asleepCore
            case .deep:
                return .asleepDeep
            case .awake:
                return .awake
            }
        }
    }

    func getSleepQuentity(date: Date, sleepCategory: HKSleepCategory) -> Future<Int, Never> { // TODO: 에러 처리 수정
        return Future { promise in
            self.fetchSleepSamples(date: date)
                .sink(receiveCompletion: { _ in },
                      receiveValue: { [weak self] samples in
                    
                    guard let self = self else { return }
                    
                    // HealthKit에서 제공하는 수면 종류인 경우
                    if let category = sleepCategory.origin {
                        let quentity = self.calculateSleepTimeQuentity(sleepType: category,
                                                                       samples: samples)
                        promise(Result.success(quentity))
                    }
                    // HealthKit에서 제공하지 않는 수면 종류인 경우
                    else {
                        switch sleepCategory {
                        case .total:
                            promise(Result.success(0)) // TODO: 미구현
                        default:
                            fatalError("제공하지 않는 수면 종류입니다.")
                        }
                    }
                })
        }
    }
}
