//
//  PreventViewModel.swift
//  AtchI
//
//  Created by 이봄이 on 2023/04/29.
//

import Foundation
import Combine

class PreventViewModel: ObservableObject {
    
    @Published var quizCount: Int = 0
    
    //let quizService: QuizServiceType?
    
    // MARK: - State
    
    /// Result - 이벤트에 따른 결과
    @Published var getQuizErrorMessage: String = ""
    
    func quizCountUp() {
        quizCount = quizCount + 1
        print("현재 완료된 퀴즈 개수 : \(quizCount)")
    }
    // 오늘 요일 구해오기
    private func getNowDay() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
        dateFormatter.dateFormat = "E" // Date 포맷 타입 지정
        let date_string = dateFormatter.string(from: nowDate) // 포맷된 형식 문자열로 반환
        
        print(date_string)
        return date_string
    }
    
    private var cancellables = Set<AnyCancellable>()
    
//    init(quizService: QuizServiceType) {
//        self.quizService = quizService
//    }
    
    func requestQuiz() {
//        self.quizService.getQuiz(mid: 1).sink(receiveCompletion: { completion in
//            switch completion {
//            case .finished: break
//            case .failure(let error):
//                self.getQuizErrorMessage = error.description
//
//            }
//        }, receiveValue: { response in
//
//        })
    }
}
