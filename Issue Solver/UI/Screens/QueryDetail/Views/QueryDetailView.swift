//
//  QueryDetailView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct QueryDetailView: View {

    @EnvironmentObject var router: Router

    @State var queryItem: QueryDataModel = QueryDataModel()
    @State var isLike: Bool = false
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            ScrollView {
                VStack {
                    CustomPostRowView(queryItem: $queryItem, isDetailView: true) {
                        isPresented.toggle()
                    } likeHandler: {_ in 
                        
                    }
                    .fullScreenCover(isPresented: $isPresented, content: {
                        QueryCommentBottomSheetView()
                    })
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            .navigationBarBackButtonHidden(true)
        }
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
    QueryDetailView()
}
