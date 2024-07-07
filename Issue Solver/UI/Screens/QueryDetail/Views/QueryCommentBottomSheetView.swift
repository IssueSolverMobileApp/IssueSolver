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
                VStack {
                    VStack(alignment:.leading ,spacing: 12) {
                        HStack {
                            Image(.profile)
                            Text("Valeh Amirov")
                                .jakartaFont(.custom(.semiBold, 15))
                                .foregroundStyle(.primaryBlue)
                            Spacer()
                            Text("07.01.2012")
                                .jakartaFont(.custom(.regular, 14))
                                .foregroundStyle(.secondaryGray)
                        }
                        
                        Text("Office ipsum you must be muted. This food playing ping every must. Need wanted best thought ditching leverage circle fruit eod. Activities me seems investigation guys. By sop is closing old pups.")
                            .jakartaFont(.heading)
                            .lineSpacing(12)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                    customDividerOpacity
                }
            }
            sendCommentView
        }
    }
    
    var sendCommentView: some View {
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
    
    var customDividerOpacity: some View {
        Divider().overlay {
            Color.primaryBluePressed.opacity(0.28)
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
