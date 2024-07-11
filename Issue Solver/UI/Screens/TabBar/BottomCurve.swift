//
//  BottomCurve.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 11.07.24.
//

import SwiftUI

struct BottomCurve: Shape {
    
    var currentXValue: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let mid = currentXValue
            path.move(to: CGPoint(x: mid - 50, y: 0))
            
            let to1 = CGPoint(x: mid, y: 70)
            let control1 = CGPoint(x: mid - 30, y: 0)
            let control2 = CGPoint(x: mid - 50, y: 70)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            
            let to2 = CGPoint(x: mid + 50, y: 0)
            let control3 = CGPoint(x: mid + 50, y: 70)
            let control4 = CGPoint(x: mid + 30, y: 0)
            
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}




#Preview {
    CustomTabBar()
}
