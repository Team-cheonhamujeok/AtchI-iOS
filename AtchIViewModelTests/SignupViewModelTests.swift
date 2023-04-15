//
//  SignupViewModelTests.swift
//  AtchIViewModelTests
//
//  Created by DOYEON LEE on 2023/04/15.
//

@testable import AtchI
import XCTest

final class SignupViewModelTests: XCTestCase {

    private var viewModel: SignupViewModel!

    override func setUpWithError() throws {
        self.viewModel = SignupViewModel(accountService: MockAccountService())
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
    }

    func test_signup() {
        // Given
        let expectation = XCTestExpectation(description: "My Combine Test")
        let publisher = viewModel.$signupResult // 테스트할 Combine Publisher
        var receivedValue: String?
        
        // When

        let cancellable = publisher
            .sink(receiveCompletion: { error in
                
            }, receiveValue: { value in
                print("test \(value)")
                    receivedValue = value
                    expectation.fulfill()
            })
        
        viewModel.signup(SignupModel(email: "1234@naver.com",
                                     pw: "1111",
                                     birthday: "010101",
                                     gender: true,
                                     name: "test_1234"))
        
        // Then
        wait(for: [expectation], timeout: 2.0) // expectation을 기다려서 timeout 내에 fulfill이 되는지 확인
        XCTAssertEqual(receivedValue, "success") // 예상한 결과와 일치하는지 확인
        
        // Clean up
        cancellable.cancel() // 테스트가 끝나면 구독을 취소하여 리소스를 정리
    }

}
