//
//  ExplainDiagnosisView.swift
//  AtchI
//
//  Created by 강민규 on 2023/05/24.
//

import SwiftUI

struct ExplainDiagnosisView: View {
    
    var title: String
    var subTitle: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.titleMedium)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
            if let subTitle = subTitle {
                Text(subTitle)
                    .font(.bodySmall)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
        }
    }
}

struct ExplainDiagnosisView_Previews: PreviewProvider {
    static var previews: some View {
        ExplainDiagnosisView(title: "치매 자가진단 해보세요!")
    }
}

// 치매 자가진단 해보세요!
// 몇가지 질문으로 간단하게 치매 진단을 받아보세요
