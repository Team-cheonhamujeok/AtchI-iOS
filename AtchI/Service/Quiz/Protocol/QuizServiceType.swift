//
//  QuizServiceType.swift
//  AtchI
//
//  Created by 이봄이 on 2023/05/23.
//

import Foundation
import Combine
import Moya

protocol QuizServiceType {
    /// 오늘의 퀴즈를 불러옵니다.
    ///
    ///
    ///  - Returns: 성공 시 퀴즈 데이터를 받아옵니다.
    func getQuiz(mid: Int) -> AnyPublisher<GetQuizResponseModel, Error>
    
    /// 오늘의 퀴즈를 확인합니다.
    ///
    /// - Returns: 성공 시 오늘의 퀴즈 고유 아이디와 퀴즈 번호를 가져옵니다.
    func checkQuiz(quizCheckModel: QuizCheckRequestModel) -> AnyPublisher<QuizCheckResponseModel, Error>
    
    /// 이번 주 퀴즈를 확인합니다.
    ///
    /// - Returns: 성공 시 이번주 퀴즈 테이블 번호, mid, 시작날짜, 요일별 퀴즈 풀이 현황(t/f)을 가져옵니다.
    func getWeekQuiz(mid: Int) -> AnyPublisher<GetWeekQuizResponseModel, Error>
}
