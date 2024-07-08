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
                    CustomPostRowView(postText: vm.postText, isDetailView: false,  postToGovernmentName: "Daxili İşlər Nazirliyi", userName: "Valeh Amirov", postStatus: "Gözləmədə", isLiked: $isLiked) {}
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
