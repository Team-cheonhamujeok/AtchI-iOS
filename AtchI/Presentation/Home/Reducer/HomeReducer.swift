//
//  HomeReducer.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/15.
//

import Foundation

import ComposableArchitecture
@preconcurrency import SwiftUI

struct DementiaArticleClient {
  var fetch: () -> [DementiaArticleModel]
}

extension DementiaArticleClient: DependencyKey {
    static let liveValue = Self(
        fetch: {
          // Articel Meta 정보 가져오기 (파싱)
          let plist = BundleHelper
              .shared
              .parsePlistFile("DementiaArticelsMeta")
          
          return plist.enumerated().compactMap { idx, item -> DementiaArticleModel? in
              guard let title = item["title"],
                    let imageName = item["imageName"],
                    let richTextfileName = item["richTextfileName"]
              else { return nil }
              
              let content = BundleHelper
                  .shared
                  .parseRichTextFile(richTextfileName)
              
              return DementiaArticleModel(title: title,
                                          imageName: imageName,
                                          richTextfileName: richTextfileName,
                                          content: content)
          }
      }
    )
}

extension DependencyValues {
  var dementiaArticleClient: DementiaArticleClient {
    get { self[DementiaArticleClient.self] }
    set { self[DementiaArticleClient.self] = newValue }
  }
}

struct HomeReducer: ReducerProtocol {
    
    struct State: Equatable {
        var articles: [DementiaArticleModel] = []
    }
    
    enum Action: Equatable {
        case viewOnAppear
        case tapMoveHealthInfoPage
        case tapQuizShortcut
        case tapSelfDiagnosisShortcut
        // inner
        case setDementiaArticles(_: [DementiaArticleModel])
    }
    
    @Dependency(\.dementiaArticleClient) var dementiaArticleClient
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {

        case .viewOnAppear:
            return .run { send in
                await send(.setDementiaArticles(dementiaArticleClient.fetch()))
            }
        case .tapMoveHealthInfoPage:
            return .none
        case .tapQuizShortcut:
            return .none
        case .tapSelfDiagnosisShortcut:
            return .none
        case .setDementiaArticles(let articles):
            state.articles = articles
            return .none
        }
    }
}
