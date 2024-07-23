//
//  QueryCommentBottomSheetView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct QueryCommentView: View {
    @StateObject private var vm = QeuryCommentViewModel()
    
    @State var txt: String = ""
    @State var height: CGFloat = 20
    
    @Binding var id: Int?
    
    var body: some View {
        VStack {
            titleView
            cardView
            resizableTextVeiw
        }
        .background(ignoresSafeAreaEdges: .bottom)
        .onAppear {
            vm.getQueryComments(requestID: "\(id ?? Int())")
            print(id ?? "bosdur --------------")
        }
    }
    //    titleVeiw
    var titleView: some View {
        VStack {
            Capsule()
                .fill(Color.secondary)
                .frame(width: 30, height: 3)
                .padding(10)
            HStack {
                Text("Rəylər")
                    .jakartaFont(.rowTitle)
            }
        }
    }
    //    cardView
    var cardView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(vm.commentData, id: \.commentID) { item in
                    CustomCommentRowView(item: item)
                }
                
                HStack {
                    ProgressView()
                }
                .onAppear {
                    vm.getMoreQuery(requestID: "\(id ?? Int())")
                }
            }
        }
    }
    //    resizableTextView
    var resizableTextVeiw: some View {
        HStack(spacing: 8) {
            ZStack {
                ResizableTextView(txt: $txt, height: $height)
                    .frame(height: abs(height < 124 ? height : 124))
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(.outLineContainerBlue)
                    .clipShape(.rect(cornerRadius: 24))
                    .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.primaryBlue.opacity(0.29)))
            }
            .padding(.leading)
            Button {
                
            } label: {
                Image(.sendCommentIcon)
                    .frame(width: 40, height: 40)
            }
            .background(.white)
            .clipShape(Circle())
        }
        .padding(.trailing,20)
        .padding(.bottom, 5)
    }
}
  
#Preview {
    QueryCommentView(id: .constant(0))
}
