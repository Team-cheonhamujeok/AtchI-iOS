//
//  SelfTestResultView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/24.
//

import SwiftUI

struct SelfTestResultView: View {
    
    @Binding var path: [DiagnosisViewStack]
    
    @StateObject var selfTestViewModel: SelfTestViewModel
    
    var body: some View {
        VStack {
            // 상단 공백
            Spacer()
            
            // Title
            Text(selfTestViewModel.getImoji())
                .font(.titleLarge)
                .padding(.all, 14)
            Text(selfTestViewModel.getLevel())
                .font(.titleLarge)
                .foregroundColor(.mainPurple)
            
            // CardVIew
            SelfTestResultExplainCardView()
            
            // 사이 공백
            Spacer()
            
            // 확인 버튼
            DefaultButton(buttonSize: .large,
                          buttonStyle: .filled,
                          buttonColor: .mainPurple,
                          isIndicate: false)
            {
                path = []
                selfTestViewModel.answers = []
            } content: {
                Text("확인")
            }
        }
        .padding(.all, 30)
    }
}

//MARK: - Other View
/// 설명 Card View
struct SelfTestResultExplainCardView: View {
    var body: some View {
        VStack(spacing: 7) {
            Text("치매 위험단계인 ")
            HStack(spacing: 0){
                Text("경도인지손상이 의심")
                    .fontWeight(.bold)
                Text("됩니다.")
            }
            
            Text("")
            Text("경도인지손상이란 치매는 아니지만")
            Text("기억력이 연령과 학력수준이 비슷한")
            Text("다른 분들에 비해 뚜렷하게")
            Text("저하된 단계를 말합니다.")
            
            Text("")
            Text("보건소에서 현재 상태에 대해 ")
            Text("상담을 받아보세요")
        }
        .frame(maxWidth: .infinity)
        .padding(25)
        .background(Color.grayBoldLine)
        .cornerRadius(20)
    }
}

//MARK: - Preview
struct SelfTestResultView_Previews: PreviewProvider {
    static var previews: some View {
        SelfTestResultView(path: .constant([]), selfTestViewModel: SelfTestViewModel() )
    }
}
