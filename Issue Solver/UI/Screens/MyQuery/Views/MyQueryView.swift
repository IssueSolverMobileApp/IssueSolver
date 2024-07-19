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
                    
                    Color.black.frame(height: 50)
                        .onAppear {
                            vm.getMyQuery()
                        }
                }
                

                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
        }
        .onAppear {
            vm.getMyQuery()
        }
    }
}

#Preview {
    MyQueryView()
}
