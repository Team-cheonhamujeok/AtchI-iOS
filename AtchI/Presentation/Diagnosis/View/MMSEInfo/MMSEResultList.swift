//
//  MMSEResultList.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/25.
//

import SwiftUI

struct MMSEResultList: View {

    @ObservedObject var mmseInfoViewModel: MMSEInfoViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("진단 결과")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                ForEach(mmseInfoViewModel.testResults) { value in
                    if let firstID =  mmseInfoViewModel.testResults.first?.id {
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
    }
}
