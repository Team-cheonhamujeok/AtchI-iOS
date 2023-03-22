//
//  DiagnosisView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

struct DiagnosisView: View {
    var body: some View {
        NavigationStack {
            VStack {
                SelfTestView()
                    .padding()
                
                Rectangle()
                    .frame(height: 15)
                    .foregroundColor(.grayBoldLine)
                
                WatchInfoView()
                    .padding()
                
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
