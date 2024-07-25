//
//  QueryDetailView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct QueryDetailView: View {

    @EnvironmentObject var router: Router
    @StateObject private var vm = QueryDetailViewModel()

    @State private var isLike: Bool = false
    @State private var isPresented: Bool = false
    var ifNeedDeleteButton: Bool

    @Binding var queryItem: QueryDataModel
    
    @Environment(\.dismiss) var dissmiss
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            ScrollView {
                VStack {
                    CustomPostRowView(queryItem: $vm.item, isDetailView: true, ifNeedDeleteButton: ifNeedDeleteButton) {
                        isPresented.toggle()
                    } likeHandler: {_ in 
                        vm.likeToggle()
                    } deleteQuery: {
                        vm.isDeletePressed = true
                    }
                    .sheet(isPresented: $isPresented, content: {
                        QueryCommentView(id: "\(vm.item.requestID ?? Int())")
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
                                            dissmiss()
                                        }
                                        vm.isViewLoading = false
                                    })
                                    vm.isDeletePressed = false
                                    vm.isViewLoading = true
                                })
                            )
                        }
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            .navigationBarBackButtonHidden(true)
            
            LoadingView(isLoading: vm.isViewLoading)
        }
        .onAppear {
            vm.getSingleQuery(id: "\(queryItem.requestID ?? Int())")
        }
        .onChange(of: vm.item, perform: { value in
            queryItem = value
        })
        .onChange(of: isPresented, perform: { value in
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
    
    var backButtonView: some View {
        CustomButton(style: .back, title: "") {
            router.dismissView()
        }
    }
}

#Preview {
    QueryDetailView(ifNeedDeleteButton: false, queryItem: .constant(QueryDataModel()))
}
