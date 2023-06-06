//
//  MMSEResultView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/30.
//

import SwiftUI

import StackCoordinator

struct MMSEResultView: View {
    
    let resultScores: [String: String]
    let coordinator: BaseCoordinator<MMSELink>
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // 검사 결과 안내
                    Spacer(minLength: 20)
                    Text("검사가 완료되었습니다")
                        .font(.titleLarge)
                        .foregroundColor(.mainPurple)
                    Text("""
                          본 검사는 간이 검사로 실제 MMSE 검사와는 문항수에서 차이가 있습니다.
                         따라서 문항별 점수만 제공해드리며, 총점을 이용한 진단 결과는 제공해드리지 않는 점 양해부탁드립니다.
                          정확한 검사를 위해서는 전문가와 상담하시길 권장드립니다.
                        """)
                    .font(.bodyMedium)
                    .foregroundColor(.grayTextLight)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    
                    // 검사 결과
                    Spacer(minLength: 5)
                    MMSEResultStack(resultScores: resultScores)
                    Spacer(minLength: 50)
                }
                .padding(30)
                
                
            }
            
            // 확인 버튼
            VStack {
                Spacer()
                VStack {
                    Text("확인")
                        .font(.titleSmall)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 65)
                .background(Color.accentColor)
                .cornerRadius(20)
                .onTapGesture {
                    coordinator.path.removeAll()
                }
            }
            .padding(.horizontal, 30)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct MMSEResultView_Previews: PreviewProvider {
    static var previews: some View {
        MMSEResultView(
            resultScores: [:],
            coordinator: BaseCoordinator(
                path: .constant(NavigationPath())
            )
        )
    }
}
