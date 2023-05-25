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
    
    // MARK: - Data
    var questions: [MMSEQuestionModel] = []
    var answers: [String] = []

    // MARK: - Cancellabe
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init() {
        locationHelper.getCurrentLocation {
            print("location \(String(describing: $0))")
        }
        self.questions = mmseService.getMMSEQuestions()
        bind()
    }
    
    // MARK: - Binding
    func bind() {
        
        $tapNextButton
            .sink {
                // 정답 저장
                
                // 질문 인덱스 관리
                if case .reply(let replyCase) = self.questions[self.currentIndex].viewType {
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
