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
    @State var isNavigateToOTPView: Bool = false
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 24 ) {
                titleView
                textFieldView
                Spacer()
                confirmButtonView
            }
            .padding([.horizontal, .vertical], 16)
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
        CustomTextField(placeholder: "E-poçtunuzu daxil edin",title: "E- poçt",text: $vm.emailText)
    }
    
    //Confirm Email Button
    var confirmButtonView: some View {
        CustomButton(title: "Təsdiq kodu göndər", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
            Task {
                await vm.emailVerification { result in
                    isNavigateToOTPView = true
                }
            }
        }
        .background(
            NavigationLink(
                destination: OTPView(emailModel: EmailModel(email: vm.emailText), isChangePassword: true, error: vm.error),
                isActive: $isNavigateToOTPView,
                label: {}))
        .disabled(vm.emailText.isEmpty)
    }
    
    var canContinue: Bool {
        !vm.emailText.isEmpty
    }
}

#Preview {
    EmailVerificationView()
}
