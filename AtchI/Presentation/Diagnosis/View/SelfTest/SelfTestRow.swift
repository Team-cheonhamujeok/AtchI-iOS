//
//  SelfTestRow.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

struct SelfTestRow: View {
    var selfTest: SelfTest
    var index: Int
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 5)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
            VStack(alignment: .leading) {
                HStack {
                    if index == 0 {
                        Text("최근")
                    }
                    Text(selfTest.day)
                        .foregroundColor(.grayTextLight)
                }
                .font(.bodyLarge)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                HStack {
                    Text("\(selfTest.point)점 /")
                    Text(selfTest.level)
                }
                .font(.bodySmall)
            }
        }
    }
}

struct SelfTestRow_Previews: PreviewProvider {
    static var previews: some View {
        SelfTestRow(selfTest: SelfTest(day: "23년 01월 5일", point: 1, level: "치매 위험단계"), index: 0)
    }
}
