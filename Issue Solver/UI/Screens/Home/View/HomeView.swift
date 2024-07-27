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
    private let ifNeedDeleteButton: Bool = false

    var body: some View {
        ZStack {
            Color.surfaceBackground
                      .ignoresSafeArea()
            if vm.queryData.isEmpty {
                notDataView
            } else {
                mainView
            }
        }
        .onAppear {
            if vm.queryData.isEmpty {
                vm.getMoreQuery()
            }
        }
    }
        
    var mainView: some View {
        ScrollView {
            LazyVStack {
                CustomTitleView(title: "• Issue Solver", image1: .filterIcon) {
                    router.navigate {
                        FilterView().environmentObject(vm)
                    }
                }
                
                ForEach($vm.queryData) { $item in
                    CustomPostRowView(queryItem: item, isDetailView: false, ifNeedDeleteButton: ifNeedDeleteButton) {
                        // MARK: Comment handler
                        vm.isPresentedToggle(queryID: "\(item.requestID ?? Int())")
                    } likeHandler: { like in
                        // MARK: Like handler
                        vm.likeToggle(like: like, queryID: item.requestID)
                    } deleteQuery: {
                        
                    }
                    .onTapGesture {
                        router.navigate { QueryDetailView( ifNeedDeleteButton: ifNeedDeleteButton, queryItem: $item) }
                    }
                    .sheet(isPresented: $vm.isPresented, content: {
                        QueryCommentView(id: vm.queryID)
                    })
                    .redacted(reason: vm.isLoading ? .placeholder:[])
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
    
    var notDataView: some View {
        VStack {
            CustomTitleView(title: "• Issue Solver", image1: .filterIcon) {
                router.navigate {
                    FilterView().environmentObject(vm)
                }
            }
            Spacer()
            Text("Heç bir sorğu tapılmadı")
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
