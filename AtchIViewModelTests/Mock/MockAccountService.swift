//
//  AtchIViewModelTests.swift
//  AtchITests
//
//  Created by DOYEON LEE on 2023/04/06.
//

@testable import AtchI
import Foundation
import Combine // Cancellable 때문에 import
import Moya // Response 때문에 import

class MockAccountService: AccountServiceType {
    
    var cancellables = Set<AnyCancellable>()
    
    // 내부 퍼블리셔를 받아서 한번 더 처리한다음에 넘기기
    func reqSignup(signupModel: SignupModel) -> AnyPublisher<Response, AccountError> {
        
        // 응답 생성
        let jsonDict: [String: Any] = ["mid": "-1"]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) else {
            return Fail(error: AccountError.jsonSerializationFailed)
            .eraseToAnyPublisher()}
        
        // SignupModel에 따른 유효한 Response 값을 생성하여 AnyPublisher로 반환
        let response = Response(statusCode: 200, data: jsonData)
        return Just(response)
            .setFailureType(to: AccountError.self)
            .eraseToAnyPublisher()
    }
}
