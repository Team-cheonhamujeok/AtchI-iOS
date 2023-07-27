//
//  ProfileSettingViewModel.swift
//  AtchI
//
//  Created by 강민규 on 2023/07/27.
//

import Foundation

class ProfileSettingViewModel: ObservableObject {
    @Published var name: String = "Kang Min Gyu"
    @Published var birthday: String = "00/01/01"
    @Published var gender: String = "남"
    @Published var email: String = "mgo8434@naver.com"
    
    
}
