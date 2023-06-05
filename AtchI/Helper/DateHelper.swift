//
//  DateHelper.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/04.
//

import Foundation

/// 특정 날짜 계산을 위임받는 클래스입니다.
class DateHelper: DateHelperType {
    
    static let shared: DateHelper = DateHelper()
    
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
    
    /// 어제 시작 시각 (00:00) 구하기
    func getYesterdayStartAM(_ date: Date) -> Date {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let yesterday = calendar.date(byAdding: .day, value: -2, to: date)!
        components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: yesterday)
        components.hour = 24 // 한국 기준 24:00:00이 시작이므로
        components.minute = 0
        components.second = 0
        let yesterdayStartAM = calendar.date(from: components)!
        
        return yesterdayStartAM
    }
    
    /// 어제 끝 시각 (23:59) 구하기
    func getYesterdayEndPM(_ date: Date) -> Date {
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: date)!
        components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: yesterday)
        components.hour = 23 // 한국 기준 23:59:59가 마지막이므로
        components.minute = 59
        components.second = 59
        let yesterdayEndPM = calendar.date(from: components)!
        return yesterdayEndPM
    }
    
    /// 현재 시간 계산
    static func currentTime() -> String {
        let now = Date() //"Mar 21, 2018 at 1:37 PM"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter.string(from: now)
    }
    
    /// 날짜  "yy년MM월dd일" 형식으로 변환
    static func convertFormat(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: string) else { return "Date is Nil" }
        
        dateFormatter.dateFormat = "yy년MM월dd일"
        return dateFormatter.string(from: date)
    }
    
    /// 날짜  "yy.MM.dd" 형식으로 변환
    static func convertFormat2(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: string) else { return "Date is Nil" }
        
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    /// String을 Date형으로 변환합니다.
    static func convertStringToDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: string)!
    }
    
    /// 특정 날짜들의 사이 날짜를 모두 구합니다.
    /// - Parameters:
    ///   - startDate: 시작 날짜입니다.
    ///   - endDate: 끝 날짜입니다.
    /// - Returns: 구한 날짜를 Date형 배열로 반환합니다.
    /// - Warning: endDate는 startDate보다 나중이어야합니다.
    static func generateBetweenDates(from startDate: Date, to endDate: Date) -> [Date] {
        
        assert(startDate < endDate, "끝 날짜는 시작 날짜보다 나중이어야합니다.")
        
        var dates: [Date] = []
        var currentDate = startDate

        let calendar = Calendar.current
        let endDate = calendar.startOfDay(for: endDate) // 00:00시 가져오기

        while currentDate <= endDate {
            dates.append(currentDate)
            guard let newDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = newDate
        }

        return dates
    }
    
    /// 기준 날짜에 특정 일 수를 뺀 날짜를 반환합니다.
    /// - Parameters:
    ///   - date: 기준 날짜입니다.
    ///   - days: 뺄 일 수 입니다.
    /// - Returns: 날짜형을 반환합니다.
    static func subtractDays(from date: Date, days: Int) -> Date {
        
        assert(days >= 0, "일 수는 0보다 커야합니다.")
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = -days
        
        return calendar.date(byAdding: dateComponents, to: date)!
    }

}
