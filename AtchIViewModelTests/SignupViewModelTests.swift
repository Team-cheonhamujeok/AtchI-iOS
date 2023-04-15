//
//  SignupViewModelTests.swift
//  AtchIViewModelTests
//
//  Created by DOYEON LEE on 2023/04/15.
//

@testable import AtchI
import XCTest
import Combine


final class SignupViewModelTests: XCTestCase {

    private var viewModel: SignupViewModel!

    override func setUpWithError() throws {
        self.viewModel = SignupViewModel(accountService: MockAccountService())
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
    }

    // 첫번째 방식 - fullfill 이용 방법
    func test_signup_first() {
        // Given
        let expectation = XCTestExpectation(description: "My Combine Test")
        let publisher = viewModel.$signupResult // 테스트할 Combine Publisher
        var receivedValue: String?
        
        // When
        let cancellable = publisher
            .sink(receiveCompletion: { error in
                
            }, receiveValue: { value in
                // Then - Observable
                    receivedValue = value
                    expectation.fulfill()
            })
        
        // Test case 1
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
    
    // 두번째 방식 - Assert 코드를 비동기 클로저 안으로 넣음 - 시간 제한 영향 X
    func test_signup_second() {
        // Given
        let publisher = viewModel.$signupResult // 테스트할 Combine Publisher
        
        // When
        let cancellable = publisher
            .sink(receiveCompletion: { error in
                
            }, receiveValue: { value in
                // Then
                XCTAssertEqual(value, "success") // 예상한 결과와 일치하는지 확인
            })
        
        // Test case 1
        viewModel.signup(SignupModel(email: "1234@naver.com",
                                     pw: "1111",
                                     birthday: "010101",
                                     gender: true,
                                     name: "test_1234"))
        
        // Clean up
        cancellable.cancel() // 테스트가 끝나면 구독을 취소하여 리소스를 정리
    }
    
    // 일반 동기 함수 테스트
    func test_signup_email_validation() {
        XCTAssertTrue(viewModel.isValidEmail("test@example.com"))
        XCTAssertTrue(viewModel.isValidEmail("user@domain.co.uk"))
        
        XCTAssertFalse(viewModel.isValidEmail("invalid_email"))
        XCTAssertFalse(viewModel.isValidEmail("user@.com"))
        XCTAssertFalse(viewModel.isValidEmail("@domain.com"))
    }
}
