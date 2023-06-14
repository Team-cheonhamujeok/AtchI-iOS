//
//  ProfileSettingView.swift
//  AtchI
//
//  Created by 강민규 on 2023/06/02.
//

import SwiftUI

struct ProfileSettingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = "강민규"
    @State var password: String = "********"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            
            VStack (spacing: 30){
                
                FixValueField(title: "이름",
                              content: name,
                              action: {
                    
                })
                
                FixValueField(title: "비밀번호",
                              content: password,
                              action: {
                    
                })
                
                Spacer()
                
                VStack(spacing: 15) {
                    
                    DefaultButton(buttonSize: .small,
                                  width: .infinity,
                                  height: 40,
                                  buttonStyle: .filled,
                                  tintColor: .mainPurple,
                                  buttonColor:  .mainPurpleLight,
                                  isIndicate: false)
                    {
                        
                    } content: {
                        Text("로그아웃")
                    }
                    
                    DefaultButton(buttonSize: .small,
                                  width: .infinity,
                                  height: 40,
                                  buttonStyle: .filled,
                                  tintColor: .grayTextLight,
                                  buttonColor: .grayBoldLine,
                                  isIndicate: false)
                    {
                        
                    } content: {
                        Text("회원탈퇴")
                    }
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

struct FixValueField: View {
    var title: String
    var content: String
    var action: () -> Void
    var body: some View {
        VStack (alignment: .leading) {
            // Title
            HStack {
                Text(title)
                    .font(.bodyLarge)
                Spacer()
                Button("변경", action: action)
                    .foregroundColor(.mainText)
            }
            
            // Input rectangle
            ZStack {
                // Outline
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(
                                Color.mainPurpleLight
                                ,
                                lineWidth: 2)
                            .background(Color.mainBackground)
                    )
                    .frame(maxWidth: .infinity,
                           minHeight: 65,
                           maxHeight: 65)
                
                HStack {
                    Text(content)
                        .foregroundColor(.grayDisabled)
                        .padding(20)
                    Spacer()
                }
            }
        }
    }
}
