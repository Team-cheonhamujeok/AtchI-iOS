//
//  UINavigationController+Extension.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/08/18.
//

import Foundation
import UIKit

/// custom navigation bar 에서도 swift-back이 가능하도록 하는 코드
/// ref: https://medium.com/hcleedev/swift-custom-navigationview에서-swipe-back-가능하게-하기-c3c519c59bcb
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
