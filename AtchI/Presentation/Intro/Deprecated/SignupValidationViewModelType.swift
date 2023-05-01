//
//  SignupValidationViewModelType.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/29.
//

import Foundation

@available(*, deprecated, message: "뷰모델간의 연결 방식이 Subject 방식으로 바뀌었습니다. Event enum을 참고해주세요")
protocol SignupValidationViewModelType {
    // Input State
    var infoState: InfoState { get set }

    // Ouput State
    var infoErrorState: InfoErrorState { get set }
}
