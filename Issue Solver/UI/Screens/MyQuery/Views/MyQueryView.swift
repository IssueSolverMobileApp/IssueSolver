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
            ScrollView  {
                VStack {
                    CustomTitleView(title: "Mənim sorğularım")
                    ForEach(vm.queryData, id: \.requestID) { item in
                        
//                        CustomPostRowView(postText: item.description ?? "", isDetailView: false,  postToGovernmentName: item.organizationName ?? "", userName: "Valeh Amirov", postStatus: "Gözləmədə", isLiked: $isLiked) {}
//                        CustomPostRowView(postText: item.description ?? "", isDetailView: false, postToGovernmentName: item.organizationName ?? "", userName: item.fullName ?? "" , postStatus: item.status ?? "", isLiked: item.like , categoryName: item.category?.categoryName) {}
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            
        }
    }
}

#Preview {
    MyQueryView()
}
