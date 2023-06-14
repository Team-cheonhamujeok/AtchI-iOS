//
//  SelfTestResultView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/24.
//

import SwiftUI
import Moya

struct SelfTestResultView: View {
    
    @ObservedObject var selfTestViewModel: SelfTestViewModel
//    @ObservedObject var selfTestInfoViewModel: SelfTestInfoViewModel
    
    var body: some View {
        VStack {
            // 상단 공백
            Spacer()
            
            // Title
            Text(selfTestViewModel.emoji)
                .font(.titleLarge)
                .padding(.all, 14)
            Text(selfTestViewModel.level)
                .font(.titleLarge)
                .foregroundColor(.mainPurple)
            
            // CardVIew
            SelfTestResultExplainCardView(viewModel: selfTestViewModel)
            
            // 사이 공백
            Spacer()
            
            // 확인 버튼
            DefaultButton(buttonSize: .large,
                          buttonStyle: .filled,
                          buttonColor: .accentColor,
                          isIndicate: false)
            {
                selfTestViewModel.resetAnswers()
                let stackCount = selfTestViewModel.coordinator.path.count
                selfTestViewModel.coordinator.path.removeLast(stackCount)
            } content: {
                Text("확인")
            }
        }
        .padding(.all, 30)
        .setCustomNavigationBarHidden(true)
        .background(Color.mainBackground)
    }
}

//MARK: - Other View

struct SelfTestResultExplainCardView: View {
    var viewModel: SelfTestViewModel
    var body: some View {
        let level = viewModel.level
        if level == "치매 안심 단계" {
            safeLevelView
        } else if level == "치매 위험 단계" {
            dangerousLevelView
        } else if level == "치매 단계"{
            dementiaLevelView
        } else {
            againLevelView
        }
    }
    
    /// 치매 안심 단계 View
    var safeLevelView: some View {
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
    var dangerousLevelView: some View {
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
    var dementiaLevelView: some View {
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
    
    /// 해당 없음 6개 이상 View
    var againLevelView: some View {
        VStack(spacing: 7) {
            HStack(spacing: 0){
                
                Text("해당 없음")
                    .fontWeight(.bold)
                Text("문항을 6번 이상 ")
            }
            Text("선택하셨기 때문에")
            Text("정확한 검사가 힘듭니다.")
            Text("")
            Text("자가진단을 재시도하시길 바랍니다.")
        }
        .frame(maxWidth: .infinity)
        .padding(25)
        .background(Color.grayBoldLine)
        .cornerRadius(20)
    }
}
