//
//  LoginView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 12.06.24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var authVM: AuthViewModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack {
                titleView
                textFieldsView
                Spacer()
                loginButtonView
            }
            .padding(.top, 24)
        }
    }
    
    // Title View
    var titleView: some View {
        CustomTitleView(title: "Daxil olun", subtitle: "Zəhmət olmasa, giriş üçün məlumatlarınızı daxil edin.")
    }
    
    var textFieldsView: some View {
        
        VStack(alignment: .trailing, spacing: 20) {
            // Email TextField View
            CustomTextField(placeholder: "E-poçtunuzu daxil edin", title: "E-poçt", text: $authVM.emailText)
            
            // Password TextField View
            CustomTextField(placeholder: "Şifrənizi daxil edin", title: "Şifrə", isSecure: true, text: $authVM.passwordText)
            
            // Forgot Password Button View
            CustomButton(style: .text, font: .system(size: 14), title: "Şifrənizi unutmusunuz?") {
                
            }
        }
        .padding()
    }
    
    var loginButtonView: some View {
        VStack {
            // Log in Button View
            CustomButton(title: "Daxil ol") {
                
            }
            
            // Email Exists Button View
            HStack {
                Text("Hesabınız yoxdur?")
                    .foregroundColor(.secondaryGray)
                CustomButton(style: .text, font: .plusJakartaSansRegular(size: 15), title: "Qeydiyyatdan keçin") {
                    
                }
            }
            .font(.plusJakartaSansRegular(size: 15))
            .padding(.top, 8)
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
