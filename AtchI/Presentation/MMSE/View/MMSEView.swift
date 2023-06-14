//
//  MMSEView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/23.
//

import SwiftUI

struct MMSEView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: MMSEViewModel
    
    @ObservedObject var keyboardHelper = KeyboardHelper()
    
    var body: some View {
        // 현재 문항이 image 형식이면서 키보드가 올라와있는지 -> 에 따라 문항 섹션 show/hide
        var isImageViewType: Bool {
            guard case .image(_) = viewModel.questions[viewModel.currentIndex].questionType else {
                return false
            }
            return true
        }
        
        ZStack {
            GeometryReader { rootGeometry in
                // z layer 1
                VStack(alignment: .leading, spacing: 0) {
                    // MARK: Question
                    VStack(alignment: .leading, spacing: 10) {
                        // 사진 있을 시 자리부족
                        if !(isImageViewType && keyboardHelper.isKeyboardVisible) {
                            Text(viewModel.questions[viewModel.currentIndex].order)
                                .foregroundColor(.white)
                                .opacity(0.8)
                                .font(.titleSmall)
                            Text(viewModel.questions[viewModel.currentIndex].question)
                                .foregroundColor(.white)
                                .font(.titleMedium)
                                .lineSpacing(1.2)
                        }
                    }
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .frame(minHeight: (isImageViewType && keyboardHelper.isKeyboardVisible)
                           ? 0
                           : rootGeometry.size.height * 0.3)
                    .padding(.horizontal, 30)
                    .background(Color.accentColor)
                    
                    // MARK: Answer
                    VStack {
                        switch viewModel.questions[viewModel.currentIndex].questionType {
                        case .reply(let replyType):
                            ReplyAnswerInput(text: $viewModel.editTextInput, keybaordType: $viewModel.keyboardType,
                                             viewType: replyType)
                        case .arithmetic(let arithmeticType):
                            ArithmeticAnswerInput(text: $viewModel.editTextInput, keyboardType: $viewModel.keyboardType,
                                                  viewType: arithmeticType)
                        case .show(let showType):
                            ShowTextView(text: $viewModel.editTextInput,
                                         viewType: showType)
                        case .image(let imageType):
                            ImageAnswerInput(text: $viewModel.editTextInput, keybaordType: $viewModel.keyboardType,
                                             viewType: imageType)
                        case .undefined:
                            EmptyView()
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 80)
                    
                    Spacer()
                }
                .background(Color.mainBackground)
            }
            
            // z layer 2
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
        .navigationBarBackButtonHidden()
        .setCustomNavigationBar(
            dismiss: dismiss,
            backgroundColor: .mainPurple
        )
        .contentShape(Rectangle())
        .onTapGesture {
            hideKeyboard()
        }
    }
}

import StackCoordinator

struct MMSEView_Previews: PreviewProvider {
    static var previews: some View {
        MMSEView(
            viewModel: MMSEViewModel(
                coordinator: BaseCoordinator<MMSELink>()
            )
        )
    }
}


