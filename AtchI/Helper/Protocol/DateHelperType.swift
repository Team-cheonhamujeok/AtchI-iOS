//
//  DateHelperType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/04.
//

import Foundation

protocol DateHelperType {
    
    /// today를 기준으로 한 오후 6시 시각을 구해서 Date형으로 반환합니다.
    ///
    /// - Parameters:
    ///    - date: 데이터를 가져오고자 하는 날짜를 주입합니다.
    /// - Returns: today를 기준으로 한 오늘 오후 6시 시간을 Date형으로 반환합니다.
    func getTodaySixPM(_ date: Date) -> Date
    
    /// today를 기준으로 한 어제 오후 6시 시각을 구합니다.
    ///
    /// - Parameters:
    ///    - date: 데이터를 가져오고자 하는 날짜를 주입합니다.
    /// - Returns: today를 기준으로 한 어제 오후 6시 시간을 Date형으로 반환합니다.
    func getYesterdaySixPM(_ date: Date) -> Date
    
    func getYesterdayStartAM(_ date: Date) -> Date
    func getYesterdayEndPM(_ date: Date) -> Date
}
