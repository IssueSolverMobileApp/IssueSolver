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
    var dividerSize: CGFloat? = 0.4
    var image: ImageResource?
    
    var color: Color? 
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack() {
                Text(title)
                    .jakartaFont(.title)
                    .foregroundStyle(color ?? .black)
                Spacer()
                Image(image ?? ImageResource(name: "", bundle: Bundle()))
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
