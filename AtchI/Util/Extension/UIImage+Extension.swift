//
//  UIImage+Extension.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/10.
//

import Foundation
import UIKit

extension UIImage {
    /// TabVeiw 배경 이미지로 보더 설정
    static func borderImageWithBounds(
        bounds: CGRect,
        color: UIColor,
        thickness: CGFloat)
    -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setLineWidth(thickness)
        context.setBlendMode(.overlay) // 오버레이 블렌드 모드 설정
        
        let shadowRect = CGRect(x: 0, y: 0, width: bounds.width, height: thickness)
        context.setStrokeColor(
            color.withAlphaComponent(0.2).cgColor
        )
        context.setShadow(offset: .zero, blur: thickness, color: color.cgColor)
        context.stroke(shadowRect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
