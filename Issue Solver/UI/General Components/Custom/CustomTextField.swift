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
    @State var isShowPassword: Bool = false
    
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
        Group {
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
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(color ?? .white)
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

#Preview {
    CustomTextField(placeholder: "Enter your password", title: "Password", isSecure: true, text: .constant(""))
}
