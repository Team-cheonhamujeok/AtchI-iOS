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
            Text(selfTestViewModel.getEmoji())
                .font(.titleLarge)
                .padding(.all, 14)
            Text(selfTestViewModel.getLevel())
                .font(.titleLarge)
                .foregroundColor(.mainPurple)
            
            // CardVIew
            SelfTestResultExplainCardView(viewModel: selfTestViewModel)
            
            // 사이 공백
            Spacer()
            
            // 확인 버튼
            DefaultButton(buttonSize: .large,
                          buttonStyle: .filled,
                          buttonColor: .mainPurple,
                          isIndicate: false)
            {
                path = []
                selfTestViewModel.resetAnswers()
                
            } content: {
                Text("확인")
            }
        }
        .padding(.all, 30)
    }
}

//MARK: - Other View

struct SelfTestResultExplainCardView: View {
    var viewModel: SelfTestViewModel
    var body: some View {
        let level = viewModel.getLevel()
        if level == "치매 안심 단계" {
            safeLevel
        } else if level == "치매 위험 단계" {
            dangerousLevel
        } else if level == "치매 단계"{
            dementiaLevel
        } else {
            Text("Not Found 404")
        }
    }
    
    /// 치매 안심 단계 View
    var safeLevel: some View {
        VStack(spacing: 7) {
            HStack(spacing: 0) {
                Text("치매가 ")
                Text("아닌 것")
                    .fontWeight(.bold)
                Text("으로 보입니다.")
            }
            Text("")
            
            Text("그러나 이후 기억력이나 기타 지적 능력이  ")
            Text("지금보다 나빠지는 느낌이 있다면")
            Text("보건소로 오셔서")
            
            Text("")
            Text("상담을 받아보도록 하십시오.")
        }
        .frame(maxWidth: .infinity)
        .padding(25)
        .background(Color.grayBoldLine)
        .cornerRadius(20)
    }
    
    /// 치매 위험 단계 View
    var dangerousLevel: some View {
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
    
    /// 치매 단계 View
    var dementiaLevel: some View {
        VStack(spacing: 7) {
            HStack(spacing: 0){
                Text("현재 ")
                Text("치매")
                    .fontWeight(.bold)
                Text("일 가능성이 높습니다.")
            }
            
            Text("")
            Text("보건소로 오셔서 ")
            HStack(spacing: 0) {
                Text("치매조기선별검사")
                    .fontWeight(.bold)
                Text("를 받으시길 바랍니다.")
            }
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
