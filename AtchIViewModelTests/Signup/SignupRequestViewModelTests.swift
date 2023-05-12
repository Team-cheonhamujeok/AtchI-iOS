//
//  SignupRequestViewModelTests.swift
//  AtchIViewModelTests
//
//  Created by DOYEON LEE on 2023/04/30.
//

@testable import AtchI
import XCTest
import Moya

final class SignupRequestViewModelTests: XCTestCase {
    
    private var viewModel: SignupRequestViewModel!

    override func setUpWithError() throws {
        self.viewModel = SignupRequestViewModel(
            accountService: AccountService(provider: MoyaProvider<AccountAPI>())) // TODO: Mock으로 수정
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
    }

    func testSignupSuccess() {
        // Given
        let publisher = viewModel.$signupState
        var receivedValue: String? = nil
        let cancellable = publisher.sink{ value in
                // 이벤트 받을 시 저장
                receivedValue = value.failMessage
            }
        
        // When
        // Test case 1
        viewModel.reqeustSignup(SignupReqeustModel(email: "1234@naver.com",
                                     pw: "1111",
                                     birthday: "010101",
                                     gender: true,
                                     name: "test_1234"))
        
        // Then
        XCTAssertEqual(receivedValue, "")
        
        // Clean up
        cancellable.cancel()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
