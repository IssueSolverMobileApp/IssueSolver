//
//  QueryCommentBottomSheetView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct QueryCommentView: View {
    @StateObject private var vm = QeuryCommentViewModel()
    var id: String
    
    var body: some View {
        VStack {
            titleView
            if vm.commentData.isEmpty && !vm.isDataEmptyButSuccess  {
                placeholderView
            } else if vm.isDataEmptyButSuccess {
                notDataView
            } else {
                cardView
            }
            resizableTextVeiw
        }
        .background(ignoresSafeAreaEdges: .bottom)
        .onAppear {
            vm.getQueryComments(requestID: id)
        }
        .refreshable {
            vm.getQueryComments(requestID: id)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
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
    
    var cardView: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(vm.commentData, id: \.commentID) { item in
                    CustomCommentRowView(item: item)
                }
                
                if vm.isProgressViewSeen {
                    HStack {
                        ProgressView()
                    }
                    .onAppear {
                        vm.getMoreQuery(requestID: id)
                    }
                }
            }
        }
    }

    var resizableTextVeiw: some View {
        HStack(spacing: 8) {
            ZStack {
                ResizableTextView(text: $vm.text, height: $vm.height, placeholder: "Rəyinizi yazın")
                    .frame(height: abs(vm.height < 124 ? vm.height : 124))
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(.outLineContainerBlue.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 24))
                    .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.primaryBlue.opacity(0.29)))
            }
            .padding(.leading)
            Button {
                vm.addLocalComment(requestID: self.id, text: self.vm.text)
                self.vm.text = ""
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
    
    var placeholderView: some View {
        ScrollView {
            ForEach(1...3, id: \.self) { _ in
                CustomCommentRowView(item: vm.placeholderData)
                    .redacted(reason: .placeholder)
            }
        }
    }
    var notDataView: some View {
        VStack {
            Spacer()
            Text("Rəy yoxdur")
            Spacer()
        }
     }
 }
  
#Preview {
    QueryCommentView(id: "")
}
