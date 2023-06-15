//
//  AppTitleBar.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/13.
//

import SwiftUI

struct AppTitleBar: View {
    
    @State var isPresentModal = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack{
            Image("logo_gray")
                .imageScale(.large)
            Text("엣치")
                .font(.bodyLarge)
                .foregroundColor(.grayTextLight)
            Spacer()
            Image("question_circle")
                .foregroundColor(.grayDisabled)
                .padding(.trailing, 20)
                .onTapGesture {
                   isPresentModal = true
                }
                
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .sheet(isPresented: $isPresentModal) {
            ReadMeView(urlToLoad: "https://jewel-afternoon-b07.notion.site/AtchI-532340fcc4d849f3bd3fae02684a138c?pvs=4")
        }
    }
}
