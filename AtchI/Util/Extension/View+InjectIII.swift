//
//  View+InjectIII.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/31.
//
#if DEBUG
private var loadInjection: () = {
    guard objc_getClass("InjectionClient") == nil else { return }
    #if os(macOS) || targetEnvironment(macCatalyst)
    let bundleName = "macOSInjection.bundle"
    #elseif os(tvOS)
    let bundleName = "tvOSInjection.bundle"
    #elseif targetEnvironment(simulator)
    let bundleName = "iOSInjection.bundle"
    #else
    let bundleName = "maciOSInjection.bundle"
    #endif
//    Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/"+bundleName)!.load()
}()

import Combine
import SwiftUI

public let injectionObserver = InjectionObserver()

public class InjectionObserver: ObservableObject {
    @Published var injectionNumber = 0
    var cancellable: AnyCancellable? = nil
    let publisher = PassthroughSubject<Void, Never>()
    init() {
        cancellable = NotificationCenter.default.publisher(for:
            Notification.Name("INJECTION_BUNDLE_NOTIFICATION"))
            .sink { [weak self] change in
            self?.injectionNumber += 1
            self?.publisher.send()
        }
    }
}

extension View {
    public func eraseToAnyView() -> some View {
        _ = loadInjection
        return AnyView(self)
    }
    public func onInjection(bumpState: @escaping () -> ()) -> some View {
        return self
            .onReceive(injectionObserver.publisher, perform: bumpState)
            .eraseToAnyView()
    }
}
#else
extension View {
    public func eraseToAnyView() -> some View { return self }
    public func onInjection(bumpState: @escaping () -> ()) -> some View {
        return self
    }
}
#endif
