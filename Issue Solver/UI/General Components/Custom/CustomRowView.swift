//
//  CustomRowView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import SwiftUI

struct CustomRowView: View {
    
    let title: String
    let subtitle: String?
    let leftImage: String?
    let rightImage: String?
    
    var width: CGFloat?
    var height: CGFloat?
    var color: Color = .black
    let handler: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color(.white))
            
            HStack (spacing: 12) {
                leftImageView
                titleSubtitleView
                Spacer()
                rightButtonView
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
        }
        .frame(height: height)
    }
    
    
    /// Left Image View
    var leftImageView: some View {
        ZStack {
            if let leftImage {
                Image(leftImage)
                    .frame(width: width, height: height)
            }
        }
    }
    
    ///  Title Subtitle View
    var titleSubtitleView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .jakartaFont(.rowTitle)
                .foregroundStyle(color)
            if let subtitle {
                Text(subtitle)
                    .jakartaFont(.subtitle)
                    .foregroundStyle(.secondaryGray)
            }
        }
    }
    
    /// Right Button View
    var rightButtonView: some View {
        Group {
            if let rightImage = rightImage {
                Button(action: handler) {
                    Image(rightImage)
                        .frame(width: width, height: height)
                }
            }
        }
    }
}

#Preview {
    CustomRowView(title: "salam", subtitle: "salam", leftImage: "eye", rightImage: "eye", handler: {})
}

