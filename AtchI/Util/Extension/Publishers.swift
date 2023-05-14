//
//  Publishers.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/13.
//

import Foundation
import Combine

extension Publishers {
    static func concatenateMany<Output, Failure>(_ publishers: [AnyPublisher<Output, Failure>]) -> AnyPublisher<Output, Failure> {
        return publishers.reduce(Empty().eraseToAnyPublisher()) { acc, elem in
            Publishers.Concatenate(prefix: acc, suffix: elem).eraseToAnyPublisher()
        }
    }
}
