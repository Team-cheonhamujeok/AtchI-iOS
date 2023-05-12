//
//  SelfTestRow.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

struct SelfTestRow: View {
    var result: SelfTestResult
    var isFirst: Bool
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 5)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
            VStack(alignment: .leading) {
                HStack {
                    if isFirst {
                        Text("최근")
                    }
                    Text(result.date)
                        .foregroundColor(.grayTextLight)
                }
                .font(.bodyLarge)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                HStack {
                    Text("\(result.point)점 /")
                    Text(result.level)
                }
                .font(.bodySmall)
            }
        }
    }
}

