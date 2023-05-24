////
////  SignupReducer.swift
////  AtchI
////
////  Created by DOYEON LEE on 2023/04/29.
////
//
//import Foundation
//import Combine
//import ComposableArchitecture
//
//struct SignupReducer: ReducerProtocol {
//
////    @Dependency(\.numberFact) var numberFact
////    @Dependency(\.accountService) var accountService
//
//    let accountService: AccountService
//    private var cancellables = Set<AnyCancellable>()
//
//    struct State {
//        var count = 0
//        var email: String = ""
//        var emailVerificationCode: String = ""
//        var emailVerificationState: EmailVerificationState
//        var emailVerificationErrorMessage: String = ""
//
//        struct EmailVerificationState {
//            var sendEnable: Bool = false
//            var sended: Bool = false
//            var checkEnable: Bool = false
//            var sucess: Bool = false
//        }
//    }
//
//    enum Action {
//        //user action
//        case sendEmailVerificationButtonTapped
//        case editEmailVerificationCode(code: String)
//    }
//
//    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
//        switch action {
//        case .sendEmailVerificationButtonTapped:
//            state.emailVerificationState.sended = true
//            return .none
//
//
//        case .editEmailVerificationCode(code: let code):
//            state.emailVerificationCode = code
//            if code.count >= 10 {
//                state.emailVerificationState.sendEnable = true
//            } else {
//                state.emailVerificationState.sendEnable = false
//            }
//            return .none
//        }
//
//    }
//}
//
//
////struct AccountClient {
////  var fetch: (Int) async throws -> String
////}
////
////extension AccountClient: DependencyKey {
////    static var liveValue: AccountClient {
////        fetch {
////
////        }
////    }
////
////
////}
////
////struct NumberFactClient {
////  var fetch: (Int) async throws -> String
////}
////
////extension NumberFactClient: DependencyKey {
////  static let liveValue = Self(
////    fetch: { number in
////      let (data, _) = try await URLSession.shared
////        .data(from: .init(string: "http://numbersapi.com/\(number)")!)
////      return String(decoding: data, as: UTF8.self)
////    }
////  )
////}
////
////extension DependencyValues {
////  var numberFact: NumberFactClient {
////    get { self[NumberFactClient.self] }
////    set { self[NumberFactClient.self] = newValue }
////  }
////
////    var accountService: AccountService {
////      get { self[AccountService.self] }
////      set { self[AccountService.self] = newValue }
////    }
////}
