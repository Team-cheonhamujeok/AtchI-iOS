//
//  AccountServiceTests.swift
//  AtchIServiceTests
//
//  Created by DOYEON LEE on 2023/05/05.
//

@testable import AtchI
import XCTest
import Combine
import Moya

final class AccountServiceTests: XCTestCase {
    
    var service: AccountService!
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        service = AccountService(provider: MoyaProvider<AccountAPI>(stubClosure: MoyaProvider.immediatelyStub))
    }

    override func tearDownWithError() throws {
        service = nil
    }
    
    /// 로그인 성공 테스트입니다.
    func testLoginSuccess() {
        // Given
        var received: LoginResponseModel?
        
        // When
        service
            .requestLogin(loginModel: LoginAPIMock.success.request)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                received = result
            })
            .store(in: &cancellables)
        
        // Then
        let response = LoginAPIMock.success.response
        let jsonData = try! JSONSerialization.data(withJSONObject: response, options: [])
        let decoder = JSONDecoder()
        let expected = try! decoder.decode(LoginResponseModel.self, from: jsonData)
        
        XCTAssertEqual(received, expected)
    }
    
    /// 로그인 실패(비밀번호 틀림) 테스트입니다.
    ///
    /// - 조건값: LoginAPIMock.wrongPassword.request (LoginRequestModel)
    /// - 기댓값: AccountError.login(.wrongPassword)
    func testLoginWrongPassword() throws {
        // Given
        let requestModel: LoginRequestModel = LoginAPIMock.wrongPassword.request
        
        // When
        var receivedError: AccountError?
        service.requestLogin(loginModel: requestModel)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    receivedError = error
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        // Then
        XCTAssertEqual(receivedError, AccountError.login(.wrongPassword))
    }
    
    /// 로그인 실패(존재하지 않는 유저) 테스트입니다.
    ///
    /// - 조건값: LoginAPIMock.userNotFound.request (LoginRequestModel)
    /// - 기댓값: AccountError.login(.userNotFound)
    func testLoginUserNotFound() throws {
        // Given
        let requestModel: LoginRequestModel = LoginAPIMock.userNotFound.request
        
        // When
        var receivedError: AccountError?
        service.requestLogin(loginModel: requestModel)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    receivedError = error
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        // Then
        XCTAssertEqual(receivedError, AccountError.login(.userNotFound))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
