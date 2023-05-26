//
//  DIContainer.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/26.
//

import Foundation
import Factory

extension Container {
    
    // MARK: - HKService
    var hkSleepService: Factory<HKSleepServiceType> {
        Factory(self) { HKSleepService(provider: HKProvider(),
                                       dateHelper: DateHelper())
        }
    }
    
    var hkActivityService: Factory<HKActivityServiceProtocol> {
        Factory(self) { HKActivityService(healthkitProvicer: HKProvider())
        }
    }
    
    var hkHeartRateService: Factory<HKHeartRateServiceType> {
        Factory(self) { HKHeartRateService(healthKitProvider: HKProvider(),
                                           dateHelper: DateHelper())
        }
    }
}


