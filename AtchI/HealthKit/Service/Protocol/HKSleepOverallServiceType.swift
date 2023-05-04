//
//  HKSleepOverallServiceType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/04.
//

import Foundation
import Combine

protocol HKSleepOverallServiceType {
    func getSleepOverall(date: Date) -> Future <HKSleepModel, Error>
}
