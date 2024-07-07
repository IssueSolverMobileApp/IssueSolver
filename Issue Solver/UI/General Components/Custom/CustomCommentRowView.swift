//
//  CustomCommentRowView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct CustomCommentRowView: View {
    var body: some View {
        VStack {
            VStack(alignment:.leading ,spacing: 12) {
                HStack {
                    Image(.profile)
                    Text("Valeh Amirov")
                        .jakartaFont(.custom(.semiBold, 15))
                        .foregroundStyle(.primaryBlue)
                    Spacer()
                    Text("07.01.2012")
                        .jakartaFont(.custom(.regular, 14))
                        .foregroundStyle(.secondaryGray)
                }
                
                Text("Office ipsum you must be muted. This food playing ping every must. Need wanted best thought ditching leverage circle fruit eod. Activities me seems investigation guys. By sop is closing old pups.")
                    .jakartaFont(.heading)
                    .lineSpacing(12)
                
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            customDivider
        }
    }
    
    var customDivider: some View {
        Divider().overlay {
            Color.primaryBluePressed.opacity(0.28)
        }
    }
}

#Preview {
    CustomCommentRowView()
}
