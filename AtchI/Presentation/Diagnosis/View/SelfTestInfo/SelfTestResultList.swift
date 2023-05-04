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
    
    var selfTestViewModel: SelfTestViewModel
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("진단 결과")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                
                // 자가진단 전체 리스트
                ForEach(selfTestViewModel.selfTestResults.indices, id: \.self) { index in
                    SelfTestRow(selfTestResult: selfTestViewModel.selfTestResults[index],
                                index: index)
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 12)
                    
                    Divider()
                }
                .listStyle(.inset)
            }
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SelfTestResultList_Previews: PreviewProvider {
    static var previews: some View {
        SelfTestResultList(path: .constant([]), selfTestViewModel: SelfTestViewModel(service: DiagnosisService(provider: MoyaProvider<DiagnosisAPI>())))
    }
}
