//
//  DateHelper.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/04.
//

import Foundation

/// 특정 날짜 계산을 위임받는 클래스입니다.
class DateHelper: DateHelperType {
    func getTodaySixPM(_ date: Date) -> Date {
        let calendar = Calendar.current
        // 그날 오후 6시
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        components.hour = 18
        components.minute = 0
        components.second = 0
        let todaySixPM = calendar.date(from: components)!

        return todaySixPM
    }

    func getYesterdaySixPM(_ date: Date) -> Date {
        let calendar = Calendar.current
        // 전날 오후 6시
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: date)!
        components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: yesterday)
        components.hour = 18
        components.minute = 0
        components.second = 0
        let yesterdaySixPM = calendar.date(from: components)!

        return yesterdaySixPM
    }
}
