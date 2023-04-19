//
//  SelfTestViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/26.
//

import SwiftUI

class SelfTestViewModel: ObservableObject {
    @Published var questionIndex = 0.0
    
    //TODO: result 데이터를 UserData나, 서버에 저장해야함.
    private var answers: [TestAnswer] = []
    private var result: SelfTestResult?
    
    func makeResult() {
        self.result = SelfTestResult(day: currentTime(),
                                     point: calculatorPoint(),
                                     level: measureLevel())
    }
    
    func appendAnswer(testAnswer: TestAnswer) {
        answers.append(testAnswer)
    }
    
    func getEmoji() -> String {
        var emoji = ""
        
        if result?.level == "치매 안심 단계" {
            emoji = "🙂"
        } else if result?.level == "치매 위험 단계" {
            emoji = "😢"
        } else if result?.level == "치매 단계"{
            emoji = "🚨"
        } else {
            emoji = "❓"
        }
        
        return emoji
    }
    
    func getLevel() -> String {
        guard let result = result else { return "데이터 없음" }
        
        return result.level
    }
    
    func resetAnswers() {
        answers = []
    }
    
    func resetResult() {
        result = nil
    }
    
    
    //MARK: - Util
    private func currentTime() -> String {
        let now = Date() //"Mar 21, 2018 at 1:37 PM"
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yy년MM월dd일"

        return dateFormmater.string(from: now)
    }
    
    private func calculatorPoint() -> Int {
        var point = 0
        
        _ = self.answers.map { answer in
            switch answer {
            case .never:
                point += 0
            case .little:
                point += 1
            case .many:
                point += 2
            case .nothing:
                break
            }
        }
        
        return point
    }
    
    private func measureLevel() -> String {
        let point = calculatorPoint()
        if point <= 3 {
            return "치매 안심 단계"
        } else if point <= 9 {
            return "치매 위험 단계"
        } else {
            return "치매 단계"
        }
    }
}
