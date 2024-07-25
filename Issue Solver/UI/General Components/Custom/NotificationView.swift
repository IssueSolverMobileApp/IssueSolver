//
//  NotificationView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 22.07.24.
//

import SwiftUI

enum NotificationType {
    case success(SuccessModel)
    case error(Error?)
}

struct NotificationView: View {
    
    let type: NotificationType
    let completion: () -> Void
    
    @State private var yOffset: CGFloat = -(UIScreen.main.bounds.height) // Start off-screen at the top
    @State private var timer: Timer?
    
    var body: some View {
        HStack {
            switch type {
            case .success(let success):
                contentView(image: .successIcon, text: success.message ?? "", color: .primaryGreen200, iconColor: .primaryGreen)
            case .error(let error):
                if let error {
                    contentView(image: .x, text: error.localizedDescription, color: .primaryRed200, iconColor: .primaryRed)
                }
            }
        }
        .offset(y: yOffset)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.5)) {
                yOffset = 0
            }
            
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                withAnimation {
                    yOffset = UIScreen.main.bounds.height
                    completion()
                }
            }
        }
    }
    
    func contentView(image: ImageResource, text: String, color: Color, iconColor: Color) -> some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(iconColor)
                .tint(iconColor)
            
            Text(text)
                .foregroundStyle(iconColor)
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 6)
                .fill(color)
        }
    }
}

