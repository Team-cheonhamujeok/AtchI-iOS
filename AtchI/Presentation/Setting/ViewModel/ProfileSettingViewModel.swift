//
//  ProfileSettingViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/07/27.
//

import Foundation
import Combine

import Factory

class ProfileSettingViewModel: ObservableObject {
    
    @Injected(\.profileService) private var service: ProfileServiceType
    @Injected(\.accountService) private var accountService: AccountServiceType
    
    @Published var action = ProfileAction()
    @Published var state = ProfileState()
    @Published var cancelMembershipErrorMessage: String = ""
    
    /// 서버에서 받은 회원 탈퇴 성공 여부 메세지입니다.
    private var cancelMembershipResponseMessage: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        bind()
    }
    
    //TODO:
    private func bind() {
        
        
        let response = action
            .viewOnAppear
            .flatMap { _ in
                self.service.reqeustProfileResults(
                    email: self.state.email
                )
                .replaceError(
                    with: ProfileResponseModel(
                        email: "",
                        birthday: "",
                        gender: false,
                        name: ""
                    )
                )
            }
        
        response
            .map{$0.birthday}
            .receive(on: DispatchQueue.main)
            .assign(to: \.state.birthday, on: self)
            .store(in: &cancellables)
        
        response
            .map{$0.email}
            .receive(on: DispatchQueue.main)
            .assign(to: \.state.email, on: self)
            .store(in: &cancellables)
        
        response
            .map{$0.gender ? "남" : "여"}
            .receive(on: DispatchQueue.main)
            .assign(to: \.state.gender, on: self)
            .store(in: &cancellables)
        
        response
            .map{$0.name}
            .receive(on: DispatchQueue.main)
            .assign(to: \.state.name, on: self)
            .store(in: &cancellables)
        
    }
    
    func requestCancelMemberShip(_ email: String) {
        self.accountService
            .requestCancelMembership(email: email).print()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.cancelMembershipErrorMessage = error.description
                }
            }, receiveValue: { (result: CancelMembershipResponseModel) in
                self.cancelMembershipResponseMessage = result.message
            }).store(in: &cancellables)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "mid")
        UserDefaults.standard.removeObject(forKey: "email")
    }
    
    private func setEmailState() {
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            fatalError("User email not found")
        }
        
        self.state.email = email
    }
}
