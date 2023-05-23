//
//  MMSEViewModel.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import Foundation
import Combine

struct MMSEQuestionModel {
    let identifier: String
    let order: String
    let question: String
}

class MMSEViewModel: ObservableObject {
    
    // MARK: - Dependency
    var bundelHelper = BundelHelper()
    
    // MARK: - Input State
    @Subject var tabNextButton: Void = ()
    
    // MARK: - Ouput State
    @Published var buttonState: ButtonState = .disabled
    @Published var currentIndex: Int = 0
    var questions: [MMSEQuestionModel] = []

    // MARK: - Cancellabe
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructor
    init() {
        bind()
        getMMSEQuestions()
    }
    
    // MARK: - Binding
    func bind() {
        $tabNextButton
            .map {
                self.currentIndex + 1
            }
            .filter {
                $0 < self.questions.count
            }
            .assign(to: \.currentIndex , on: self)
            .store(in: &cancellables)
    }
    
    // MARK: - Other...
    /// MMSE plist 파일에 있는 식별자와 질문을 파싱해 MMSEQuestionModel로 변환합니다.
    private func getMMSEQuestions() {
        // plist 파일 가져오기 & 파싱
        let plist = bundelHelper.parsePlist("MMSEQuestions")
        
        self.questions = plist.enumerated().compactMap { idx, item in
            guard let identifier = item["identifier"],
                  let question = item["question"]
            else { return nil }
            
            return MMSEQuestionModel(identifier: identifier,
                                     order: numberToKoreanOrdinal(idx+1),
                                     question: question)
        }
    }
    
    /// 기수를 서수로 변환합니다.
    ///
    /// 1, 2, 3 ... -> "첫번째", "두번째", "세번째" 로 변환합니다. 근데 안대냉 ㅎㅎ
    private func numberToKoreanOrdinal(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        guard let numberString = formatter.string(from: NSNumber(value: number)) else {
            return ""
        }
        return numberString + "번째"
    }

}
