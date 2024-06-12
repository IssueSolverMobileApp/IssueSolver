//
//  CustomButtonView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 11.06.24.
//

import SwiftUI

enum CustomButtonStyle {
    case text
    case rounded
}

struct CustomButton: View {
    var style: CustomButtonStyle = .rounded
    var font: Font = .title2
    var width: CGFloat?
    var height: CGFloat? = 50
    let title: String
    
    let handler: () -> Void
    
    var body: some View {
        ZStack {
            switch style {
            case .text:
                textButtonView
            case .rounded:
                roundedButtonView
            }
        }
    }
    
    var textButtonView: some View {
        Button {
            handler()
        } label: {
            Text(title)
                .font(font)
                .foregroundStyle(Color.primaryBlue)
        }
    }
    
    var roundedButtonView: some View {
        Button {
            handler()
        } label: {
            ZStack {
                Capsule().fill(Color.primaryBlue)
                Text(title)
                    .font(font)
                    .foregroundStyle(Color.surfaceBackground)
            }
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    CustomButton(title: "Hi there") {
        print("Tapped")
    }
}
