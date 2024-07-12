//
//  CustomTitleView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 12.06.24.
//

import SwiftUI

struct CustomTitleView: View {
    let title: String
    var subtitle: String?
    var dividerSize: CGFloat?
    var image1: ImageResource?
    var image2: ImageResource?
    var color: Color?
    
    let titleButtonHandler: (() -> Void)?
    
    init(title: String, subtitle: String? = nil, dividerSize: CGFloat? = 0.4, image1: ImageResource? = nil, image2: ImageResource? = nil, color: Color? = nil, titleButtonHandler: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.dividerSize = dividerSize
        self.image1 = image1
        self.image2 = image2
        self.color = color
        self.titleButtonHandler = titleButtonHandler
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack() {
                Text(title)
                    .jakartaFont(.title)
                    .foregroundStyle(color ?? .primaryBlue)
                Spacer()
                if let image1, let titleButtonHandler {

                    Button(action: {
                        titleButtonHandler()
                    }, label: {
                        Image(image1)
                    })
                }
                
                if let image2, let titleButtonHandler {

                    Button(action: {
                        titleButtonHandler()
                    }, label: {
                        Image(image2)
                    })
                }
            }
            
            if let subtitle {
                Text(subtitle)
                    .jakartaFont(.subtitle)
                    .foregroundStyle(.secondaryGray)
            }
            customDivider
        }
        .padding(.bottom, 16)
        .multilineTextAlignment(.leading)
      
    }
    
    var customDivider: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Color.primaryBlue)
            .frame(height: dividerSize)
            .padding(.top, 8)
    }
}

#Preview {
    CustomTitleView(title: "Daxil olun", subtitle: "Djnvpwo;v ntoinfvnq23")
}
