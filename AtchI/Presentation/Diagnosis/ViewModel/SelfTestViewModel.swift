//
//  SelfTestViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/26.
//

import SwiftUI

import Combine

class SelfTestViewModel: ObservableObject {
    
    let service: DiagnosisServiceType
    var disposeBag = Set<AnyCancellable>()
    
    /// 사용자의 자가진단 답변 리스트
    var answers: [TestAnswer] = []
    
    /// 해당 없음 문항이 6개가 되어 자가진단을 다시 해야하는지 체크하는 Flag
    @Published var isAgain = false

    /// 현재 자가진단 문항 인덱스
    @Published var questionIndex = 0.0 {
        willSet(newVal) {
            if newVal == 14 {
                isAgain = answers.filter({ $0 == .nothing }).count >= 6
            }
        }
    }
    
    // MARK: - init
    
    init(service: DiagnosisServiceType) {
        self.service = service
    }
    
    // MARK: - UI용 함수
    
    func getEmoji() -> String {
        let point = calculatorPoint(answers: answers)
        let level = measureLevel(point: point)
        
        switch level {
        case .safety:
            return "🙂"
        case .dangerous:
            return "😢"
        case .dementia:
            return "🚨"
        case .again:
            return "❓"
        }
    }
    
    func getLevel() -> String {
        let point = calculatorPoint(answers: answers)
        return measureLevel(point: point).rawValue
    }
    
    //MARK: - 변수 조작 함수
    
    /// 사용자의 답변을 answers 배열에 넣는 함수
    func appendAnswer(testAnswer: TestAnswer) {
        answers.append(testAnswer)
    }
    
    /// 답변을 reset 하는 함수
    func resetAnswers() {
        answers = []
        questionIndex = 0.0
        isAgain = false
    }
    
    /// DisposeBag 초기화
    func clearDisposeBag() {
        disposeBag = Set<AnyCancellable>()
    }
    
    // MARK: - 로직용 함수

    /// answers를 종합해서 최종 점수 계산
    func calculatorPoint(answers: [TestAnswer]) -> Int {
        var point = 0
        
        answers.forEach { answer in
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
    
    /// point를 이용해서 최종 level 계산
    func measureLevel(point: Int) -> SelfTestLevel {
        if isAgain { return .again }
        
        if point <= 3 {
            return .safety
        }
        else if point <= 9 {
            return .dangerous
        }
        else {
            return .dementia
        }
    }
    
    /// 사용자의 answers들을 Int 배열로 변환 시키는 함수
    func answersToInt() -> [Int] {
        var arr: [Int] = []
        
        self.answers.forEach { answer in
            switch answer {
            case .never:
                arr.append(0)
            case .little:
                arr.append(1)
            case .many:
                arr.append(2)
            case .nothing:
                arr.append(0)
            }
        }
        
        return arr
    }
    
    // MARK: - Server
    
    func requestResult(mid: Int) {
        if isAgain { return }
        let postDTO = DiagnosisPostModel(mid: mid,
                                         answerlist: answersToInt(),
                                         date: DateHelper.currentTime())
        let request = service.postDiagnosis(postDTO: postDTO)
        
        request
            .sink(receiveCompletion: { com in
                print("post Compoletion", com)
            }, receiveValue: { response in
                print("post Response", response)
            })
            .store(in: &disposeBag)
    }
}
