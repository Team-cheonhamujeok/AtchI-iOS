//
//  DiagnosisView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

struct DiagnosisView: View {
    let selfTestViewModel = SelfTestInfoViewModel()
    let watchInfoViewModel = WatchInfoViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SelfTestInfoView(viewModel: selfTestViewModel)
                    .padding(.all, 20)
                
                Rectangle()
                    .frame(height: 15)
                    .foregroundColor(.grayBoldLine)
                
                WatchInfoView(viewModel: watchInfoViewModel)
                    .padding(.all, 20)
                
                Spacer()
            }
            .navigationTitle("진단")
        }
        
    }
}

struct DiagnosisView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView()
    }
}
