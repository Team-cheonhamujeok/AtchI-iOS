//
//  SignupValidationViewModelTests.swift
//  AtchIViewModelTests
//
//  Created by DOYEON LEE on 2023/04/15.
//

@testable import AtchI
import XCTest
import Combine


final class SignupValidationViewModelTests: XCTestCase {

    private var viewModel: SignupValidationViewModel!
    private var eventToRequestViewModelExpectation: XCTestExpectation!
    private var eventFromRequestViewModelExpectation: XCTestExpectation!

    override func setUpWithError() throws {
        self.viewModel = SignupValidationViewModel(
            validationServcie: MockValidationServcie())
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        eventToRequestViewModelExpectation = expectation(description: "eventToRequestViewModel is triggered")
        eventFromRequestViewModelExpectation = expectation(description: "eventFromRequestViewModel is triggered")
    }
    
    /// - 테스트 목적: 유효한 input값이면 에러 메세지가 비어있는지 확인
    /// - 테스트 대상: 형식 검사 Error Message
    /// - 테스트 트리거: infoState의 변화
    func testInfoStateValidation() {
        let infoState = InfoState(name: MockValidation.name.valid,
                                  email: MockValidation.email.valid,
                                  birth: MockValidation.birth.valid,
                                  password: MockValidation.password.valid,
                                  passwordAgain: MockValidation.password.valid)
        viewModel.infoState = infoState
        
        XCTAssertEqual(viewModel.infoErrorState.nameErrorMessage, "")
        XCTAssertEqual(viewModel.infoErrorState.emailErrorMessage, "")
        XCTAssertEqual(viewModel.infoErrorState.birthErrorMessage, "")
        XCTAssertEqual(viewModel.infoErrorState.passwordErrorMessage, "")
        XCTAssertEqual(viewModel.infoErrorState.passwordAgainErrorMessage, "")
    }
    
    /// - 테스트 목적: 유효하지않은 input값이면 에러 메세지가 적절히 들어가는지 확인
    /// - 테스트 대상: 형식 검사 Error Message
    /// - 테스트 트리거: infoState의 변화
    func testInvalidInfoStateValidation() {
        let infoState = InfoState(name: "John12",
                                  email: "invalidemail",
                                  birth: "1",
                                  password: "1234",
                                  passwordAgain: "5678")
        viewModel.infoState = infoState
        
        XCTAssertEqual(viewModel.infoErrorState.nameErrorMessage, ValidationErrorMessage.invalidName.description)
        XCTAssertEqual(viewModel.infoErrorState.emailErrorMessage, ValidationErrorMessage.invalidEmail.description)
        XCTAssertEqual(viewModel.infoErrorState.birthErrorMessage, ValidationErrorMessage.invalidBirth.description)
        XCTAssertEqual(viewModel.infoErrorState.passwordErrorMessage, ValidationErrorMessage.invalidPassword.description)
        XCTAssertEqual(viewModel.infoErrorState.passwordAgainErrorMessage, ValidationErrorMessage.invalidPasswordAgain.description)
    }
    
    /// - 테스트 목적: 빈 input값이면 형식을 검사하지 않으므로 에러메세지가 비어있는지 확인
    /// - 테스트 대상: 형식 검사 Error Message
    /// - 테스트 트리거: infoState의 변화
    func testInfoStateEmpty() {
        let infoState = InfoState(name: "",
                                  email: "",
                                  birth: "",
                                  password: "",
                                  passwordAgain: "")
        viewModel.infoState = infoState
        
        XCTAssertEqual(viewModel.infoErrorState.nameErrorMessage, "")
        XCTAssertEqual(viewModel.infoErrorState.emailErrorMessage, "")
        XCTAssertEqual(viewModel.infoErrorState.birthErrorMessage, "")
        XCTAssertEqual(viewModel.infoErrorState.passwordErrorMessage, "")
        XCTAssertEqual(viewModel.infoErrorState.passwordAgainErrorMessage, "")
    }
    
    /// - 테스트 목적: 형식 검사를 모두 통과할 시 올바른 event를 send하는지 확인
    /// - 테스트 대상: eventToRequestViewModel
    /// - 테스트 트리거: infoState의 변화
    func testSendEvent() {
        // Given
        var event: AtchI.SignupValidationViewModelEvent?
        let cancellable = viewModel.eventToRequestViewModel
            .sink {
            event = $0
        }
        
        // When
        let infoState = InfoState(name: MockValidation.name.valid,
                                  email: MockValidation.email.valid,
                                  birth: MockValidation.birth.valid,
                                  password: MockValidation.password.valid,
                                  passwordAgain: MockValidation.password.valid)
        viewModel.infoState = infoState
        

        // Then
        var result = false
        switch event {
            case .allInputValid:
                result = true
                break
            default:
                break
        }
        XCTAssertTrue(result)
        
        cancellable.cancel()
    }

}
