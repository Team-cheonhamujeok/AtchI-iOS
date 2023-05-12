//
//  SelfTestResultList.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/31.
//

import SwiftUI
import Moya

struct SelfTestResultList: View {
    
    @Binding var path: [DiagnosisViewStack]
    @StateObject var selfTestViewModel: SelfTestViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("진단 결과")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                ForEach(selfTestViewModel.selfTestResults) { value in
                    if let firstID =  selfTestViewModel.selfTestResults.first?.id {
                        if firstID == value.id {
                            SelfTestRow(result: value, isFirst: true)
                                .listRowSeparator(.hidden)
                                .padding(.vertical, 12)
                        } else {
                            SelfTestRow(result: value, isFirst: false)
                                .listRowSeparator(.hidden)
                                .padding(.vertical, 12)
                        }
                    }
                    
                    Divider()
                }
                .listStyle(.inset)
            }
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

