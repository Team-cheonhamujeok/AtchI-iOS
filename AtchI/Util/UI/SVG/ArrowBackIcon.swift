//
//  ArrowBackIcon.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/06/07.
//

import Foundation
import SwiftUI

struct ArrowBackIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.11111*width, y: 0.49746*height))
        path.addCurve(to: CGPoint(x: 0.13607*width, y: 0.5391*height), control1: CGPoint(x: 0.11111*width, y: 0.51337*height), control2: CGPoint(x: 0.11922*width, y: 0.52694*height))
        path.addLine(to: CGPoint(x: 0.62272*width, y: 0.89614*height))
        path.addCurve(to: CGPoint(x: 0.67326*width, y: 0.91158*height), control1: CGPoint(x: 0.63582*width, y: 0.90643*height), control2: CGPoint(x: 0.65329*width, y: 0.91158*height))
        path.addCurve(to: CGPoint(x: 0.74563*width, y: 0.8573*height), control1: CGPoint(x: 0.71381*width, y: 0.91158*height), control2: CGPoint(x: 0.74563*width, y: 0.88818*height))
        path.addCurve(to: CGPoint(x: 0.72379*width, y: 0.81846*height), control1: CGPoint(x: 0.74563*width, y: 0.84233*height), control2: CGPoint(x: 0.73752*width, y: 0.82875*height))
        path.addLine(to: CGPoint(x: 0.28518*width, y: 0.49746*height))
        path.addLine(to: CGPoint(x: 0.72379*width, y: 0.17645*height))
        path.addCurve(to: CGPoint(x: 0.74563*width, y: 0.13715*height), control1: CGPoint(x: 0.73752*width, y: 0.16569*height), control2: CGPoint(x: 0.74563*width, y: 0.15212*height))
        path.addCurve(to: CGPoint(x: 0.67326*width, y: 0.08333*height), control1: CGPoint(x: 0.74563*width, y: 0.10673*height), control2: CGPoint(x: 0.71381*width, y: 0.08333*height))
        path.addCurve(to: CGPoint(x: 0.62272*width, y: 0.09878*height), control1: CGPoint(x: 0.65329*width, y: 0.08333*height), control2: CGPoint(x: 0.63582*width, y: 0.08848*height))
        path.addLine(to: CGPoint(x: 0.13607*width, y: 0.45581*height))
        path.addCurve(to: CGPoint(x: 0.11111*width, y: 0.49746*height), control1: CGPoint(x: 0.11922*width, y: 0.46798*height), control2: CGPoint(x: 0.11173*width, y: 0.48155*height))
        path.closeSubpath()
        return path
    }
}
