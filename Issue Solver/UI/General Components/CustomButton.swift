//
//  CustomButtonView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 11.06.24.
//

import SwiftUI

struct CustomButton: View {
    var width: CGFloat?
    var height: CGFloat? = 50
    let title: String
    
    let handler: () -> Void
    
    var body: some View {
        Button {
            handler()
        } label: {
            ZStack {
                Capsule().fill(Color.primaryBlue)
                Text(title)
                    .font(.title3)
                    .foregroundStyle(Color.surfaceBackground)
            }
        }
        .frame(width: width, height: height)
        .padding()
    }
    
    
}

#Preview {
    CustomButton(title: "Hi there") {
        print("Tapped")
    }
}
