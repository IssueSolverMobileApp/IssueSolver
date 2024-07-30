//
//  QueryDetailView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct QueryDetailView: View {
    @EnvironmentObject var router: Router
    @Environment(\.dismiss) var dissmiss
    @StateObject private var vm = QueryDetailViewModel()
    @Binding var queryItem: QueryDataModel
    var ifNeedDeleteButton: Bool
    let isDeleteDetailView: (() -> Void)?
    
    init(ifNeedDeleteButton: Bool, queryItem: Binding<QueryDataModel>, isDeleteDetailView: (() -> Void)? = nil ) {
        self.ifNeedDeleteButton = ifNeedDeleteButton
        self._queryItem = queryItem
        self.isDeleteDetailView = isDeleteDetailView
    }
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
                    if vm.isLoading {
                        placeholderView
                    } else {
                        mainView
                    }
            LoadingView(isLoading: vm.isViewLoadingForDelete)
        }
        .navigationBarBackButtonHidden(true)
        
    .onAppear {
        vm.getSingleQuery(id: "\(queryItem.requestID ?? Int())")
    }
    .onChange(of: vm.item ?? QueryDataModel(), perform: { value in
        queryItem = value
    })
    .onChange(of: vm.isPresented, perform: { value in
        if !value {
            vm.getSingleQuery(id: "\(queryItem.requestID ?? Int())")
        }
    })
    .toolbar {
        ToolbarItem(placement: .topBarLeading) {
            backButtonView
        }
      }
    }
    
    var mainView: some View {
            ScrollView {
                VStack {
                    if let item = vm.item {
                        CustomPostRowView(queryItem: item, isDetailView: true, ifNeedDeleteButton: ifNeedDeleteButton) {
                            vm.isPresented.toggle()
                        } likeHandler: {_ in
                            vm.likeToggle()
                        } deleteQuery: {
                            vm.isDeletePressed = true
                        }
                        .sheet(isPresented: $vm.isPresented, content: {
                            QueryCommentView(id: "\(item.requestID ?? Int())")
                        })
                        .alert(
                            isPresented: $vm.isDeletePressed,
                            content: {
                                Alert(
                                    title: Text("Sorğunuzu silmək istədiyinizə əminsiniz?"),
                                    primaryButton: .default(Text("Ləğv et"), action: {
                                        vm.isDeletePressed = false
                                    }),
                                    secondaryButton: .destructive(Text("Bəli"),action: {
                                        vm.deleteQuery(id: "\(queryItem.requestID ?? Int())", completion: { success in
                                            if success {
                                                dissMiss()
                                            }
                                            vm.isViewLoadingForDelete = false
                                        })
                                        vm.isDeletePressed = false
                                        vm.isViewLoadingForDelete = true
                                    })
                                )
                            }
                        )
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                    }
                }
            }
        }
    
    var placeholderView: some View {
        ScrollView {
            VStack {
                    CustomPostRowView(queryItem: vm.placeholderItem, isDetailView: false, ifNeedDeleteButton: ifNeedDeleteButton) {
                        
                    } likeHandler: { _ in
                        
                    } deleteQuery: {
                        
                    }
                    .redacted(reason: .placeholder)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var backButtonView: some View {
        CustomButton(style: .back, title: "") {
            router.dismissView()
        }
    }
    func dissMiss() {
        (self.isDeleteDetailView!)()
        dissmiss()
    }
}

#Preview {
    QueryDetailView(ifNeedDeleteButton: false, queryItem: .constant(QueryDataModel()))
}
