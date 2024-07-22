//
//  HomeView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 22.07.24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var router: Router
    @StateObject private var vm = HomeViewModel()
    @State private var isLiked: Bool = false
    @State private var isPresented: Bool = false

    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
                if vm.queryData.isEmpty && !vm.isDataEmptyButSuccess {
                    placeholderView
                } else if vm.isDataEmptyButSuccess {
                    notDataView
                } else {
                    mainView
                }
        }
        .onAppear {
            vm.getMoreQuery()
        }
    }
    
    var mainView: some View {
        ScrollView {
            
            LazyVStack {
                CustomTitleView(title: "• Issue Solver")
                
                ForEach($vm.queryData, id: \.requestID) { $item in
                    CustomPostRowView(queryItem: $item, isDetailView: false) {
                        // MARK: Comment handler
                        isPresented.toggle()
                    } likeHandler: { like in
                        // MARK: Like handler
                        vm.likeToggle(like: like, queryID: item.requestID)
                    }
                    .onTapGesture {
                        router.navigate { QueryDetailView( queryItem: $item) }
                    }
                    .fullScreenCover(isPresented: $isPresented, content: {
                        QueryCommentBottomSheetView()
                    })
                }
                    
                HStack {
                    ProgressView()
                }
                .onAppear {
                    vm.getMoreQuery()
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        
    }
    
    var placeholderView: some View {
        ScrollView {
            
            VStack {
                CustomTitleView(title: "• Issue Solver")
                
                ForEach(1...3, id: \.self) {_ in
                    CustomPostRowView(queryItem: $vm.placeholderData, isDetailView: false) {
                        
                    } likeHandler: { _ in
                        
                    }
                    .redacted(reason: .placeholder)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    }
    
    var notDataView: some View {
        VStack {
            CustomTitleView(title: "• Issue Solver")
            Spacer()
            Text("Sistemdə sorğu mövcud deyil.")
                .jakartaFont(.heading)
            Spacer()
            EmptyView()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
}

#Preview {
    HomeView()
}
