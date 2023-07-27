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
    
    @Injected(\.profileSerivce) private var service: ProfileServiceType

    @Published var action = ProfileAction()
    @Published var state = ProfileState()
   
    var cancellables = Set<AnyCancellable>()

    init() {
        bind()
    }
    
    //TODO:
    private func bind() {
        var response = action
                        .viewOnAppear
                        .flatMap { _ in
                            self.service.reqeustProfileResults(email: "")
                                .replaceError(with: ProfileResponseModel(email: "", birthday: "", gender: false, name: ""))
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
            .map{$0.gender ? "남" : "ㅇㅕ"}
            .receive(on: DispatchQueue.main)
            .assign(to: \.state.gender, on: self)
            .store(in: &cancellables)
        
        response
            .map{$0.name}
            .receive(on: DispatchQueue.main)
            .assign(to: \.state.name, on: self)
            .store(in: &cancellables)
        
    }
}
