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
    
    /// SelfTestView에서 문제 번호를 나타냄
    @Published var questionIndex = 0.0
    
    /// 문제에 대해서 사용자의 답변이 들어있는 배열
    /// index : 문제의 번호( 0 부터 시작 )
    /// value : 문제에 대한 답변
    private var answers: [TestAnswer] = []
    
    /// 최종 SelfTestResult 결과
    private var result: SelfTestResult?
    
    //MARK: info 데이터
    /// 자가진단 데이터 리스트
    @Published var selfTestResults: [SelfTestResult] = []
    
    
    //MARK: - init
    init(service: DiagnosisServiceType, questionIndex: Double = 0.0, answers: [TestAnswer], result: SelfTestResult? = nil) {
        self.service = service
        self.questionIndex = questionIndex
        self.answers = answers
        self.result = result
    }
    
    init(service: DiagnosisServiceType) {
        self.service = service
    }
    
    //MARK: - View에서 사용되는 함수
    /// answers를 종합해서 최종 Result를 도출하는 함수
    func makeResult() {
        self.result = SelfTestResult(id: 1,
                                    date: currentTime(),
                                     point: calculatorPoint(),
                                     level: measureLevel(point: calculatorPoint()))
    }
    
    /// 사용자의 답변을 answers 배열에 넣는 함수
    func appendAnswer(testAnswer: TestAnswer) {
        answers.append(testAnswer)
    }
    
    ///  치매 레벨에 따른 Emoji 반환 함수
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
    
    /// 치매 레벨 반환 함수
    func getLevel() -> String {
        guard let result = result else { return "데이터 없음" }
        
        return result.level
    }
    
    /// 답변을 reset 하는 함수
    func resetAnswers() {
        answers = []
    }
    
    /// 최종 result를 nil로 만드는 함수
    func resetResult() {
        result = nil
    }
    
    // MARK: - Server
    /// Post Model로 변환
    private func convertPostData(mid: Int, date: String) -> DiagnosisPostModel{
        var postAnswers: [Int] = []
        
        _ = self.answers.map { answer in
            switch answer {
            case .never:
                postAnswers.append(0)
            case .little:
                postAnswers.append(1)
            case .many:
                postAnswers.append(2)
            case .nothing:
                postAnswers.append(0)
            }
        }
        
        return DiagnosisPostModel(mid: mid, answerlist: postAnswers, date: date)
    }
    
    /// 서버에 Request
    /// - Parameter :
    /// mid: Int = 멤버 아이디
    func requestResult(mid: Int) {
        let postDTO = convertPostData(mid: mid, date: currentTime())
        print(postDTO)
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
        let request = service.getDiagnosisList(mid: 1)
        
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
                    // MARK: 자가진단 결과 추가
                        datas.forEach {
                        let id = $0.mid
                        let date = self.convertFormat(date: self.convertDate(date: $0.date))
                        let point = $0.result
                        let level = self.measureLevel(point: $0.result)
                        self.selfTestResults.append(
                                SelfTestResult(id: id,
                                               date: date,
                                              point: point,
                                               level: level))
                        }
                }
            }).store(in: &disposeBag)
    }
    
    //MARK: - Util
    /// 현재 시간 계산
    private func currentTime() -> String {
        let now = Date() //"Mar 21, 2018 at 1:37 PM"
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        print(dateFormatter.string(from: now))
        return dateFormatter.string(from: now)
    }
    
    /// 날짜 String 타입 을 Date 타입으로
    private func convertDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        // 아주 긴 세계 시간 형식을 받기 위한 포맷 형성
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        // Date 타입으로 변경
        return dateFormatter.date(from: date)
    }
    
    /// 날짜  "yy년MM월dd일" 형식으로 변환
    private func convertFormat(date: Date?) -> String {
        guard let date = date else {return "올바르지 않은 날짜"}
        
        let dateFormatter = DateFormatter()
        // 원하는 시간 형식으로 변경
        dateFormatter.dateFormat = "yy년MM월dd일"
        
        // String으로 출력
        return dateFormatter.string(from: date)
    }
    
    /// answers를 종합해서 최종 점수 계산
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
    
    /// point를 이용해서 최종 level 계산
    private func measureLevel(point: Int) -> String {
        if point <= 3 {
            return "치매 안심 단계"
        } else if point <= 9 {
            return "치매 위험 단계"
        } else {
            return "치매 단계"
        }
    }
}
