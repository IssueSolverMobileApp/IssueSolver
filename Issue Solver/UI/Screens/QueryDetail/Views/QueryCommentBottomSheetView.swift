//
//  QueryCommentBottomSheetView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI


struct QueryCommentBottomSheetView: View {
    
    @State private var commentText: String = ""
    
    var body: some View {
            
        ZStack {
            VStack {
                
                ScrollView {
                    CustomCommentRowView()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                
            }
            .navigationTitle("Rəylər")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        VStack {
            Spacer()
            addCommentView
        }
        .adaptsToKeyboard()
        .ignoresSafeArea()
    }
    
    var addCommentView: some View {
        LazyVStack {
            customBlueDivider
            
            HStack() {
                VStack {
                    TextEditor(text: $commentText)
                        .textEditorBackground(.outLineContainerBlue)
                        .padding(.horizontal)
                        .jakartaFont(.heading)
                        .frame(minHeight: 30)
                        .frame(maxHeight: 100)
                        .padding(.top, 6)
                        
                }
                .background(Color.outLineContainerBlue)
                .clipShape(.rect(cornerRadius: 24))
                .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.primaryBlue.opacity(0.29)))
                Image(.sendCommentIcon)
            }
            .padding(.horizontal, 20)
            .frame(minHeight: 48)
            .frame(maxHeight: 150)

        }

        .frame(maxHeight: 124)
        .frame(minHeight: 74)
    }
        
    
    var customBlueDivider: some View {
        Divider().overlay {
            Color.primaryBluePressed
        }
    }
}

#Preview {
    QueryCommentBottomSheetView()
}
