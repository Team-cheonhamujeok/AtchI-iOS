//
//  HomeView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/12.
//

import SwiftUI

import Factory
import ComposableArchitecture

struct HomeView: View {
    
    let store: StoreOf<HomeReducer>
    
//    @StateObject var viewModel: HomeViewModel
    @StateObject var predictVM: PredictionViewModel
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                // MARK: 로고 + 앱이름
                AppTitleBar()
                    .padding(.leading, 20)
                    .padding(.top, 5)
                
                ScrollView {
                    // MARK: AI 진단 결과 섹션
                    Spacer(minLength: 15)
                    
                    VStack(alignment: .leading){
                        Text("AI 진단 결과")
                            .font(.titleMedium)
                        
                        AIDiagnosisCard(
                            startDate: $predictVM.startDate,
                            endDate: $predictVM.endDate,
                            notDementia: $predictVM.notDementia,
                            beforeDementia: $predictVM.beforeDementia,
                            dementia: $predictVM.dementia,
                            resultLevel: $predictVM.resultLevel,
                            isLoading: $predictVM.isLoading,
                            haveMMSE: $predictVM.haveMMSE,
                            haveLifePattern: $predictVM.haveLifePattern
                        )
                        
                        HStack {
                            Spacer()
                            Text("진단에 쓰이는 데이터 보러가기")
                            Image("arrow-right")
                        }
                        .foregroundColor(.grayTextLight)
                        .onTapGesture {
//                            viewModel.$tapMoveHealthInfoPage.send()
                        }
                    }
                    .padding([.leading, .trailing, .bottom], 30)
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text("바로가기")
                            .font(.titleMedium)
                        ShortcutCards(
                            tapQuizShorcutAction: {
                                viewStore.send(.tapQuizShortcut)
                            },
                            tapSelfDiagnosisShorcutAction: {
                                viewStore.send(
                                    .tapSelfDiagnosisShortcut
                                )
                            }
                        )
                    }
                    .padding(.horizontal, 30)
                    
                    
                    // MARK: 치매 정보 섹션
                    VStack(alignment: .leading, spacing: 20){
                        Text("치매 정보")
                            .font(.titleMedium)
                        DementiaAricleCardList(
                            articles: viewStore.articles
                        )
                    }
                    .padding(30)
                    
                }
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .leading)
            .background(Color.mainBackground)
            .onAppear {
                viewStore.send(.viewOnAppear)
                //            viewModel.$viewOnAppear.send(())
                predictVM.$viewOnAppear.send(())
            }
        }

    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(path: .constant(NavigationPath()))
//    }
//}
