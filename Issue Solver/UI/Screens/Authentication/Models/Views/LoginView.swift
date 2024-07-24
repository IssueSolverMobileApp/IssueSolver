//
//  LoginView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 12.06.24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: Router
    @StateObject var vm = LoginViewModel()
    
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
            .padding(.bottom, 16)
            
            LoadingView(isLoading: vm.isLoading)
         }
        .onAppear {
            vm.emailText = ""
            vm.passwordText = ""
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
        // MARK: - TitleView
    var titleView: some View {
        CustomTitleView(title: "Daxil olun", subtitle: "Zəhmət olmasa, giriş üçün məlumatlarınızı daxil edin.")
            .padding(.bottom, 8)
    }
    
    // MARK: - TextFieldViews
    var textFieldsView: some View {
        VStack(alignment: .trailing) {
            VStack (spacing: 20) {
                /// -  Email TextField View
                CustomTextField(placeholder: "E-poçtunuzu daxil edin", title: "E-poçt", text: $vm.emailText, isRightTextField: $vm.isRightEmail)
                
                /// -  Password TextField View
                CustomTextField(placeholder: "Şifrənizi daxil edin", title: "Şifrə", isSecure: true, text: $vm.passwordText, isRightTextField: $vm.isRightPassword, errorMessage: $vm.errorMessage)
            }
            /// - Forgot Password Button View
            CustomButton(style: .text, font: .subtitle, title: "Şifrənizi unutmusunuz?") {
                router.navigate { EmailVerificationView() }
            }
        }
        .padding(1)
    }
    
    // MARK: - BUTTONS
    var loginButtonView: some View {
        VStack {
            /// -  Log in Button View
            CustomButton(title: "Daxil ol", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
                Task {
                    await vm.login { success in
                        if !success {
                            let item = EmailModel(email: vm.emailText)
                            router.navigate { OTPView(emailModel: item, isChangePassword: false)
                            }
                        }
                    }
                }
            }
            .disabled(vm.emailText.isEmpty || vm.passwordText.isEmpty)
            
            /// -  Email Exists Button View
            HStack {
                Text("Hesabınız yoxdur?")
                    .foregroundColor(.secondaryGray)
                CustomButton(style: .text, title: "Qeydiyyatdan keçin") {
                    router.navigate { RegisterView() }
                }
            }
            .jakartaFont(.subtitle)
            .padding(.vertical, 8)
        }
    }
    // MARK: - For Making Button Color With Opacity Logic
    var canContinue: Bool {
        return !vm.emailText.isEmpty && !vm.passwordText.isEmpty
    }
}

#Preview {
    LoginView()
}
