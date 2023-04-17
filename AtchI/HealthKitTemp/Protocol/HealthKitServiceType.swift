//
//  HealthKitServiceType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/16.
//

import Foundation

/// HealthKit에서 데이터를 가져오는 Service들의 인터페이스입니다.
/// 계산 및 날짜 조정은 클래스 내부에서 작성하고 최종적인 데이터는 getData를 통해 가져옵니다.
///
/// - Todo: 1. getData메서드의 return type 정해야함
protocol HealthKitServiceType {
    func getData(today: Date, completion: @escaping ([HealthKitModel])->Void)
}
