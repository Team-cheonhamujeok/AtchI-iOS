//
//  TodayQuiz.swift
//  AtchI
//
//  Created by 이봄이 on 2023/04/19.
//

import Foundation

enum TodayQuiz {
   static let quizzes: [Quiz] =
    [Quiz(index: "첫", content: "오늘은 몇월 며칠인가요?"),
     Quiz(index: "두", content: "어제 누구랑 점심을 먹었나요?"),
     Quiz(index: "세", content: "오늘 아침에 일어나자마자 무엇을 했나요?")
    ]
}
