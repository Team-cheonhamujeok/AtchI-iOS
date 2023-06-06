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
    
    let quizService: QuizServiceType?
    
    // MARK: - State
    
    /// Result - 이벤트에 따른 결과
    @Published var getQuizErrorMessage: String = ""
    @Published var checkQuizErrorMessage: String = ""
    @Published var getWeekQuizErrorMessage: String = ""
    @Published var todayQuiz = [Quiz]()
    @Published var thisWeekQuizState = [WeekQuiz]()
    @Published var todayInt: Int = -1
    
    func calQuizCount() {
        quizCount = 0
        if todayQuiz.count >= 3 {
            for i in 0...todayQuiz.count-1 {
                if todayQuiz[i].check == true {
                    quizCount += 1
                }
            }
        }
    }
    
    // 오늘 요일을 숫자로 구해오기
    private func getNowDay() -> Int {
        let nowDate = Date()
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
        dateFormatter.dateFormat = "e" // Date 포맷 타입 지정
        let dayString = dateFormatter.string(from: nowDate) // 포맷된 형식 문자열로 반환
        let dayInt = Int(dayString)
        var todayInt: Int
        if dayInt! == 1 {
            todayInt = 6
        } else {
            todayInt = dayInt! - 2
        }
        return todayInt
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(quizService: QuizServiceType) {
        self.quizService = quizService
    }
    
    func requestQuiz() {
        self.quizService!.getQuiz(mid: UserDefaults.standard.integer(forKey: "mid")).sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self.getQuizErrorMessage = error.localizedDescription
                
            }
        }, receiveValue: { response in
            self.todayQuiz.removeAll()
            self.todayQuiz.append(Quiz(index: 1, content: response.quiz1, check: response.quiz1Check, solved: response.solve))
            self.todayQuiz.append(Quiz(index: 2, content: response.quiz2, check: response.quiz2Check, solved: response.solve))
            self.todayQuiz.append(Quiz(index: 3, content: response.quiz3, check: response.quiz3Check, solved: response.solve))
            UserDefaults.standard.set(response.tqid, forKey: "tqid")
            self.calQuizCount()
        }).store(in: &cancellables)
    }
    
    func checkQuiz(quizNum: Int) {
        let tqId = UserDefaults.standard.integer(forKey: "tqid")
        let mID = UserDefaults.standard.integer(forKey: "mid")
//        print("tqid \(tqId), mid \(mID)")
        self.quizService!.checkQuiz(quizCheckModel: QuizCheckRequestModel(tqid:tqId, quizNum: quizNum, mid: mID)).sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self.checkQuizErrorMessage = error.localizedDescription
            }
        }, receiveValue: { reponse in
            print(reponse.message)
        }).store(in: &cancellables)
    }
    
    func getWeekQuiz() {
        let mID = UserDefaults.standard.integer(forKey: "mid")
        self.quizService!.getWeekQuiz(mid: mID).sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self.getWeekQuizErrorMessage = error.localizedDescription
            }
        }, receiveValue: { response in
            self.thisWeekQuizState.removeAll()
            self.thisWeekQuizState.append(WeekQuiz(day: "월", quizState: response.mon))
            self.thisWeekQuizState.append(WeekQuiz(day: "화", quizState: response.tue))
            self.thisWeekQuizState.append(WeekQuiz(day: "수", quizState: response.wed))
            self.thisWeekQuizState.append(WeekQuiz(day: "목", quizState: response.thu))
            self.thisWeekQuizState.append(WeekQuiz(day: "금", quizState: response.fri))
            self.thisWeekQuizState.append(WeekQuiz(day: "토", quizState: response.sat))
            self.thisWeekQuizState.append(WeekQuiz(day: "일", quizState: response.sun))
            self.todayInt = self.getNowDay()
        }).store(in: &cancellables)
        
    }
}
