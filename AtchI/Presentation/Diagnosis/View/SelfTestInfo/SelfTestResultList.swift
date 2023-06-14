//
//  SelfTestResultList.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/31.
//

import SwiftUI
import Moya

struct SelfTestResultList: View {
    
    @ObservedObject var selfTestInfoViewModel: SelfTestInfoViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("진단 결과")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                ForEach(selfTestInfoViewModel.selfTestResults) { value in
                    if let firstID =  selfTestInfoViewModel.selfTestResults.first?.id {
                        if firstID == value.id {
                            TestRow(result: value, isFirst: true)
                                .listRowSeparator(.hidden)
                                .padding(.vertical, 12)
                        } else {
                            TestRow(result: value, isFirst: false)
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
        .background(Color.mainBackground)
    }
}

