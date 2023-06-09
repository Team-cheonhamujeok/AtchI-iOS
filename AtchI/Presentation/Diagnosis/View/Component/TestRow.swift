//
//  SelfTestRow.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

struct TestRow: View {
    var result: TestRowModel
    var isFirst: Bool
    
    var body: some View {
        HStack {
//            Text("1")
//                .frame(width: 10)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    if isFirst {
                        Text("최근")
                    }
                    Text(DateHelper.convertFormat(string: result.date))
                        .foregroundColor(.grayTextLight)
                }
                .font(.bodyLarge)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                
                HStack {
                    Text("\(result.point)점 ")
                    if let level = result.level
                    {
                        Text("/")
                        Text(level)
                    }
                    
                }
                .font(.bodySmall)
            }
        }
    }
}

