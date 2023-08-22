//
//  ProfileSettingViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/07/27.
//

import Foundation
import Combine
import UIKit
import SwiftUI

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
        setEmail()
        bind()
    }
    
    private func bind() {
        
        action
            .viewOnAppear
            .flatMap { _ in
                self.service.reqeustProfileResults(email: self.state.email)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    AlertHelper.showAlert(
                        message: "정보를 가져오는데 문제가 발생했습니다. \n잠시 후 다시 시도해주세요",
                        action: UIAlertAction(
                            title: "확인",
                            style: UIAlertAction.Style.destructive
                        ))
                default: break
                }
            }, receiveValue: {
                self.state.email = $0.email
                self.state.birthday = $0.birthday
                self.state.name = $0.name
                self.state.gender = $0.gender ? "남" : "여"
            })
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
    
    private func setEmail() {
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            fatalError("User email not found")
        }
        
        self.state.email = email
    }
}
