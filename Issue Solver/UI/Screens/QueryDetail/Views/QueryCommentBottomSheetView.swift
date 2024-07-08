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
//            .ignoresSafeArea()
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


//MARK: -

import Combine

struct AdaptsToKeyboard: ViewModifier {
    @State var currentHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in content
                .padding(.bottom, self.currentHeight)
                .onAppear(perform: {
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                        .compactMap { notification in
                            withAnimation(.easeOut(duration: 0.16)) {
                                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                            }
                    }
                    .map { rect in
                        rect.height - geometry.safeAreaInsets.bottom
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                    
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
                        .compactMap { notification in
                            CGFloat.zero
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                })
        }
    }
}

extension View {
    func adaptsToKeyboard() -> some View {
        return modifier(AdaptsToKeyboard())
    }
}
