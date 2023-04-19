//
//  SignupDTO.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/13.
//

import Foundation

struct SignupModel: Encodable {
    let email: String
    let pw: String
    let birthday: String
    let gender: Bool
    let name: String
    
//    enum CodingKeys: String,CodingKey {
//        case id
//        case name
//        case birth
//        case phoneNum = "phone_num"
//
//    }
}
