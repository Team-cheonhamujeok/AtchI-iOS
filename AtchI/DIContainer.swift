//
//  DIContainer.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/26.
//

import Foundation

import Factory
import Moya

extension Container {

    // MARK: - Moya
    var lifePatternAPIProvider: Factory<MoyaProvider<LifePatternAPI>> {
        Factory(self) {
            MoyaProvider<LifePatternAPI>()
        }
    }
    
    // MARK: - Servcie
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
    
    // MARK: - HKService
    var hkSleepService: Factory<HKSleepServiceProtocol> {
        Factory(self) { HKSleepService(provider: HKProvider(),
                                       dateHelper: DateHelper())
        }
    }
    
    var hkActivityService: Factory<HKActivityServiceProtocol> {
        Factory(self) { HKActivityService(healthkitProvicer: HKProvider())
        }
    }
    
    var hkHeartRateService: Factory<HKHeartRateServiceProtocol> {
        Factory(self) { HKHeartRateService(healthKitProvider: HKProvider(),
                                           dateHelper: DateHelper())
        }
    }
}


