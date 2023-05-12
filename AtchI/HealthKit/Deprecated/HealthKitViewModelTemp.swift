//
//  HealthKitViewModelTemp.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/25.
//

import Foundation
import Combine

@available(*, deprecated, message: "HKService이용 예시 뷰모델입니다. 실제로 사용하지 마세요.")
class HealthKitViewModelTemp {
    
    // TODO: 프로토콜 만들어서 IoC하기
    let sleepService: HKSleepServiceType
    let activityService: HKActivityService
    let heartRateService: HKHeartRateService
    
    
    init(sleepService: HKSleepServiceType,
         activityService: HKActivityService,
         heartRateService: HKHeartRateService) {
        self.sleepService = sleepService
        self.activityService = activityService
        self.heartRateService = heartRateService
    }
    
    /// 예시 함수
    func start() {
        let date = Date()

        let acitivityDistancePublisher = activityService.getDistance(date: date)
        let acitivityEnergyPublisher = activityService.getEnergy(date: date)
        let acitivityStepCountPublisher = activityService.getStepCount(date: date)
        

        let publisher1 = Just(1)
        let publisher2 = Just("Hello")
        let publisher3 = Just(3.14)

        let publishers = [publisher1, publisher2, publisher3] as [Any]
        let sequencePublisher = Publishers.Sequence<[Any], Error>(sequence: publishers)

        let cancellable = sequencePublisher
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { value in
                print("Received value: \(value)")
            }

        
//        let sequencePublisher = Publishers.Sequence(sequence: [sleepSamplesPublisher,
//                                                               acitivityDistancePublisher,
//                                                               acitivityEnergyPublisher,
//                                                               acitivityStepCountPublisher])
        
//        let combineActivityPublisher = acitivityDistancePublisher.zip(acitivityEnergyPublisher, acitivityStepCountPublisher)
//            .sink(receiveCompletion: { completion in },
//                  receiveValue: { distance, energy, stepCount in
//            })
//
//        sleepSamplesPublisher
//            .zip(combineActivityPublisher)
//            .sink(receiveCompletion: { _ in },
//                  receiveValue: { sleepSamples, activityZip in
//                self.sleepService.getSleepAwakeQeuntity(samples: sleepSamples)
//
//                activityZip.sink { _ in }
//            })
//
        
        // zip3 사용 예시
//        sleepPublisher.zip(pub2, pub3) { [weak self] sleepSamples, samples2, samples3 in // 네이밍은 서비스에 맞게
//            print("sample1: \(sleepSamples), sample2: \(samples2), sample3: \(samples3)") // 값 3개가 다 도착하면 실행
//
//            let sleepEndDate = self?.sleepService.getSleepEndDate(samples: sleepSamples)
//            let sleepCoreQuentity = self?.sleepService.getSleepCoreQuentity(samples: sleepSamples)
//            // ... 쭉쭉 필요한 정보 계산
//
//            // Life Pattern DTO(Model) 생성
//            // ...
//
//            // 서버 저장 request 호출!
//            // ...
//
//        }.sink(receiveCompletion: { completion in
//            // completion 처리
//        }, receiveValue: { value in
//            // value 처리
//        })
    }
}
