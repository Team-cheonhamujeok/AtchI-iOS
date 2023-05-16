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
    
    // 어제 시작 시각 (00:00) 구하기
    func getYesterdayStartAM(_ date: Date) -> Date {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let yesterday = calendar.date(byAdding: .day, value: -3, to: date)!
        components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: yesterday)
        components.hour = 24 // 한국 기준 24:00:00이 시작이므로
        components.minute = 0
        components.second = 0
        let yesterdayStartAM = calendar.date(from: components)!
        
        return yesterdayStartAM
    }
    
    // 어제 끝 시각 (23:59) 구하기
    func getYesterdayEndPM(_ date: Date) -> Date {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let yesterday = calendar.date(byAdding: .day, value: -2, to: date)!
        components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: yesterday)
        components.hour = 23 // 한국 기준 23:59:59가 마지막이므로
        components.minute = 59
        components.second = 59
        let yesterdayEndPM = calendar.date(from: components)!
        print("어제 끝 시간 : \(yesterdayEndPM)")
        return yesterdayEndPM
    }
    
    // 현재 시간 계산
    static func currentTime() -> String {
        let now = Date() //"Mar 21, 2018 at 1:37 PM"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter.string(from: now)
    }
    
    // 날짜  "yy년MM월dd일" 형식으로 변환
    static func convertFormat(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: string) else { return "Date is Nil" }
        
        dateFormatter.dateFormat = "yy년MM월dd일"
        return dateFormatter.string(from: date)
    }
}
