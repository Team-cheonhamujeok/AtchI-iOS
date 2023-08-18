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
        .singleton
    }
    
    var mmseService: Factory<MMSEService> {
        Factory(self) {
            MMSEService(provider: MoyaProvider<MMSEAPI>())
        }
        .singleton
    }
    
    var dementiaArticleService: Factory<DementiaArticleService> {
        Factory(self) {
            DementiaArticleService()
        }
        .singleton
    }
    
    var predictionService: Factory<PredictionService> {
        Factory(self) {
            PredictionService(provider: MoyaProvider<PredictionAPI>())
        }
        .singleton
    }
    
    var lifePatternService: Factory<LifePatternServiceType> {
        Factory(self) {
            LifePatternService()
        }
        .singleton
    }
    
    var diagnosisService: Factory<DiagnosisServiceType> {
        Factory(self) {
            DiagnosisService(
                provider: MoyaProvider<DiagnosisAPI>()
            )
        }
        .singleton
    }
    
    var profileService: Factory<ProfileServiceType> {
        Factory(self) {
            ProfileService(provider: MoyaProvider<ProfileAPI>())
        }
        .singleton
    }
    
    var accountService: Factory<AccountServiceType> {
        Factory(self) {
            AccountService(provider: MoyaProvider<AccountAPI>())
        }
        .singleton
    }
    
    var validationService: Factory<ValidationServiceType> {
        Factory(self) {
            ValidationService()
        }
        .singleton
    }
    
    // MARK: - HKService
    var hkSleepService: Factory<HKSleepServiceProtocol> {
        Factory(self) { HKSleepService(
            core: HKSleepCore(),
            provider: HKProvider(),
            dateHelper: DateHelper())
        }
        .singleton
    }
    
    var hkActivityService: Factory<HKActivityServiceProtocol> {
        Factory(self) { HKActivityService(healthkitProvicer: HKProvider())
        }
        .singleton
    }
    
    var hkHeartRateService: Factory<HKHeartRateServiceProtocol> {
        Factory(self) { HKHeartRateService(
            core: HKHeartRateCore(),
            provider: HKProvider(),
            dateHelper: DateHelper())
        }
        .singleton
    }

}


