//
//  View.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/17.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    /// This function hides the keyboard when called by sending the 'resignFirstResponder' action to the shared UIApplication.
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func setCustomNavigationBar(
        dismiss: DismissAction,
        backgroundColor: Color
    ) -> some View {
        return self
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 3){
                        Group {
                            ArrowBackIcon()
                                .frame(width: 18, height: 24)
                            Text("이전으로")
                        }
                        .foregroundColor(
                            backgroundColor == .accentColor
                            ? .white
                            : .mainPurple
                        )
                        
                    }
                    .onTapGesture {
                        dismiss()
                    }
                }
            }
    }
    
    func setCustomNavigationBarHidden(
        _ hidden: Bool
    ) -> some View {
        return self
            .navigationBarBackButtonHidden(hidden)
    }
}
