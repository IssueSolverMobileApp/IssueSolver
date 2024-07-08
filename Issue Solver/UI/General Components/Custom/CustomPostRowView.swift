//
//  CustomPostRowView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct CustomPostRowView: View {
    
    var postText: String
    /// if we need to use PostView into some detailView isDetailView variable must be true else false
    var isDetailView: Bool = true
    var likeCount: String?
    var commentCount: String?
    var postToGovernmentName: String
    var userName: String
    var postStatus: String
    
    let commentHandler: () -> Void
    
    @Binding var isLiked: Bool
    
    init(postText: String, isDetailView: Bool, likeCount: String? = nil, commentCount: String? = nil, postToGovernmentName: String, userName: String, postStatus: String, isLiked: Binding<Bool>, commentHandler: @escaping () -> Void) {
        self.postText = postText
        self.isDetailView = isDetailView
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.postToGovernmentName = postToGovernmentName
        self.userName = userName
        self.postStatus = postStatus
        self._isLiked = isLiked
        self.commentHandler = commentHandler
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 16) {
            
            topView
            customDivider
            centerView
            customDivider
            bottomView
        }
        .padding(16)
        .background(.white)
        .clipShape(.rect(cornerRadius: Constants.cornerRadius))
    }
    
    var topView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(.profile)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .scaledToFit()
                Text(userName)
                    .jakartaFont(.subtitle)
                    .foregroundStyle(.primaryBlue)
                    .lineLimit(2)
                Spacer()
                HStack {
                    Image(.blueDotIcon)
                        .foregroundStyle(.primaryBluePressed)
                    Text(postStatus)
                        .jakartaFont(.subheading)
                        .foregroundStyle(Color.primaryBluePressed)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(.outLineContainerBlue)
                .clipShape(.rect(cornerRadius: 100))
            }
            
            if isDetailView {
                    Text(postToGovernmentName)
                .jakartaFont(.subheading)
            }
        }
    }
    
    var centerView: some View {
        VStack(alignment: .leading,spacing: 16) {
            
            ZStack {
                Text("Küçə heyvanlarına qarşı zorbalıq")
                    .jakartaFont(.subtitle2)
                    .foregroundStyle(.disabledGray)
            }
            .padding(.horizontal,10)
            .padding(.vertical, 8)
            .background(Color.surfaceBackground)
            .clipShape(.rect(cornerRadius: 100))
            
//            text of Post
            if postText.count >= 120 && !isDetailView {
                ZStack {
                    Text(postText.prefix(120))
                    + Text("...daha çox göstər").foregroundColor(.blue)
                }
                .lineSpacing(9)
                .foregroundStyle(.primaryGray)
                .jakartaFont(.subheading)
                
            } else {
                Text(postText)
                    .lineSpacing(9)
                    .foregroundStyle(.primaryGray)
                    .jakartaFont(.subheading)
                
//                Location and Date
                HStack {
                    Image(.locationIcon)
                    Text("Lorem ipsum dolor sit amet, consectetur efficitur.")
                        .jakartaFont(.subtitle2)
                        .foregroundStyle(.primaryBlue)
                    Spacer()
                    Image(.calendarIcon)
                    Text("01.08.2024, 14:30")
                }
                .jakartaFont(.subtitle2)
            }
        }
    }
    
    var customDivider: some View {
        Divider().overlay {
            Color.primaryBluePressed.opacity(0.28)
        }
    }
    //            Like, comment and option button
    var bottomView: some View {
        HStack {
            VStack(spacing: 5) {
                Toggle("", isOn: $isLiked)
                    .toggleStyle(CustomToggleLikeStyle())
                if isDetailView {
                    Text(likeCount ?? "0")
                        .jakartaFont(.custom(.medium, 10))
                }
            }
            .padding(.trailing, 24)
            VStack {
                Button(action: {
                    commentHandler()
                }, label: {
                    Image(.commentIcon)
                })
                if isDetailView {
                    Text(commentCount ?? "0")
                        .jakartaFont(.custom(.medium, 10))
                }
            }
            Spacer()
            Image(.optionDotsIcon)
                .padding(.trailing)
        }
    }
}
