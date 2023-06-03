//
//  HKSleepServiceMock.swift
//  AtchIServiceTests
//
//  Created by DOYEON LEE on 2023/06/03.
//

@testable import AtchI

import XCTest
import Combine

class HKSleepServiceMock: HKSleepServiceProtocol {
    func getSleepRecord(date: Date, sleepCategory: AtchI.HKSleepCategory.common) -> AnyPublisher<AtchI.HKSleepModel, AtchI.HKError> {
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        // 새벽 1시를 수면 시작 시간으로 설정
        components.hour = 1
        components.minute = 0
        let startTime: Date = calendar.date(from: components)!
        // 아침 8시간을 수면 종료 시간으로 설정
        components.hour = 8
        let endDate: Date = calendar.date(from: components)!
        
        return Just(HKSleepModel(totalQuentity: 300,
                                 inbedQuentity: 300,
                                 remQuentity: 300,
                                 coreQuentity: 300,
                                 deepQuentity: 300,
                                 awakeQuentity: 300,
                                 startTime: startTime,
                                 endTime: endDate))
        .setFailureType(to: HKError.self)
        .eraseToAnyPublisher()
    }
    
    func getSleepRecord(date: Date, sleepCategory: AtchI.HKSleepCategory.origin) -> AnyPublisher<Int, AtchI.HKError> {
        return Just(300)
            .setFailureType(to: HKError.self)
            .eraseToAnyPublisher()
    }
    
    func getSleepRecord(date: Date, sleepCategory: AtchI.HKSleepCategory.quentity) -> AnyPublisher<Int, AtchI.HKError> {
        return Just(300)
            .setFailureType(to: HKError.self)
            .eraseToAnyPublisher()
    }
    
    func getSleepRecord(date: Date, sleepCategory: AtchI.HKSleepCategory.date) -> AnyPublisher<Date, AtchI.HKError> {
        return Just(Date())
            .setFailureType(to: HKError.self)
            .eraseToAnyPublisher()
    }
    
    func getSleepInterval(date: Date) -> AnyPublisher<[AtchI.HKSleepIntervalModel], AtchI.HKError> {
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        
        // 1시부터 8시까지를 한시간 단위로 Interval로 쪼갬
        let intervals = (1...7).map {
            components.hour = $0
            let intervalStartTime = calendar.date(from: components)!
            components.hour = $0 + 1
            let intervalEndTime = calendar.date(from: components)!
            return HKSleepIntervalModel(startDate: intervalStartTime,
                                        endDate: intervalEndTime)
        }
        
        return Just(intervals)
            .setFailureType(to: HKError.self)
            .eraseToAnyPublisher()
    }
    
    
}
