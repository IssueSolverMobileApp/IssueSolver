//
//  QueryCommentBottomSheetView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI


struct QueryCommentBottomSheetView: View {
    
    @State var commentText: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                CustomCommentRowView()
            }
//            Spacer()
            addCommentView
        }
    }
    
    var addCommentView: some View {
        LazyVStack(alignment: .center) {
            customBlueDivider
            
            HStack() {
                VStack {
                    TextEditor(text: $commentText)
                        .textEditorBackground(.outLineContainerBlue)
                        .padding(.horizontal)
                        .jakartaFont(.heading)
                        .frame(minHeight: 30)
                        .frame(maxHeight: 100)
                        .padding(.vertical, 6)
                }
                .background(Color.outLineContainerBlue)
                .clipShape(.rect(cornerRadius: 24))
                Image(.sendCommentIcon)
            }
            .padding(.horizontal, 7)
            .frame(minHeight: 48)
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

/// this extension for TextEditor background color
extension View {
    func textEditorBackground(_ content: Color) -> some View {
        if #available(iOS 16.0, *) {
            return self.scrollContentBackground(.hidden)
                .background(content)
        } else {
            UITextView.appearance().backgroundColor = .clear
            return self.tint(content)
        }
    }
}
