//
//  HKHeartRateCore.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/11.
//

import Foundation

protocol HKHeartRateCoreProtocol {
    /// 분당 중복되는 심박수 처리
    func getHeartRateBPM(
        samples: [HKHeartRateEntity])
    -> [Double]
}

class HKHeartRateCore: HKHeartRateCoreProtocol {
    
    func getHeartRateBPM(
        samples: [HKHeartRateEntity])
    -> [Double] {
        
        var totalArray: [Double] = []
        var minuteArray: [Double] = []
        
        for idx in 0..<samples.count {
            let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: samples[idx].startDate)
            let heartRate = round(samples[idx].quantity)
            
            for hour in 0...23 {
                if idx == 0 {
                    minuteArray.append(heartRate)
                } else {
                    let beforeDatecomponent = Calendar.current.dateComponents([.hour, .minute], from: samples[idx-1].startDate)
                    if dateComponent.hour == hour {
                        if beforeDatecomponent.minute == dateComponent.minute {
                            minuteArray.append(heartRate)
                        } else if dateComponent.minute != beforeDatecomponent.minute {
                            if minuteArray.isEmpty != true {
                                let minuteAver = Double(minuteArray.reduce(0,+))/Double(minuteArray.count)
                                totalArray.append(minuteAver)
                                minuteArray.removeAll()
                            }
                            minuteArray.append(heartRate)
//                                    print("시간 배열 \(hourArray)")
                            if idx == samples.count-1 && minuteArray.isEmpty != true {
                                let minuteAver = Double(minuteArray.reduce(0,+))/Double(minuteArray.count)
                                totalArray.append(minuteAver)
                                minuteArray.removeAll()
                            }
                        }
                    } else {
                        continue
                    }
                }
            }
            
        }
        return totalArray
    }
}
