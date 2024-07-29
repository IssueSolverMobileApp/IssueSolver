//
//  EmailVerificationView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 14.06.24.
//

import SwiftUI

struct EmailVerificationView: View {
    @EnvironmentObject var router: Router
    @StateObject var vm = EmailVerificationViewModel()
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            VStack(alignment: .leading ) {
                titleView
                textFieldView
                Spacer()
                confirmButtonView
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)

            LoadingView(isLoading: vm.isLoading)
            
        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            hideKeyboard()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButtonView
            }
        }
        
    }
    
    // MARK: - BackButtonView
    var backButtonView: some View {
        CustomButton(style: .back, title: "") {
            router.dismissView()
        }
    }
    
    // MARK: - TitleView
    var titleView: some View {
        CustomTitleView(title: "E-poçtunuzu daxil edin", subtitle: "E-poçt hesabınıza təsdiq kodu göndəriləcək")
    }
    
    // MARK: - EmailTextField
    var textFieldView: some View {
        CustomTextField(placeholder: "E-poçtunuzu daxil edin",title: "E- poçt",text: $vm.emailText, isRightTextField: $vm.isRightEmail, errorMessage: $vm.emailError)
    }
    
    // MARK: - ConfirmEmailButton
    var confirmButtonView: some View {
        CustomButton(title: "Təsdiq kodu göndər", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
            Task {
                await vm.emailVerification() { success in
                    if success {
                        DispatchQueue.main.async {
                            /// - In success case will navigate PasswordChangeView
                            router.navigate { OTPView(emailModel: EmailModel(email: vm.emailText), isChangePassword: true) }
                        }
                    }
                }
            }
        }
        .disabled(!canContinue)
    }
    
    // MARK: - For Making Button Color With Opacity Logic
    var canContinue: Bool {
        !vm.emailText.isEmpty && vm.isRightEmail
    }
    
}

#Preview {
    EmailVerificationView()
}
