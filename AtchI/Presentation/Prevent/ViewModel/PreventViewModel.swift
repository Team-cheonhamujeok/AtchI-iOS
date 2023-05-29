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
    
    let quizService: QuizServiceType
    
    // MARK: - State
    
    /// Result - 이벤트에 따른 결과
    @Published var getQuizErrorMessage: String = ""
    @Published var checkQuizErrorMessage: String = ""
    @Published var todayQuiz = [Quiz]()
    
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
    
    init(quizService: QuizServiceType) {
        self.quizService = quizService
    }
    
    func requestQuiz() {
        self.quizService.getQuiz(mid: 1).print().sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self.getQuizErrorMessage = error.localizedDescription
                
            }
        }, receiveValue: { response in
            self.todayQuiz.append(Quiz(index: 1, content: response.quiz1, check: response.quiz1Check, solved: response.solve))
            self.todayQuiz.append(Quiz(index: 2, content: response.quiz2, check: response.quiz2Check, solved: response.solve))
            self.todayQuiz.append(Quiz(index: 3, content: response.quiz3, check: response.quiz3Check, solved: response.solve))
            UserDefaults.standard.set(response.tqid, forKey: "tqid")
            
        }).store(in: &cancellables)
    }
    
    func checkQuiz(quizNum: Int) {
        let tqId = UserDefaults.standard.integer(forKey: "tqid")
        print(tqId)
        self.quizService.checkQuiz(quizCheckModel: QuizCheckRequestModel(tqid:tqId, quizNum: quizNum)).print().sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self.checkQuizErrorMessage = error.localizedDescription
            }
        }, receiveValue: { reponse in
            print(reponse.message)
        }).store(in: &cancellables)
    }
}
