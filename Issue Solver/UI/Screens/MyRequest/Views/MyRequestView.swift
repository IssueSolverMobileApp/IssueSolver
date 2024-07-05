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
            Color.surfaceBackground.ignoresSafeArea()
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
        VStack {
            HStack {
                Image(.profileIcon)
                Text("Aynur Qəmbərova")
                    .jakartaFont(.subtitle)
                    .foregroundStyle(.primaryBlue)
                Spacer()
                HStack {
                    Image(.blueDotIcon)
                    Text("Gözləmədə")
                        .jakartaFont(.subheading)
                        .foregroundStyle(Color.primaryBluePressed)
                }
                .padding([.leading, .trailing], 20)
                .padding([.top, .bottom], 8)
                .background(.primaryBlue.opacity(0.28))
                .clipShape(.rect(cornerRadius: 100))
            }
            
            Text(vm.postText)

        }
    }
}

#Preview {
    MyRequestView()
}
