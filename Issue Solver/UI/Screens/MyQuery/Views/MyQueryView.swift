//
//  MyRequestView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 05.07.24.
//

import SwiftUI

struct MyQueryView: View {
    
    @StateObject var vm = MyQueryViewModel()
    @State var isLiked: Bool = false
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            ScrollView {
                if vm.queryData.isEmpty {
                    placeholderView
                } else {
                    mainView
                }
            }
        }
        .onAppear {
            if !vm.isLoading {
                vm.getMyQuery()
            }
        }
    }
    
    var mainView: some View {
        
        LazyVStack {
            CustomTitleView(title: "Mənim sorğularım")
            
            ForEach($vm.queryData, id: \.requestID) { $item in
                CustomPostRowView(queryItem: $item, isDetailView: false) {
                    //                            MARK: Comment handler
                } likeHandler: { like in
                    //                            MARK: Like handler
                    vm.likeToggle(like: like, queryID: item.requestID)
                }
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
    
    var placeholderView: some View {
        VStack {
            CustomTitleView(title: "Mənim sorğularım")

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


#Preview {
    MyQueryView()
}
