//
//  MMSEViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import Foundation
import Combine

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
    @Published var goResultPage: Bool = false
    
    // MARK: - Data
    /// MMSE 문항 목록입니다.
    var questions: [MMSEQuestionModel] = []
    /// 정답 확인 배열입니다. 맞으면 1 틀리면 2입니다.
    /// - Note: 문항 순서(인덱스)가 Key값입니다.
    var correctAnswers: [MMSEQuestionModel: String] = [:]
    
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
                // 정답 저장
                self.mmseService
                    .checkIsCorrect(questionModel: self.questions[self.currentIndex],
                                    userAnswer: self.editTextInput) {
                        self.correctAnswers[self.questions[self.currentIndex]] = $0 ? "1" : "2"
                        print("answer: \(self.editTextInput), correct: \($0) isCorrect: \(self.correctAnswers)")
                    }
                
                // 마지막 인덱스일 시
                if self.currentIndex >= self.questions.count - 1 {
                    
                    // Result 화면으로
                    self.goResultPage = true
                    
                    // 서버에 저장
                    self.mmseService.requestSaveMMESE(Array(self.correctAnswers.values))
                    .sink(receiveCompletion: { _ in }, receiveValue: { _ in})
                    .store(in: &self.cancellables)
                    
                // 첫 인덱스보다 클 시 인덱스++
                } else if self.currentIndex >= 0 {
                    self.currentIndex += 1
                }
                
                // Text field 초기화
                self.editTextInput = ""
            }
            .store(in: &cancellables)
        
        // Next button 상태 관리
        $editTextInput
            .map { text in
                if case .show(_) = self.questions[self.currentIndex].viewType {
                    return .enabled
                } else {
                    return text.count > 0 ? .enabled : .disabled
                }
            }
            .assign(to: \.nextButtonState , on: self)
            .store(in: &cancellables)
    }
}
