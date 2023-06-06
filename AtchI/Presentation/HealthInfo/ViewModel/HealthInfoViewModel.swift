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

@MainActor
class HealthInfoViewModel: ObservableObject {
    
    var coordinator: HomeCoordinator
    
    // MARK: - Dependency
    @Injected(\.hkActivityService) private var hkActivityService
    @Injected(\.hkHeartRateService) private var hkHeartRateService
    @Injected(\.hkSleepService) private var hkSleepService
    
    // MARK: - Input State
    @Subject var viewOnAppear: Void = ()
    @Subject var tapMoveHealthInfoPage: Void = ()
    @Subject var tapQuizShortcut: Void = ()
    @Subject var tapSelfDiagnosisShortcut: Void = ()
    
    // MARK: - Output State
    @Published var stepCount: String = ""
    @Published var heartAverage: String = ""
    @Published var sleepTotal: String = ""
    @Published var articles: [DementiaArticleModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        bind()
    }
    
    // MARK: - Prviate
    private func bind() {
        /// onAppear or RefreshButtonTap trigger
        let refreshWatchDataTrigger = $viewOnAppear
            .merge(with: $tapMoveHealthInfoPage)
            .share()
            .eraseToAnyPublisher()
        
        $tapMoveHealthInfoPage
            .sink {
                self.coordinator.path.append(HomeLink.healthInfo)
            }
            .store(in: &cancellables)
        
        $tapQuizShortcut
            .sink {
//                self.coordinator.path.append(HomeLink.quiz)
            }
            .store(in: &cancellables)
        
        
        refreshWatchDataTrigger
            .flatMap {
                self.hkActivityService
                    .getStepCount(date: Date())
                    .replaceError(with: 0)
                    .map { "\(Int($0))걸음" }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.stepCount, on: self)
            .store(in: &cancellables)
        
        refreshWatchDataTrigger
            .flatMap {
                self.hkHeartRateService
                    .getHeartRateAveragePerMin(startDate: DateHelper.shared.getYesterdayStartAM(Date()),
                                           endDate: DateHelper.shared.getYesterdayEndPM(Date()))
                .replaceError(with: [0])
                .map { $0.reduce(0.0,+) / Double($0.count) }
                .map { "\(Int($0))BPM" }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.heartAverage, on: self)
            .store(in: &cancellables)
        
        refreshWatchDataTrigger
            .flatMap {
                self.hkSleepService
                    .getSleepRecord(date: Date(),
                                    sleepCategory: .total)
                    .replaceError(with: 0)
                    .map { "\(Int($0 / 60))시간 \($0 % 60)분" }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.sleepTotal, on: self)
            .store(in: &cancellables)
        
    }
    
    
}
