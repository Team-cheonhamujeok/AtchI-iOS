//
//  MMSEView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI

struct MMSEView: View {
    
    @StateObject var viewModel: MMSEViewModel
    
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
                            .lineSpacing(1.2)
                    }
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .frame(minHeight: 200)
                    .padding(.horizontal, 30)
                    .background(Color.accentColor)
                    .animation(.easeIn, value: viewModel.currentIndex)
                    
                    // MARK: Answer
                    VStack {
                        switch viewModel.questions[viewModel.currentIndex].viewType {
                        case .reply(let replyType):
                            ReplyAnswerInput(text: $viewModel.editTextInput,
                                             viewType: replyType)
                        case .arithmetic(let arithmeticType):
                            ArithmeticAnswerInput(text: $viewModel.editTextInput,
                                                  viewType: arithmeticType)
                        case .show(let showType):
                            ShowTextView(text: $viewModel.editTextInput,
                                         viewType: showType)
                        case .image(let imageType):
                            ImageAnswerInput(text: $viewModel.editTextInput,
                                  viewType: imageType)
                        case .undefined:
                            EmptyView()
                        }
                    }
                    .padding(30)
                    .animation(.easeIn, value: viewModel.currentIndex)
                    
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


