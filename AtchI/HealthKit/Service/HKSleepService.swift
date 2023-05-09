//
//  HKSleepService.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/16.
//

import Foundation
import HealthKit
import Combine

// TODO: Future 에러 핸들링 (Provider 에러 전파) ✅
// TODO: 오늘 이후 값에 접근할 경우 fatalError 내기 (개발자 에러)
// TODO: HKsleepModel에 total 타임 추가하기
// TODO: 값이 비어있을 때 CustomError 반환하기 (워치 미착용, 앱에서 수면시간 지정 안할 시 수면 데이터가 비어 있음) ✅

/// HealthKit의 수면 샘플을 가져오는 클래스입니다.
///
/// HKSleepService에서 제공하는 데이터 종류는 다음과 같습니다.
/// - (애플 워치 착용 여부 없이) 총 수면 시간(단위: 분, 이하 동일)
/// - 수면 시작 시간
/// - 수면 종료 시간
/// - (애플 워치 미착용시) 수면 총 시간
/// - 렘 수면 총 시간
/// - 가벼운 수면 총 시간
/// - 깊은 수면 총 시간
/// - 수면 중 깨어 있었던 시간
///
/// **[사용법]**
///
/// 1. 여러개의 수면 데이터가 한번에 필요하다면 ``getSleepRecord(date:sleepCategory:)-4clmj``에  `.all`을 사용해 로 모든 정보가 담긴 구조체 인스턴스를 반환받을 수 있습니다.
///
/// 2. 개별 데이터가 필요하다면 `.total`, `.inbed` ,`.rem` ,`.core`, `.deep`, `.awake` `.start`, `.end` 속성으로 Primitive type을 반환받을 수 있습니다.
///
/// - Note: 어제 오후 6시~ 오늘 오후 6시 사이를 오늘 수면 시간으로 판단합니다.
///
/// - Warning: 개별 데이터에 접근하는 메서드를 여러번 호출한다면 매번 HealhKit 저장소에서 정보를 가져오게 되므로 성능 저하가 발생할 수 있습니다. 또한 호출이 전부 완료되기 전 HealthKit 저장소의 정보가 바뀔 수 있으므로 예상치 못한 결과 값을 얻을 수 있습니다. 따라서 여러 데이터가 필요한 경우에는 `.all`을 이용하여 한번에 데이터를 받아오세요.
///
/// ## SeeAlso
/// ``HKSleepServiceType``
///
class HKSleepService: HKSleepServiceType{
    
    private var provider: HKProvider
    private var dateHelper: DateHelperType
    
    init(provider: HKProvider, dateHelper: DateHelperType) {
        self.provider = provider
        self.dateHelper = dateHelper
    }

    func getSleepRecord(date: Date, sleepCategory: HKSleepCategory.common) -> Future <HKSleepModel, HKError> {
        return Future { promise in
            _ = self.fetchSleepSamples(date: date).sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        promise(Result.failure(error))
                    }
                },receiveValue: { samples in
                    switch sleepCategory{
                    case .all:
                        let sleepModel = self.createSleepModel(samples: samples)
                        promise(Result.success(sleepModel))
                    }
                })
        }
    }

    func getSleepRecord(date: Date, sleepCategory: HKSleepCategory.origin) -> Future<Int, HKError> {
        return Future { promise in
            _ = self.fetchSleepSamples(date: date).sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        promise(Result.failure(error))
                    }
                }, receiveValue: { [weak self] samples in
                    
                    guard let self = self else { return }
                    
                    let quentity = self.calculateSleepTimeQuentity(sleepType: sleepCategory.identifier,
                                                                   samples: samples)
                    promise(Result.success(quentity))
                    
                })
        }
    }
    
    func getSleepRecord(date: Date, sleepCategory: HKSleepCategory.quentity) -> Future<Int, HKError> {
        return Future { promise in
            _ = self.fetchSleepSamples(date: date).sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        promise(Result.failure(error))
                    }
                }, receiveValue: { samples in
                    
                    switch sleepCategory {
                    case .total:
                        let sum = self.calculateSleepTimeQuentityAll(samples: samples)
                        promise(Result.success(sum))
                    }
                    
                })
        }
    }

    func getSleepRecord(date: Date, sleepCategory: HKSleepCategory.date) -> Future<Date, HKError>  {
        return Future { promise in
            _ = self.fetchSleepSamples(date: date).sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            promise(Result.failure(error))
                        }
                    }, receiveValue: { [weak self] samples in
                    
                    guard let self = self else { return }
                        
                    switch sleepCategory {
                    case .start:
                        promise(Result.success(self.calculateSleepStartDate(samples: samples)))
                    case .end:
                        promise(Result.success(self.calculateSleepEndDate(samples: samples)))
                    }
                })
        }
    }
    
    func getSleepInterval(date: Date) -> Future<[HKSleepIntervalModel], HKError> {
        return Future { promise in
            _ = self.fetchSleepSamples(date: date).sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        promise(Result.failure(error))
                    }
                }, receiveValue: { samples in
                    promise(Result.success(
                        samples
                            .filter { $0.value != 2 } // awake 제외
                            .map { HKSleepIntervalModel(startDate: $0.startDate,
                                                        endDate: $0.endDate)
                            }))
                }
            )
        }
    }
}

// MARK: - Private
extension HKSleepService {
    
    /// 내부적으로 Healthkit Provider를 통해 데이터를 가져옵니다. 결과는 completion으로 전달합니다.
    ///
    /// - Parameters:
    ///    - date: 데이터를 가져오고자 하는 날짜를 주입합니다.
    ///    - completion: sample을 전달받는 콜백 클로저입니다.
    /// - Returns: 수면 데이터를 [HKCategorySample] 형으로 Future에 담아 반환합니다.
    private func fetchSleepSamples(date: Date) -> Future<[HKCategorySample], HKError> {
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
    /// - Returns: 총량을 Int형(단위: 분)으로 반환합니다.
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
    
    /// 총 수면 시간(분)을 구합니다.
    ///
    /// 어제 오후 6시~ 오늘 오후 6시 사이에 모든 수면 데이터 중 해당 종류의
    /// 수면데이터의 startDate와 endDate의 차이를 분으로 환산해 합산합니다.
    ///
    /// - Parameters:
    ///    - samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 총량을 Int형(단위: 분)으로 반환합니다.
    private func calculateSleepTimeQuentityAll(samples: [HKCategorySample]) -> Int {
        let calendar = Calendar.current
        let sum = samples.reduce(into: 0) { (result, sample) in
            let minutes = calendar.dateComponents([.minute], from: sample.startDate, to: sample.endDate).minute ?? 0
            result += minutes
        }
        return sum
    }
    
    /// 내부적으로 수면 시작 시간을 구합니다.
    ///
    /// - Parameter samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 시작 시간을 Date 형으로 반환합니다.
    private func calculateSleepStartDate(samples: [HKCategorySample]) -> Date {
        if let stratDate = samples.first?.startDate {
            return stratDate
        } else {
            fatalError("올바른 수면 데이터가 아닙니다")
        }
    }
    
    /// 내부적으로 수면 종료 시간을 구합니다.
    /// - Parameter samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 수면 종료 시간을 Date 형으로 반환합니다.
    private func calculateSleepEndDate(samples: [HKCategorySample]) -> Date {
        if let endDate = samples.last?.endDate {
            return endDate
        } else {
            fatalError("올바른 수면 데이터가 아닙니다")
        }
    }
    
    /// 내부적으로 SleepModel을 생성합니다.
    /// - Parameter samples: 어제 오후 6시~ 오늘 오후 6시 사이의 모든 수면 데이터입니다.
    /// - Returns: 전반적인 수면 정보를 담은 HKSleepModel을 반환합니다.
    private func createSleepModel(samples: [HKCategorySample]) -> HKSleepModel {
        return HKSleepModel(
            total: self.calculateSleepTimeQuentityAll(samples: samples),
            inbedQuentity: self.calculateSleepTimeQuentity(sleepType: .inBed, samples: samples),
            remQuentity: self.calculateSleepTimeQuentity(sleepType: .asleepREM, samples: samples),
            coreQuentity: self.calculateSleepTimeQuentity(sleepType: .asleepCore, samples: samples),
            deepQuentity: self.calculateSleepTimeQuentity(sleepType: .asleepDeep, samples: samples),
            awakeQuentity: self.calculateSleepTimeQuentity(sleepType: .awake, samples: samples),
            startTime: calculateSleepStartDate(samples: samples),
            endTime: calculateSleepEndDate(samples: samples))
    }
    
}

enum HKSleepCategory {
    
    enum common {
        /// Sleep관련 모든 정보를 의미합니다.
        case all
    }

    enum quentity {
        /// 애플워치 착용 여부에 관계 없는 총 수면 시간입니다.
        case total
    }
    
    enum date {
        /// 수면 시작 시간입니다.
        case start
        /// 수면 종료 시간입니다.
        case end
    }
    
    enum origin {
        /// 애플워치 착용 시 분류되는 수면 상태 별 수면 시간입니다.
        case inbed, rem, core, deep, wake
        
        fileprivate var identifier: HKCategoryValueSleepAnalysis {
            switch self {
            case .inbed: return .inBed
            case .rem: return .asleepREM
            case .core: return .asleepCore
            case .deep: return .asleepDeep
            case .wake: return .awake
            }
        }
    }
}
