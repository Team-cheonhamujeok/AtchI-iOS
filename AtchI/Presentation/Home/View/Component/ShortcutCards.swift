//
//  QuizShortcutCard.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/03/13.
//


import SwiftUI

import Combine

struct ShortcutCards: View {
    
//    @Subjected var new: Int
    var tapQuizShorcut: PassthroughSubject<Void, Never>
    var tapSelfDiagnosisShorcut: PassthroughSubject<Void, Never>
    
    var body: some View {
        ShortcutCard(
            title: "퀴즈 풀기",
            content: "뇌훈련을 통해\n치매 예방하기")
        .onTapGesture {
            tapQuizShorcut.send(())
        }
        
        ShortcutCard(
            title: "자가진단",
            content: "혹시 치매일까\n의심된다면")
        .onTapGesture {
            tapSelfDiagnosisShorcut.send(())
        }
    }
}
