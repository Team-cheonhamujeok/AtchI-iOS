//
//  DIContainer.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/26.
//

import Foundation
import SwiftUI

import Factory
import Moya

extension Container {
    
    // MARK: - ViewModel {
    var preventViewModel: Factory<PreventViewModel> {
        Factory(self) {
            PreventViewModel(quizService: QuizService(provider: MoyaProvider<QuizAPI>()))
        }
        .singleton
    }
    
    // MARK: - Moya
    var lifePatternAPIProvider: Factory<MoyaProvider<LifePatternAPI>> {
        Factory(self) {
            MoyaProvider<LifePatternAPI>()
        }
    }
    
    // MARK: - Servcie
    var quizService: Factory<QuizServiceType> {
        Factory(self) {
            QuizService(provider: MoyaProvider<QuizAPI>())
        }
    }
    
    var mmseService: Factory<MMSEService> {
        Factory(self) {
            MMSEService(provider: MoyaProvider<MMSEAPI>())
        }
    }
    
    var dementiaArticleService: Factory<DementiaArticleService> {
        Factory(self) {
            DementiaArticleService()
        }
    }
    
    var predictionService: Factory<PredictionService> {
        Factory(self) {
            PredictionService(provider: MoyaProvider<PredictionAPI>())
        }
    }
    
    var lifePatternService: Factory<LifePatternServiceType> {
        Factory(self) {
            LifePatternService()
        }
    }
    
    var diagnosisService: Factory<DiagnosisServiceType> {
        Factory(self) {
            DiagnosisService(
                provider: MoyaProvider<DiagnosisAPI>()
            )
        }
    }
    
    var profileSerivce: Factory<ProfileServiceType> {
        Factory(self) {
            ProfileService(provider: MoyaProvider<ProfileAPI>())
        }
    }
    
    // MARK: - HKService
    var hkSleepService: Factory<HKSleepServiceProtocol> {
        Factory(self) { HKSleepService(
            core: HKSleepCore(),
            provider: HKProvider(),
            dateHelper: DateHelper())
        }
    }
    
    var hkActivityService: Factory<HKActivityServiceProtocol> {
        Factory(self) { HKActivityService(healthkitProvicer: HKProvider())
        }
    }
    
    var hkHeartRateService: Factory<HKHeartRateServiceProtocol> {
        Factory(self) { HKHeartRateService(
            core: HKHeartRateCore(),
            provider: HKProvider(),
            dateHelper: DateHelper())
        }
    }
}


