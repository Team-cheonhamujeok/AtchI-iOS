//
//  MMSEView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI

struct MMSEView: View {
    
    @ObservedObject var viewModel: MMSEViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBarWithBackButton(bgColor: .mainPurple)
            ZStack {
                // layer 1
                VStack(alignment: .leading, spacing: 0) {
                    // MARK: Question
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.questions[viewModel.currentIndex].order)
                            .foregroundColor(.white)
                            .opacity(0.8)
                            .font(.titleSmall)
                        Text(viewModel.questions[viewModel.currentIndex].question)
                            .foregroundColor(.white)
                            .font(.titleMedium)
                    }
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .frame(minHeight: 150)
                    .padding(.horizontal, 30)
                    .background(Color.accentColor)
                    .animation(.easeIn, value: viewModel.currentIndex)
                    
                    // MARK: Answer
                    VStack {
                        switch viewModel.questions[viewModel.currentIndex].viewType {
                        case .reply(let reply):
                            ReplyAnswerInput(text: $viewModel.editTextInput,
                                             viewType: reply)
                        case .arithmetic(let arithmetic):
                            EmptyView()
                        case .show(let show):
                            EmptyView()
                        case .image(let image):
                            EmptyView()
                        case .undefined:
                            EmptyView()
                        }
                    }.padding(30)
                    Spacer()
                }
                
                // layer 2
                VStack {
                    Spacer()
                    // MARK: Next button
                    RoundedButton(title: viewModel.currentIndex == viewModel.questions.count - 1
                                  ? "완료하기"
                                  : "다음으로",
                                  onTap: viewModel.$tapNextButton,
                                  state: viewModel.nextButtonState)
                    .padding(30)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .background(Color.mainBackground)
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

struct MMSEView_Previews: PreviewProvider {
    static var previews: some View {
        MMSEView(viewModel: MMSEViewModel())
    }
}


