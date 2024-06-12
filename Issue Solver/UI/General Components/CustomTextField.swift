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
    
    @Binding var text: String
    @State var isShowPassword: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            titleView
            textFieldView
        }
        .padding()
    }
    
    /// - Title view of the custom textfield
    var titleView: some View {
        ZStack {
            if let title {
                Text(title)
            }
        }
    }
    
    /// - Custom text field view
    var textFieldView: some View {
        Group {
            if !isSecure {
                TextField(placeholder ?? "", text: $text)
            } else {
                ZStack {
                    if isShowPassword {
                        TextField(placeholder ?? "", text: $text)
                    } else {
                        SecureField(placeholder ?? "", text: $text)
                    }
                    HStack {
                        Spacer()
                        showPasswordButtonView
                    }
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Color(.systemBackground))
        }
    }
    
    /// - Show/hide password
    var showPasswordButtonView: some View {
        Button {
            isShowPassword.toggle()
        } label: {
            Image(systemName: isShowPassword ? "eye.slash" : "eye")
                .foregroundStyle(Color.primaryBlue)
        }
    }
    
}

#Preview {
    CustomTextField(placeholder: "Enter your password", title: "Password", isSecure: true, text: .constant(""))
}
