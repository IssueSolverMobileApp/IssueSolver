//
//  EmailVerificationView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 14.06.24.
//

import SwiftUI

struct EmailVerificationView: View {
    @Environment (\.dismiss) private var dismiss
    @StateObject var vm = EmailVerificationViewModel()
    @State private var navigateOTPView = false
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            VStack(alignment: .leading ) {
                titleView
                textFieldView
                Spacer()
                confirmButtonView
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 20)
            
            ///Progress View
            if isLoading {
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1)
                        .padding()
                    Spacer()
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButtonView
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Back Button View
    var backButtonView: some View {
        CustomButton(style: .back, title: "") {
            dismiss()
        }
    }
    
    //Title View
    var titleView: some View {
        CustomTitleView(title: "E-poçtunuzu daxil edin", subtitle: "E-poçt hesabınıza təsdiq kodu göndəriləcək.")
    }
    
    //Email TextField
    var textFieldView: some View {
        CustomTextField(placeholder: "E-poçtunuzu daxil edin",title: "E- poçt",text: $vm.emailText, isRightTextField: $vm.isRightEmail, errorMessage: $vm.emailError)
    }
    
    //Confirm Email Button
    var confirmButtonView: some View {
        CustomButton(title: "Təsdiq kodu göndər", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
            isLoading = true
            
            Task {
                await vm.emailVerification() { result in
                    navigateOTPView = result
                    isLoading = false
                }
            }
        }
        .disabled(!canContinue)
        
        /// - In success case will navigate PasswordChangeView
        .background(
            NavigationLink(
                destination: OTPView(emailModel: EmailModel(email: vm.emailText), isChangePassword: true),
                isActive: $navigateOTPView,
                label: {}))
        
    }
    
    var canContinue: Bool {
        !vm.emailText.isEmpty && vm.isRightEmail
    }
}

#Preview {
    EmailVerificationView()
}
