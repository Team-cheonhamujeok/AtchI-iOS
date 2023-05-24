//
//  MMSEViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import Foundation
import Combine


struct MMSEAnswerModel {
    let answer: String
    var isCorrect: Bool = false
}

class MMSEViewModel: ObservableObject {
    
    // MARK: - Dependency
    private var mmseService = MMSEService()
    
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
    
    // MARK: - Data
    var questions: [MMSEQuestionModel] = []
    var answers: [String] = []

    // MARK: - Cancellabe
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init() {
        self.questions = mmseService.getMMSEQuestions()
        questions.forEach {
            print("\($0.identifier), \($0.viewType)")
        }
        bind()
    }
    
    // MARK: - Binding
    func bind() {
        
        $tapNextButton
            .sink {
                // 정답 저장
                
                // 질문 인덱스 관리
                let viewType: MMSEViewType = .reply(.year)

                if case .reply(let replyCase) = viewType {
                    // reply 케이스인 경우
                    print("Reply case: \(replyCase)")
                }
                self.currentIndex = self.currentIndex >= 0
                                    ? self.currentIndex + 1
                                    : self.currentIndex
                // Text field 초기화
                self.editTextInput = ""
            }
            .store(in: &cancellables)

        
        // Next button 상태 관리
        $editTextInput
            .map { text in
                switch self.questions[self.currentIndex].viewType {
                case .show(_): return .enabled
                default: return text.count > 0 ? .enabled : .disabled
                }
            }
            .assign(to: \.nextButtonState , on: self)
            .store(in: &cancellables)
    }
}
