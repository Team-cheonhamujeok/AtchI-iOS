//
//  ProfileSettingView.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/02.
//

import SwiftUI

struct ProfileSettingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ProfileSettingViewModel()
    
    var body: some View {
        VStack (spacing: 30) {
            ProfileCell(title: "이름",
                        content: $viewModel.name)
            ProfileCell(title: "생년월일",
                        content: $viewModel.birthday)
            ProfileCell(title: "성별",
                        content: $viewModel.gender)
            ProfileCell(title: "이메일",
                        content: $viewModel.email)
            
            Spacer()
            VStack(spacing: 15) {
                DefaultButton(buttonSize: .small,
                              width: .infinity,
                              height: 40,
                              buttonStyle: .filled,
                              tintColor: .grayTextLight,
                              buttonColor:  .grayBoldLine,
                              isIndicate: false)
                {} content: {
                    Text("로그아웃")
                }
                DefaultButton(buttonSize: .small,
                              width: .infinity,
                              height: 40,
                              buttonStyle: .filled,
                              tintColor: .mainRed,
                              buttonColor: .mainRedLight,
                              isIndicate: false)
                {} content: {
                    Text("회원탈퇴")
                }
            }
        }
        .navigationTitle("개인정보")
        .navigationBarTitleDisplayMode(.inline)
        .padding(30)
        .background(Color.mainBackground)
        .setCustomNavigationBar(
            dismiss: dismiss,
            backgroundColor: .mainBackground
        )
    }
    
}

struct ProfileSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingView()
    }
}

struct ProfileCell: View {
    var title: String
    @Binding var content: String
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.bodyLarge)
                    .fontWeight(.bold)
                Text(content)
                    .font(.bodyMedium)
            }
            Spacer()
        }
    }
}
