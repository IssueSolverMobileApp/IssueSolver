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
    case back
}

struct CustomButton: View {
    var style: CustomButtonStyle = .rounded
    var font: JakartaFonts = .heading
    var width: CGFloat?
    var height: CGFloat? = 50
    let title: String
    var color: Color = .primaryBlue
    var isLoading: Bool = false
    
    let handler: () -> Void
    
    var body: some View {
        ZStack {
            switch style {
            case .text:
                textButtonView
            case .rounded:
                roundedButtonView
            case .back:
                backButtonView
            }
        }
    }
    
    var textButtonView: some View {
        Button {
            handler()
        } label: {
            Text(title)
                .jakartaFont(.textButton)
                .foregroundStyle(color)
        }
    }
    var roundedButtonView: some View {
        Button {
            handler()
        } label: {
            ZStack {
                Capsule().fill(color)
                HStack {
                    Text(title)
                        .jakartaFont(.roundedButton)
                        .foregroundStyle(Color.surfaceBackground)
                        .padding(.trailing)
                    
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .frame(width: width, height: height)
    }
    
    
    var backButtonView: some View {
        Button {
            handler()
        } label: {
            ZStack {
                Circle().fill(Color.white)
                 Image("backArrow")
            }
        }
        .frame(width: 40, height: 40)
    }
}
