////
////  SignupViewModelTests.swift
////  AtchIViewModelTests
////
////  Created by DOYEON LEE on 2023/04/15.
////
//
//@testable import AtchI
//import XCTest
//import Combine
//
//
//final class SignupViewModelTests: XCTestCase {
//
//    private var viewModel: SignupViewModel!
//
//    override func setUpWithError() throws {
//        self.viewModel = SignupViewModel(accountService: MockAccountService())
//    }
//
//    override func tearDownWithError() throws {
//        self.viewModel = nil
//    }
//
//
//    // 첫번째 방식 - fulfill 이용 방법
//    func test_signup_first() {
//        // Given
//        let expectation = XCTestExpectation(description: "My Combine Test")
//        let publisher = viewModel.$signupErrorMessage // 테스트할 Combine Publisher
//        var receivedValue: String?
//
//        // When
//        let cancellable = publisher
//            .sink{ value in
//                // Then - Observable
//                    receivedValue = value
//                    expectation.fulfill()
//            }
//
//        // Test case 1
//        viewModel.signup(SignupModel(email: "1234@naver.com",
//                                     pw: "1111",
//                                     birthday: "010101",
//                                     gender: true,
//                                     name: "test_1234"))
//
//        // Then
//        wait(for: [expectation], timeout: 2.0) // expectation을 기다려서 timeout 내에 fulfill이 되는지 확인
//        XCTAssertEqual(receivedValue, nil) // 예상한 결과와 일치하는지 확인
//
//        // Clean up
//        cancellable.cancel() // 테스트가 끝나면 구독을 취소하여 리소스를 정리
//    }
//
//    // 두번째 방식 - Assert 코드를 비동기 클로저 안으로 넣음 - 클로저가 실행되기전에 평가될 가능성이 있어 안된다함..왜지?
//    func test_signup_second() {
//        // Given
//        let publisher = viewModel.$signupErrorMessage // 테스트할 Combine Publisher
//
//        // When
//        let cancellable = publisher
//            .sink{
//                // Then
//                XCTAssertEqual($0, nil) // 예상한 결과와 일치하는지 확인
//            }
//
//        // Test case 1
//        viewModel.signup(SignupModel(email: "1234@naver.com",
//                                     pw: "1111",
//                                     birthday: "010101",
//                                     gender: true,
//                                     name: "test_1234"))
//
//        // Clean up
//        cancellable.cancel() // 테스트가 끝나면 구독을 취소하여 리소스를 정리
//    }
//
//    // 세번째 방식 - 리스트 이용
//    func test_signup_multi() {
//        // Given
//        let expectation = XCTestExpectation(description: "My Combine Test")
//        let publisher = viewModel.$signupErrorMessage // 테스트할 Combine Publisher
//        var receivedValue: [String?] = []
//
//        // When
//        let cancellable = publisher
//            .dropFirst()
//            .sink{ value in
//                receivedValue.append(value)
//                expectation.fulfill()
//            }
//
//        // Test case 1
//        viewModel.signup(SignupModel(email: "1234@naver.com",
//                                     pw: "1111",
//                                     birthday: "010101",
//                                     gender: true,
//                                     name: "test_1234"))
//
//        // Test case 2
//        viewModel.signup(SignupModel(email: MockEmail.duplicatedEmail.rawValue,
//                                     pw: "1111",
//                                     birthday: "010101",
//                                     gender: true,
//                                     name: "test_1234"))
//
//        // Then
//        wait(for: [expectation], timeout: 2.0) // expectation을 기다려서 timeout 내에 fulfill이 되는지 확인
//        XCTAssertEqual(receivedValue, [nil, AccountError.emailDuplicated.krDescription()]) // 예상한 결과와 일치하는지 확인
//
//        // Clean up
//        cancellable.cancel() // 테스트가 끝나면 구독을 취소하여 리소스를 정리
//    }
//
//    // 네번째 - Extension
//    func test_signup_with_extension() {
//        // Given
//        let publisher = viewModel.$signupErrorMessage // 테스트할 Combine Publisher
//        let result = expectValue(of: publisher,
//                             equals: [nil,
//                                      AccountError.emailDuplicated.krDescription()])
//
//        // When
//        // Test case 1 - 성공
//        viewModel.signup(SignupModel(email: "1234@naver.com",
//                                     pw: "1111",
//                                     birthday: "010101",
//                                     gender: true,
//                                     name: "test_1234"))
//        
//        // Test case 2 - 실패
//        viewModel.signup(SignupModel(email: MockEmail.duplicatedEmail.rawValue,
//                                     pw: "1111",
//                                     birthday: "010101",
//                                     gender: true,
//                                     name: "test_1234"))
//
//        // Then
//         wait(for: [result.expectation], timeout: 1)
//        result.cancellable.cancel()
//    }
//
//
//    // 일반 동기 함수 테스트 -
//    func test_signup_email_validation() {
//        XCTAssertTrue(viewModel.isValidEmail("test@example.com"))
//        XCTAssertTrue(viewModel.isValidEmail("user@domain.co.uk"))
//
//        XCTAssertFalse(viewModel.isValidEmail("invalid_email"))
//        XCTAssertFalse(viewModel.isValidEmail("user@.com"))
//        XCTAssertFalse(viewModel.isValidEmail("@domain.com"))
//    }
//}
