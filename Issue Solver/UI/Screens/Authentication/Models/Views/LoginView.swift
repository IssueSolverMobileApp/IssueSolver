//
//  LoginView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 12.06.24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    @State private var navigateToEmailVerificationView = false
    @State private var navigateToRegisterView = false
    
    var body: some View {
        
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack {
                
                ScrollView(showsIndicators: false) {

                    titleView
                    textFieldsView

                }
                
                loginButtonView
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
            
        }
        .background {
            
            NavigationLink(
                destination: EmailVerificationView(),
                isActive: $navigateToEmailVerificationView,
                label: {})
            
            NavigationLink(
                destination: RegisterView(),
                isActive: $navigateToRegisterView,
                label: {})
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    // Title View
    var titleView: some View {
        CustomTitleView(title: "Daxil olun", subtitle: "Zəhmət olmasa, giriş üçün məlumatlarınızı daxil edin.")
            .padding(.bottom, 8)
    }
    
    var textFieldsView: some View {
        VStack(alignment: .trailing) {
            VStack (spacing: 20) {
                // Email TextField View
                CustomTextField(placeholder: "E-poçtunuzu daxil edin", title: "E-poçt", text: $vm.emailText, isRightTextField: $vm.isRightEmail)
                
                // Password TextField View
                CustomTextField(placeholder: "Şifrənizi daxil edin", title: "Şifrə", isSecure: true, text: $vm.passwordText, isRightTextField: $vm.isRightPassword, errorMessage: $vm.errorMessage)
            }
            // Forgot Password Button View
            CustomButton(style: .text, font: .subtitle, title: "Şifrənizi unutmusunuz?") {
                navigateToEmailVerificationView = true
            }
        }
    }
    
    var loginButtonView: some View {
        VStack {
            // Log in Button View
            CustomButton(title: "Daxil ol", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
                Task {
                    await vm.login()
                }
                
            }
            .disabled(vm.emailText.isEmpty && vm.passwordText.isEmpty)
            
            // Email Exists Button View
            HStack {
                Text("Hesabınız yoxdur?")
                    .foregroundColor(.secondaryGray)
                CustomButton(style: .text, title: "Qeydiyyatdan keçin") {
                    navigateToRegisterView = true
                }
            }
            .jakartaFont(.subtitle)
            .padding(.top, 8)
        }
    }
    var canContinue: Bool {
        return !vm.emailText.isEmpty && !vm.passwordText.isEmpty
    }
}

#Preview {
    LoginView()
}
