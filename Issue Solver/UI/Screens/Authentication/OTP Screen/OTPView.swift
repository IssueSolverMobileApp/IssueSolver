//
//  OTPView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 11.06.24.
//

import SwiftUI

struct OTPView: View {
    @Environment (\.dismiss) private var dismiss
    @Environment (\.presentationMode) private var presentationMode
    @StateObject var vm = OTPViewModel()
    @State var emailModel: EmailModel?
    @State var isChangePassword: Bool = false
    @State var error: Error?
    
    @State private var isOTPHasError: Bool = false
    @State private var navigateLoginView: Bool = false
    @State private var navigatePasswordChangeView: Bool = false
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            contentView
            
            if vm.isLoading {
                loadingView
            }
        }
        .alert(isPresented: $isOTPHasError) { /// - Use default Alert view temporary
            Alert(title: Text(error?.localizedDescription ?? ""), dismissButton: .default(Text("Oldu"), action: {
                isOTPHasError = false
                error = nil
                presentationMode.wrappedValue.dismiss()
            }))
            
        }
        .onAppear {
            if let _ = error {
                isOTPHasError = error != nil ? true : false
            }
            vm.timer = CountdownView { /// - When timer finishes, do something
                vm.isTimerFinished = true
            }
        }
    }
    
    // MARK: - Views
    
    var contentView: some View {
        VStack(alignment: .leading, spacing: 24) {
            titleView
            otfFieldsView
            if vm.isTimerFinished {
                timerView
            }
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
        CustomTitleView(title: "Təsdiq Kodu", subtitle: "E-poçtunuza gələn təsdiq kodunu daxil edin.")
    }
    
    // OTP Fields View
    var otfFieldsView: some View {
        OTPTextField(numberOfFields: Constants.numberOfOTPFields) { code in
            vm.otpText = code
        }
    }
    
    // Back Button View
    var backButtonView: some View {
        CustomButton(style: .back, title: "") {
            dismiss()
        }
    }
    
    // Countdown View
    var timerView: some View {
        HStack {
            Text("Qalan vaxt:")
                .foregroundStyle(.primaryBlue)
                .font(.system(size: 17))
            vm.timer
        }
    }
    
    // Button View
    var confirmButtonView: some View {
        VStack(spacing: 16) {
            CustomButton(title: "Təsdiqlə", color: .primaryBlue) {
                checkOTPCode()
            }
            
            CustomButton(style: .text, title: "Kodu yenidən göndər") {
                resendOTP()
            }
            
        }
        .background{
            NavigationLink(
                destination: PasswordChangeView(),
                isActive: $navigatePasswordChangeView,
                label: {})
            
            NavigationLink(
                destination: LoginView(),
                isActive: $navigateLoginView,
                label: {})
        }
    }
    
    // Loading View
    var loadingView: some View {  /// - Creating loading view for some time, to replace actual full customized loading view
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(.circular)
            
        }
    }
    
    // MARK: - Private Functions
    
    private func checkOTPCode() {
        vm.isLoading = true
        if isChangePassword  {
            Task {
                await vm.sendOTPTrust { result in
                    switch result {
                    case .success(_):
                        vm.isLoading = false
                        navigatePasswordChangeView = true
                    case .failure(let error):
                        vm.isLoading = false
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            Task {
                await vm.sendOTPConfirm()
            }
            navigateLoginView = true
        }
    }
    
    private func resendOTP() {
        vm.isLoading = true
        if let emailModel {
            vm.resendOTP(with: emailModel)
        }
    }
}

#Preview {
    OTPView()
}
