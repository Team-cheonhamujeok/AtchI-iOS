//
//  ProfileService.swift
//  AtchI
//
//  Created by 강민규 on 2023/07/27.
//

import Foundation
import Combine

import CombineMoya
import Moya


protocol ProfileServiceType {
    func reqeustProfileResults(email: String) -> AnyPublisher<ProfileResponseModel, ProfileError>
}

class ProfileService: ProfileServiceType {
    let provider: MoyaProvider<ProfileAPI>
    var cancellables = Set<AnyCancellable>()
    
    init(provider: MoyaProvider<ProfileAPI>) {
        self.provider = provider
    }
    
    func reqeustProfileResults(email: String) -> AnyPublisher<ProfileResponseModel, ProfileError> {
        return provider.requestPublisher(.getList(email: email))
            .tryMap { response -> ProfileResponseModel in
                return try response.map(ProfileResponseModel.self)
            }
            .mapError { error in
                return ProfileError.getFail
            }
            .eraseToAnyPublisher()
    }
    
}
