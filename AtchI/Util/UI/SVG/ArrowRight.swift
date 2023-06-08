//
//  ArrowRight.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/09.
//

import Foundation
import SwiftUI

/// - Note: origin size - 18x24
struct ArrowRight: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.88889*width, y: 0.50254*height))
        path.addCurve(to: CGPoint(x: 0.86393*width, y: 0.4609*height), control1: CGPoint(x: 0.88889*width, y: 0.48663*height), control2: CGPoint(x: 0.88078*width, y: 0.47306*height))
        path.addLine(to: CGPoint(x: 0.37728*width, y: 0.10386*height))
        path.addCurve(to: CGPoint(x: 0.32674*width, y: 0.08842*height), control1: CGPoint(x: 0.36418*width, y: 0.09357*height), control2: CGPoint(x: 0.34671*width, y: 0.08842*height))
        path.addCurve(to: CGPoint(x: 0.25437*width, y: 0.1427*height), control1: CGPoint(x: 0.28619*width, y: 0.08842*height), control2: CGPoint(x: 0.25437*width, y: 0.11182*height))
        path.addCurve(to: CGPoint(x: 0.2762*width, y: 0.18154*height), control1: CGPoint(x: 0.25437*width, y: 0.15767*height), control2: CGPoint(x: 0.26248*width, y: 0.17124*height))
        path.addLine(to: CGPoint(x: 0.71482*width, y: 0.50254*height))
        path.addLine(to: CGPoint(x: 0.2762*width, y: 0.82355*height))
        path.addCurve(to: CGPoint(x: 0.25437*width, y: 0.86285*height), control1: CGPoint(x: 0.26248*width, y: 0.83431*height), control2: CGPoint(x: 0.25437*width, y: 0.84788*height))
        path.addCurve(to: CGPoint(x: 0.32674*width, y: 0.91667*height), control1: CGPoint(x: 0.25437*width, y: 0.89327*height), control2: CGPoint(x: 0.28619*width, y: 0.91667*height))
        path.addCurve(to: CGPoint(x: 0.37728*width, y: 0.90123*height), control1: CGPoint(x: 0.34671*width, y: 0.91667*height), control2: CGPoint(x: 0.36418*width, y: 0.91152*height))
        path.addLine(to: CGPoint(x: 0.86393*width, y: 0.54419*height))
        path.addCurve(to: CGPoint(x: 0.88889*width, y: 0.50254*height), control1: CGPoint(x: 0.88078*width, y: 0.53202*height), control2: CGPoint(x: 0.88827*width, y: 0.51845*height))
        path.closeSubpath()
        return path
    }
}
