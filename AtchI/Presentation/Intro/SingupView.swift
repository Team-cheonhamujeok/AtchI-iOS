//
//  SingupView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/16.
//

import SwiftUI

struct SingupView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 40) {
                    Text("회원가입")
                        .font(.titleLarge)
                    
                    // Input list
                    TextInput(title: "이름", placeholder: "이름을 입력해주세요")
                    TextInput(title: "이메일", placeholder: "예) junjongsul@gmail.com")
                    ToogleInput(title:
                                    "성별", options: ["남", "여"])
                    TextInput(title: "생년월일", placeholder: "8자리 생년월일 ex.230312")
                    TextInput(title: "비밀번호", placeholder: "예) 비밀번호를 입력해주세요")
                    TextInput(title: "비밀번호 확인", placeholder: "비밀번호를 한번 더 입력해주세요")
                }
                
                // Complete Button
                Spacer(minLength: 50)
                RoundedButton(title: "회원가입하기") {
                    print("click")
                }
                
                Spacer(minLength: 50)
            }
            .padding(.horizontal, 30)
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    
    // This function hides the keyboard when called by sending the 'resignFirstResponder' action to the shared UIApplication.
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct SingupView_Previews: PreviewProvider {
    static var previews: some View {
        SingupView()
    }
}

