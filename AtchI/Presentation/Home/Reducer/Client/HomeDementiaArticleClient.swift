//
//  DementiaArticleClient.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/15.
//

import Foundation

import ComposableArchitecture
@preconcurrency import SwiftUI

struct HomeDementiaArticleClient {
    var getDementiaArticles: () -> [DementiaArticleModel]
}

extension HomeDementiaArticleClient: DependencyKey {
    static let liveValue = Self(
        getDementiaArticles: {
            // Articel Meta 정보 가져오기 (파싱)
            let service = DementiaArticleService()
            return service
                .getDementiaArticles()
        }
    )
}

extension DependencyValues {
    var homeDementiaArticleClient: HomeDementiaArticleClient {
        get { self[HomeDementiaArticleClient.self] }
        set { self[HomeDementiaArticleClient.self] = newValue }
    }
}
