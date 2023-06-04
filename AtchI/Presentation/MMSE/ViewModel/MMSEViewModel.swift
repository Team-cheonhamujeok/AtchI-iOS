//
//  MMSEViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import Foundation
import Combine
import UIKit

import Factory

class MMSEViewModel: ObservableObject {
    
    // MARK: - Dependency
    @Injected(\.mmseService) var mmseService
    private var locationHelper = LocationHelper()
    
    // MARK: - Input State
    /// Next button 클릭 이벤트입니다.
    @Subject var tapNextButton: Void = ()
    /// 사용자가 입력하는 Text Input 값입니다.
    @Published var editTextInput: String = ""
    
    // MARK: - Ouput State
    /// Next button 상태입니다.
    @Published var nextButtonState: ButtonState = .disabled
    /// 현재 질문 인덱스입니다.
    @Published var currentIndex: Int = 0
    /// 결과 페이지로 넘어가는 NavigationLink와 바인딩된 변수입니다.
    @Published var isResultPage: Bool = false
    /// 현재 문항에 맞는 키보드 타입입니다.
    @Published var keyboardType: UIKeyboardType = .numberPad
    
    // MARK: - Data
    /// MMSE 문항 목록입니다.
    var questions: [MMSEQuestionModel] = []
    /// 정답 확인 배열입니다. 맞으면 1 틀리면 2입니다.
    /// - Note: 문항 순서(인덱스)가 Key값입니다.
    var correctAnswers: [MMSEQuestionModel: Int] = [:]
    var resultScores: [String: String] = [:]
    
    // MARK: - Cancellabe
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init() {
        locationHelper.requestAuthorization()
        self.questions = mmseService.getMMSEQuestions()
        bind()
    }
    
    // MARK: - Binding
    private func bind() {
        
        $tapNextButton
            .sink {
                // 위치기반 정답 검사가 비동기이기 때문에 컴플리션 처리
                self.checkAnswerAndUpdateResults() {
                    // 마지막 인덱스 일 시
                    if self.currentIndex >= self.questions.count - 1 {
                        self.goResultPage()
                        //                    self.requestSaveMMSE()
                    } else {
                        self.goNextQuestion()
                        self.updateKeyboardType()
                    }
                }
                
                self.resetEditTextInput()
            }
            .store(in: &cancellables)
        
        $editTextInput
            .map { text in
                self.updateButtonState()
            }
            .assign(to: \.nextButtonState , on: self)
            .store(in: &cancellables)
    }
    
    // MARK: - Sub Functions
    private func goResultPage() {
        // 결과 계산
        self.resultScores = self.mmseService.getMMSEResultScores(self.correctAnswers)
        // 계산 완료 후 Result 화면으로
        self.isResultPage = true
    }
    
    private func requestSaveMMSE() {
        // 서버에 저장
        self.mmseService.requestSaveMMESE(Array(self.correctAnswers.values))
        .sink(receiveCompletion: { _ in }, receiveValue: { _ in})
        .store(in: &self.cancellables)
    }
    
    private func goNextQuestion() {
        self.currentIndex += 1
    }
    
    private func checkAnswerAndUpdateResults(completion: @escaping () -> Void) {
        self.mmseService
            .checkIsCorrect(questionModel: self.questions[self.currentIndex],
                            userAnswer: self.editTextInput) {
                self.correctAnswers[self.questions[self.currentIndex]] = $0 ? 1 : 2
                completion()
            }
    }
    
    private func resetEditTextInput() {
        self.editTextInput = ""
    }
    
    private func updateButtonState() -> ButtonState {
        let currentQuestion = self.questions[self.currentIndex]
        
        if case .show(_) = currentQuestion.questionType {
            return .enabled
        } else {
            return self.editTextInput.count > 0 ? .enabled : .disabled
        }
    }
    
    private func updateKeyboardType() {
        self.keyboardType = {
            switch self.questions[self.currentIndex].questionType {
            case .reply(let type): return type.keyboardType
            case .arithmetic(let type): return type.keyboardType
            case .image(_): return .default
            default: return .default
            }
        }()
    }

}
