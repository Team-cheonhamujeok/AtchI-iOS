//
//  SelfTestStartView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/23.
//


import SwiftUI
import Moya

struct SelfTestStartView: View {
    @Binding var path: [DiagnosisViewStack]
    
    @StateObject var selfTestViewModel: SelfTestViewModel
    
    var body: some View {
        VStack {
            // 상단 공백
            Spacer()
            
            // Title
            Text("📄")
                .font(.titleLarge)
                .padding(.all, 14)
            Text("자가진단을 시작합니다")
                .font(.titleLarge)
            
            // CardView
            SelfTestExplainCardView()
            
            // 사이 공백
            Spacer()
            
            // 다음 버튼
            DefaultButton(buttonSize: .large,
                          buttonStyle: .filled,
                          buttonColor: .mainPurple,
                          isIndicate: false)
            {
                path.append(.selfTest)
            } content: {
                Text("다음으로")
            }
            
        }
        .padding(.all, 30)
        .toolbar(.hidden, for: .tabBar)
    }
}

/// 설명 Card View
struct SelfTestExplainCardView: View {
    var body: some View {
        VStack(spacing: 7) {
            HStack(spacing: 0){
                Text("질문을 보고 ")
                Text("10년 전과 비교")
                    .foregroundColor(.mainPurple)
                Text("해서")
            }
            Text("어떻게 변했는지 선택해주세요")
            Text("")
            Text("해당하는 상황이 없다면")
            Text("해당 없음을 선택해주세요")
        }
        .frame(maxWidth: .infinity)
        .padding(25)
        .background(Color.grayBoldLine)
        .cornerRadius(20)
    }
}

//MARK: -  Preview
struct SelfTestStartView_Previews: PreviewProvider {
    static var previews: some View {
        SelfTestStartView(path: .constant([]), selfTestViewModel: SelfTestViewModel(service: DiagnosisService(provider: MoyaProvider<DiagnosisAPI>())))
    }
}
