//
//  SplashScreen.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 26.07.24.
//

import SwiftUI

struct SplashScreen: View {
    @State var timer: Timer?
    @State var currentX: CGFloat = -UIScreen.main.bounds.width
    let completion: () -> Void
    
    var body: some View {
        HStack {
            circleView
            textView
        }
        .offset(x: currentX)
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in
                completion()
            })
            withAnimation(.bouncy(duration: 1.5)) {
                currentX = 0
            }
        }
    }
    
    var circleView: some View {
        Circle()
            .fill(Color.primaryBlue)
            .frame(width: 30, height: 30)
    }
    
    var textView: some View {
        Text("Issue Solver")
            .foregroundStyle(Color.primaryBlue)
            .jakartaFont(.custom(.semiBold, 30))
    }
}

