//
//  SelfTestViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/26.
//

import SwiftUI

import Combine

class SelfTestViewModel: ObservableObject {
    //MARK: - Properties
    let service: DiagnosisServiceType
    
    var disposeBag = Set<AnyCancellable>()
    
    /// 문제에 대해서 사용자의 답변이 들어있는 배열
    private var answers: [TestAnswer] = []
    
    /// SelfTestView에서 문제 번호를 나타냄
    @Published var questionIndex = 0.0 {
        willSet(newVal) {
            print(newVal)
            if newVal == 14 {
                isAgain = answers.filter({ $0 == .nothing }).count >= 6
            }
        }
    }
    
    @Published var isAgain = false
    
    /// UI용 자가진단 데이터 리스트
    @Published var selfTestResults: [SelfTestResult] = [] {
        willSet(newVal) {
            print("#",newVal)
       }
    }
    
    
    // MARK: - init
    init(service: DiagnosisServiceType, questionIndex: Double = 0.0, answers: [TestAnswer], result: SelfTestResult? = nil) {
        self.service = service
        self.questionIndex = questionIndex
        self.answers = answers
    }
    
    init(service: DiagnosisServiceType) {
        self.service = service
    }
    
    // MARK: - View에서 사용되는 함수
    
    // MARK: - UI용 함수
    
    ///  치매 레벨에 따른 Emoji 반환 함수
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
    
    /// 치매 레벨 반환 함수
    func getLevel() -> String {
        let point = calculatorPoint(answers: answers)
        return measureLevel(point: point).rawValue
    }
    
    // MARK: - 로직용 함수
    
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
    
    /// 자가진단 결과 리스트 정렬
    func sortSelfTestResults() {
        self.selfTestResults = selfTestResults.sorted { $0.id > $1.id }
    }
    
    /// answers를 종합해서 최종 점수 계산
    private func calculatorPoint(answers: [TestAnswer]) -> Int {
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
    private func measureLevel(point: Int) -> SelfTestLevel {
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
    private func answersToInt() -> [Int] {
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
    
    //MARK: - Date
    /// 현재 시간 계산
    private func currentTime() -> String {
        let now = Date() //"Mar 21, 2018 at 1:37 PM"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter.string(from: now)
    }
    
    /// 날짜 String 타입 을 Date 타입으로
    private func convertDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        // 아주 긴 세계 시간 형식을 받기 위한 포맷 형성
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        // Date 타입으로 변경
        /// - Note:
        /// date parameter 가 이상한 값을 들고 왔을 때 date nil이 나오는 경우가 있는데
        /// 1. Date? 로 리턴해서 사용하는 로직에서 옵셔널 체크
        /// 2. 뒤에서 편리하게 여기서 Date 만 리턴하도록하기,
        ///     그런데 이렇게 하면 에러 처리를 어떻게 하지,, throw를 사용하면 로직이 복잡해네요.
//        guard let result = dateFormatter.date(from: date) else {
//            throw DateError.invalidFormat
//        }
        
        return dateFormatter.date(from: date)
    }
    
    /// 날짜  "yy년MM월dd일" 형식으로 변환
    private func convertFormat(date: Date?) -> String {
        guard let date else { return "Date is Nil" }
        let dateFormatter = DateFormatter()
        // 원하는 시간 형식으로 변경
        dateFormatter.dateFormat = "yy년MM월dd일"
        
        // String으로 출력
        return dateFormatter.string(from: date)
    }
    
    
    // MARK: - Server
    /// 서버에 Request
    /// - Parameter :
    /// mid: Int = 멤버 아이디
    func requestResult(mid: Int) {
        if isAgain { return }
        
        let postDTO = DiagnosisPostModel(mid: mid, answerlist: answersToInt(), date: currentTime())
        
        let request = service.postDiagnosis(postDTO: postDTO)
        
        let cancellable = request
                            .sink(receiveCompletion: { com in
                                print("post Compoletion", com)
                            }, receiveValue: { response in
                                print("post Response", response)
                            })
                            .store(in: &disposeBag)
    }

    /// 서버로부터 Get 하는 함수
    func getData() {
        // TODO: mid 값 넣기
        let request = service.getDiagnosisList(mid: 2)
        
        let cancellable =
        request
            .handleEvents(receiveSubscription: { _ in
              print("Network request will start")
            }, receiveOutput: { _ in
              print("Network request data received")
            }, receiveCancel: {
              print("Network request cancelled")
            })
            .sink(receiveCompletion: { _ in
                print("SelfTestInfoViewModel: Complete")
            }, receiveValue: { response in
                let decoder = JSONDecoder()
                if let datas = try? decoder.decode([DiagnosisGetModel].self, from: response.data) {
                    
                    // Response 자가진단 결과 리스트
                    var response: [SelfTestResult] = []
                    
                    // MARK: 자가진단 결과 추가
                    datas.forEach {
                        let id = $0.did
                        let mid = $0.mid
                        let date = self.convertFormat(date: self.convertDate(date: $0.date))
                        let point = $0.result
                        let level = self.measureLevel(point: point)
                        
                        response.append(SelfTestResult(id: id,
                                                       mid: mid,
                                                       date: date,
                                                       point: point,
                                                       level: level.rawValue))}
                    
                    // 서버 배열 교체
                    self.selfTestResults = response
                    
                    // 배열 정렬
                    self.sortSelfTestResults()
                    print("배열 교체")
                }
            }).store(in: &disposeBag)
    }
}
