//
//  MyRequestView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 05.07.24.
//

import SwiftUI

struct MyQueryView: View {
    @EnvironmentObject var router: Router
    @StateObject private var vm = MyQueryViewModel()
   
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
            LoadingView(isLoading: vm.isViewLoading)
        }
        .onAppear {
           if vm.queryData.isEmpty {
                vm.getMoreQuery()
            }
        }
        .refreshable {
            vm.getMyQuery()
        }
    }
    
    var mainView: some View {
        ScrollView {
            LazyVStack {
                CustomTitleView(title: "Mənim sorğularım")
                ForEach($vm.queryData, id: \.requestID) { $item in
                    CustomPostRowView(queryItem: item, isDetailView: false, ifNeedDeleteButton: vm.ifNeedDeleteButton) {
                        // MARK: Comment handler
                        vm.isPresentedToggle(queryID: "\(item.requestID ?? Int())")
                    } likeHandler: { like in
                        // MARK: Like handler
                        vm.likeToggle(like: like, queryID: item.requestID)
                    } deleteQuery: {
                        vm.isDeletePressed(id: "\(item.requestID ?? Int())", true)
                    }
                    .onTapGesture {      
                        router.navigate {
                            QueryDetailView(ifNeedDeleteButton: vm.ifNeedDeleteButton, queryItem: $item, isDeleteDetailView: {
                                vm.getMyQuery()
                            })
                        }
                    }
                    .sheet(isPresented: $vm.isPresented, content: {
                        QueryCommentView(id: vm.queryID)
                    })
                    .alert(
                        isPresented: $vm.isDeletePressed,
                        content: {
                            Alert(
                                title: Text("Sorğunuzu silmək istədiyinizə əminsiniz?"),
                                primaryButton: .default(Text("Ləğv et"), action: {
                                    vm.isDeletePressed(id: nil, false)
                                }),
                                secondaryButton: .destructive(Text("Bəli"),action: {
                                    vm.deleteQuery()
                                    vm.isDeletePressed(id: nil, false)
                                })
                            )
                        }
                    )
                }
                if vm.isProgressViewSeen {
                    HStack {
                        ProgressView()
                            .onAppear {
                                vm.getMoreQuery()
                         }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }.animation(.spring(), value: vm.queryData)
    }
    
    var placeholderView: some View {
        ScrollView {
            VStack {
                CustomTitleView(title: "Mənim sorğularım")
                ForEach(1...3, id: \.self) {_ in
                    CustomPostRowView(queryItem: vm.placeholderData, isDetailView: false, ifNeedDeleteButton: vm.ifNeedDeleteButton) {
                        
                    } likeHandler: { _ in
                        
                    } deleteQuery: {
                        
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
            
            CustomTitleView(title: "Mənim sorğularım")
            Spacer()
            Text("Sorğunuz hələ ki yoxdur")
                .jakartaFont(.heading)
            Spacer()
            EmptyView()
        }
        .onAppear {
            vm.getMyQuery()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
    }
}

#Preview {
    MyQueryView()
}
