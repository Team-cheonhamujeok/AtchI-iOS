//
//  DiagnosisView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

struct DiagnosisView: View {
    let selfTestInfoViewModel = SelfTestInfoViewModel()
    let watchInfoViewModel = WatchInfoViewModel()
    let selfTestViewModel = SelfTestViewModel()
    
    @State private var path: [DiagnosisViewStack] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("진단")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 18)
                    
                    SelfTestInfoView(selfTestInfoViewModel: selfTestInfoViewModel, selfTestViewModel: selfTestViewModel, path: $path)
                    
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                
                Rectangle()
                    .frame(height: 15)
                    .foregroundColor(.grayBoldLine)
                
                WatchInfoView(viewModel: watchInfoViewModel)
                    .padding(.all, 30)
                
                Spacer()
            }
        }
    }
}

struct DiagnosisView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView()
    }
}
