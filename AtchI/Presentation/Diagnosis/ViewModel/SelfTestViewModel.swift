//
//  SelfTestViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/26.
//

import SwiftUI

class SelfTestViewModel: ObservableObject {
    @Published var questionIndex = 0.0
    
    var answers: [TestAnswer] = []
    var result: SelfTestResult?
    
    func makeResult() {
        self.result = SelfTestResult(day: currentTime(), point: calculatorPoint(), level: measureLevel())
    }
    
    func getImoji() -> String {
        //TODO: Imoji 분기처리하는 로직 넣기
        
        return ""
    }
    
    func getLevel() -> String {
        //TODO: 레벨 분기처리하는 로직 넣기
        return ""
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
        return "치매 위험 단계"
    }
}
