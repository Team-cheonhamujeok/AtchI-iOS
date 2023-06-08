//
//  HealthInfoViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/07.
//
import Combine
import Foundation
import SwiftUI

import Factory
import StackCoordinator

class HealthInfoViewModel: ObservableObject {
    
    // MARK: - Dependency
    
    @Injected(\.hkActivityService) private var hkActivityService
    @Injected(\.hkHeartRateService) private var hkHeartRateService
    @Injected(\.hkSleepService) private var hkSleepService
    
    // MARK: - Input State
    
    @Published var action = HealthInfoAction()
    
    // MARK: - Output State
    
    @Published var state = HealthInfoState()
    
    // MARK: - Cancellable
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    
    init() {
        bind()
    }
    
    // MARK: - Prviate
    
    private func bind() {
        
        action
            .viewOnAppear
            .flatMap {
                self.hkActivityService
                    .getStepCount(date: self.yesterday)
                    .replaceError(with: 0)
                    .map { "\(Int($0))걸음" }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.state.stepCount, on: self)
            .store(in: &cancellables)
        
        action
            .viewOnAppear
            .flatMap {
                self.hkHeartRateService
                    .getHeartRateAveragePerMin(
                        startDate:
                            DateHelper.shared.getYesterdayStartAM(self.yesterday),
                        endDate:
                            DateHelper.shared.getYesterdayEndPM(self.yesterday)
                    )
                    .replaceError(with: [0])
                    .map { $0.reduce(0.0,+) / Double($0.count) }
                    .map { "\(Int($0))BPM" }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.state.heartAverage, on: self)
            .store(in: &cancellables)
        
        action
            .viewOnAppear
            .flatMap {
                self.hkSleepService
                    .getSleepRecord(
                        date: self.yesterday,
                        sleepCategory: .total
                    )
                    .replaceError(with: 0)
                    .map { "\(Int($0 / 60))시간 \($0 % 60)분" }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.state.sleepTotal, on: self)
            .store(in: &cancellables)
        
        action
            .viewOnAppear
            .map {
                DateHelper
                    .convertDateToString(
                        self.yesterday,
                        format: "M월 d일"
                    )
            }
            .assign(to: \.state.collectionDate, on: self)
            .store(in: &cancellables)
    }
    
    var yesterday: Date {
        DateHelper
            .subtractDays(from: Date(), days: 1)
    }
}
