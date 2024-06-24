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
                    VStack(alignment: .leading, spacing: 24) {
                        titleView
                        textFieldsView
                        Spacer()
                    }
                }
                loginButtonView
            }
            .padding([.horizontal, .vertical], 16)
            
        }
        
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    // Title View
    var titleView: some View {
        CustomTitleView(title: "Daxil olun", subtitle: "Zəhmət olmasa, giriş üçün məlumatlarınızı daxil edin.")
    }
    
    var textFieldsView: some View {
        
        VStack(alignment: .trailing, spacing: 20) {
            // Email TextField View
            CustomTextField(placeholder: "E-poçtunuzu daxil edin", title: "E-poçt", text: $vm.emailText)
            
            // Password TextField View
            CustomTextField(placeholder: "Şifrənizi daxil edin", title: "Şifrə", isSecure: true, text: $vm.passwordText)
            
            // Forgot Password Button View
            CustomButton(style: .text, font: .subtitle, title: "Şifrənizi unutmusunuz?") {
                navigateToEmailVerificationView = true
            }
            .background(
                NavigationLink(
                    destination: EmailVerificationView(),
                    isActive: $navigateToEmailVerificationView,
                    label: {}))
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
                .background(
                    NavigationLink(
                        destination: RegisterView(),
                        isActive: $navigateToRegisterView,
                        label: {}))
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
