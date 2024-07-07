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
            addCommentView
        }
    }
    
    var addCommentView: some View {
        ScrollView {
            customBlueDivider
            VStack(alignment: .center) {
                Spacer()
                
                HStack(spacing: 3) {
                    ScrollView {
                        TextEditor(text: $commentText)
                            .textEditorBackground(.outLineContainerBlue)
                            .frame(minHeight: 34)
                    }
                    .padding(10)
                    .background(Color.outLineContainerBlue)
                    .clipShape(.rect(cornerRadius: 100))
                    Image(.sendCommentIcon)
                }
                .padding(.horizontal, 8)
                .frame(minHeight: 48)
            }
            
        }
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
