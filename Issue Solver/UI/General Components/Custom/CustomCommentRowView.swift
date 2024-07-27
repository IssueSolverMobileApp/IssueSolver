//
//  CustomCommentRowView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct CustomCommentRowView: View {
    
    @State var item: QueryCommentDataModel?
    
    var body: some View {
        VStack {
            VStack(alignment:.leading ,spacing: 12) {
                HStack {
                    Image(item?.authority == "STAFF" ? .governmentIcon : .profile)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text(item?.fullName ?? "")
                        .jakartaFont(.custom(.semiBold, 15))
                        .foregroundStyle(.primaryBlue)
                    Spacer()
                    Text(item?.createDate ?? "")
                        .jakartaFont(.custom(.regular, 12))
                        .foregroundStyle(.secondaryGray)
                }
                
                Text(item?.commentText ?? "")
                    .jakartaFont(.heading)
                    .lineSpacing(12)
            }
            .padding(.horizontal, 20)
            customDivider
        }
        .opacity((item?.commentIsSuccess ?? true) ? 1 : 0.5)
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
