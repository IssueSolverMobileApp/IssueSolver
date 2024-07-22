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
    
    @Binding var queryItem: QueryDataModel
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            ScrollView {
                VStack {
                    CustomPostRowView(queryItem: $vm.item, isDetailView: true) {
                        isPresented.toggle()
                    } likeHandler: {_ in 
                        vm.likeToggle()
                    }
                    .fullScreenCover(isPresented: $isPresented, content: {
                        QueryCommentView()
                    })
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            vm.getSingleQuery(id: "\(queryItem.requestID ?? Int())")
        }
        
        .onChange(of: vm.item, perform: { value in
            queryItem = value
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
    QueryDetailView(queryItem: .constant(QueryDataModel()))
}
