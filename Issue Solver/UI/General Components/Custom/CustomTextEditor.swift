//
//  CustomTextEditor.swift
//  Issue Solver
//
//  Created by ValehAmirov on 03.07.24.
//

import SwiftUI

struct CustomTextEditor: View {
    
    var title: String?
    var textColor: Color?
    var errorText: String?
    
    @Binding var explanation: String

    @FocusState private var isTextEditorFocused: Bool
    @Binding var isRightTextField: Bool

    
    
    var body: some View {
        VStack {
            HStack {
                if let title {
                    Text(title)
                        .jakartaFont(.heading)
                        .foregroundStyle(isRightTextField ? (textColor ?? .black) :  .red)
                }
                Spacer()
            }
            
            ZStack {
                ZStack {
                    TextEditor(text: $explanation)
                        .jakartaFont(.subtitle2)
                        .focused($isTextEditorFocused)
                        .frame(height: 140)
                        .padding(.leading, -3)
                    
                    VStack {
                        HStack {
                            Text(explanation == "" ? "Problem haqqında ətraflı məlumat daxil edin" : "" )
                                .jakartaFont(.subtitle2)
                                .foregroundStyle(explanation == "" ? Color.gray : Color.black)
                                .onTapGesture {
                                    isTextEditorFocused.toggle()
                                }
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.top, 8)
                }
                .padding([.leading, .trailing], 8)
                .padding(3)
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke((isRightTextField) ? Color.clear : Color.red, lineWidth: 1))
            
            if let errorText {
                HStack {
                    Text(errorText)
                        .jakartaFont(.subtitle2)
                        .foregroundStyle(isRightTextField ? .gray : .red)
                    Spacer()
                }
            }
        }
    }
}
