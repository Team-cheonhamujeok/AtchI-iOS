//
//  TypeState.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/04/29.
//

import Foundation
import Combine

@propertyWrapper
struct TypeState<T> {
    private var publisher: PassthroughSubject<T, Never>
    private var state: T
    
    init(wrappedValue: T) {
        self.state = wrappedValue
        self.publisher = PassthroughSubject<T, Never>()
    }

    var wrappedValue: T {
        get { state }
        set {
            state = newValue
//            subject.send(newValue)
        }
    }
    
    var projectedValue: AnyPublisher<T, Never> {
        publisher.eraseToAnyPublisher()
    }
    
    func send(_ event: T) {
//        self.subject.send(event)
    }
    
    func offff() {
        print("헤헹")
    }
}

class newClass {
    @TypeState var typeState: String = ""

    func newFunc() {
    }
}
