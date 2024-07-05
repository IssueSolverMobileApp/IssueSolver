//
//  MyRequestView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 05.07.24.
//

import SwiftUI

struct MyRequestView: View {
    
    @StateObject var vm = MyRequestViewModel()
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            ScrollView  {
                VStack {
                    titleView
                    postView
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
        }
    }
    
    var titleView: some View {
        CustomTitleView(title: "Mənim sorğularım")
    }
    
    var postView: some View {
        
        VStack(spacing: 10) {
            HStack {
                Image(.profile)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .scaledToFit()
                Text("Aynur Qəmbərova")
                    .jakartaFont(.subtitle)
                    .foregroundStyle(.primaryBlue)
                Spacer()
                HStack {
                    Image(.blueDotIcon)
                        .foregroundStyle(.primaryBluePressed)
                    Text("Gözləmədə")
                        .jakartaFont(.subheading)
                        .foregroundStyle(Color.primaryBluePressed)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(.outLineContainerBlue)
                .clipShape(.rect(cornerRadius: 100))
            }
            
            Divider().overlay {
                Color.primaryBlueOutLine.opacity(0.28)
            }
            
            
            if vm.postText.count >= 120 {
                Text(vm.postText.prefix(120))
                + Text("...daha çox göstər").foregroundColor(.blue)
//                    .jakartaFont(.heading)
            } else {
                Text(vm.postText)
                    .jakartaFont(.heading)
            }
            
            Divider().overlay {
                Color.primaryBlueOutLine.opacity(0.28)
            }
            HStack {
                Image(.likeIcon)
                    .padding(.trailing, 24)
                Image(.commentIcon)
                Spacer()
                Image(.optionDotsIcon)
                    .padding(.trailing)
            }
        }
        .padding(16)
        .background(.white)
        .clipShape(.rect(cornerRadius: Constants.cornerRadius))
    }
}

#Preview {
    MyRequestView()
}
