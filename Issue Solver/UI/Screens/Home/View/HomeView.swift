//
//  HomeView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 12.07.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = MyQueryViewModel()
    @State var isLiked: Bool = false
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            ScrollView  {
                VStack {
                    titleView
                    ForEach(vm.queryData, id: \.requestID) { item in
                        CustomPostRowView(postText: item.description ?? "", isDetailView: false,  postToGovernmentName: item.organizationName ?? "", userName: item.fullName ?? "", postStatus: item.status ?? "", isLiked: $isLiked, categoryName: item.category ?? "") {}
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
        }
    }
    
    var titleView: some View {
        HStack(spacing: 12) {
            CustomTitleView(title: "Issue Solver", image1: .searchIcon, image2: .notificationIcon) {
//          MARK: - navigation action must be here
            }
        }
    }
}


#Preview {
    HomeView()
}
