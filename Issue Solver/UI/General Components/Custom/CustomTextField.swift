//
//  CustomTextField.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 11.06.24.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String?
    var title: String?
    var isSecure: Bool = false
    var textColor: Color?
    var color: Color?
    
    @Binding var text: String
    @Binding var errorMessage: String?
    @State var isShowPassword: Bool = false
    
    init(placeholder: String? = nil, title: String? = nil, isSecure: Bool = false, textColor: Color? = nil, color: Color? = nil, text: Binding<String>, isShowPassword: Bool = false, errorMessage: Binding<String?> = .constant(nil)) {
        self.placeholder = placeholder
        self.title = title
        self.isSecure = isSecure
        self.textColor = textColor
        self.color = color
        self._text = text
        self.isShowPassword = isShowPassword
        self._errorMessage = errorMessage
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            titleView
            textFieldView
        }
    }
    
    /// - Title view of the custom textfield
    var titleView: some View {
        ZStack {
            if let title {
                Text(title)
                    .jakartaFont(.heading)
                    .foregroundStyle(textColor ?? .black)
            }
        }
    }
    
    /// - Custom text field view
    var textFieldView: some View {
        VStack(alignment: .leading) {
        ZStack {
            if !isSecure {
                TextField(placeholder ?? "", text: $text)
            } else {
                HStack {
                    if isShowPassword {
                        TextField(placeholder ?? "", text: $text)
                    } else {
                        SecureField(placeholder ?? "", text: $text)
                    }
                    HStack {
                        showPasswordButtonView
                    }
                }
            }
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius).stroke((errorMessage == nil) ? Color.clear : Color.red, lineWidth: 1))
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(color ?? .white)
        }
         if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .jakartaFont(.subtitle2)
                    }
                }
        
        .jakartaFont(.heading)
    }
    
    /// - Show/hide password
    var showPasswordButtonView: some View {
        Button {
            isShowPassword.toggle()
        } label: {
            Image(isShowPassword ? "eye" : "closeeye")
                .foregroundStyle(Color.primaryBlue)
                .background(.white)
        }
       

    }
    
}

