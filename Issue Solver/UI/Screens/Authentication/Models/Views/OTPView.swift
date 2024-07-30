//
//  OTPView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 11.06.24.
//

import SwiftUI

struct OTPView: View {
    @EnvironmentObject var router: Router
    @StateObject var vm = OTPViewModel()
    
    var emailModel: EmailModel?
    var isChangePassword: Bool = false
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            contentView
            LoadingView(isLoading: vm.isLoading)
        }
        .disabled(vm.isLoading)
    }
    
    // MARK: - Views
    
    var contentView: some View {
        VStack(alignment: .leading, spacing: 24) {
            titleView
            otpFieldsView
            
            Spacer()
            confirmButtonView
        }
        .onTapGesture {
            hideKeyboard()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButtonView
            }
        }
        .padding([.horizontal, .vertical], 16)
        .navigationBarBackButtonHidden(true)
    }
    
    // Title View
    var titleView: some View {
        ZStack(alignment: .topTrailing) {
            CustomTitleView(title: "Təsdiq Kodu", subtitle: "E-poçtunuza gələn təsdiq kodunu daxil edin")
            timerView
        }
    }
    
    // OTP Fields View
    var otpFieldsView: some View {
        VStack(alignment: .leading) {
            OTPTextField(enteredValue: $vm.otpCode, isError: $vm.isError)
            
            Text(vm.errorText)
                .foregroundStyle(.red)
                .font(.system(size: 17))
        }
    }
    
    // Back Button View
    var backButtonView: some View {
        CustomButton(style: .back, title: "") {
            router.dismissView()
        }
    }
    
    // Countdown View
    var timerView: some View {
        HStack {
            if vm.timer != nil {
                Image(.timerIcon)
            }
            vm.timer
        }
        .padding(.vertical,6)
    }
    
    // Button View
    var confirmButtonView: some View {
        VStack(spacing: 16) {
            CustomButton(title: "Təsdiqlə", color: .primaryBlue) {
                vm.checkOTPCode(isChangePassword: isChangePassword) { success in
                    if success {
                        DispatchQueue.main.async {
                            if isChangePassword {
                                router.navigate { PasswordChangeView() }
                            } else {
                                router.popToRoot()
                            }
                        }
                    }
                }
            }
            
            CustomButton(style: .text, title: "Kodu yenidən göndər") {
                vm.resendOTP(emailModel: emailModel)
            }
            .disabled(!vm.isTimerFinished)
            .opacity(vm.isTimerFinished ? 1 : 0.5)
            
        }
    }
    
}

#Preview {
    OTPView()
}
