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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.plusJakartaSansSemiBold(size: 28))
            if let subtitle {
                Text(subtitle)
                    .font(.plusJakartaSansRegular(size: 15))
                    .foregroundColor(.secondaryGray)
            }
            customDivider
        }
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
