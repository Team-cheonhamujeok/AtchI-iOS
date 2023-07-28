//
//  ProfileResponseModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/07/28.
//

import Foundation

struct ProfileResponseModel: Codable {
    let email: String
    let birthday: String
    let gender: Bool
    let name: String
}
