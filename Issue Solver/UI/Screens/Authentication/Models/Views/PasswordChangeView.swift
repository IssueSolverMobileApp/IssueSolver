//
//  PasswordChangeView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 14.06.24.
//

import SwiftUI

struct PasswordChangeView: View {
    
    @StateObject var vm: PasswordChangeViewModel = PasswordChangeViewModel()
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack (spacing: 24 ) {
                titleView
                textFieldView
                Spacer()
                renewButtonView
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
        if isLoading {
           VStack {
               Spacer()
               ProgressView()
                   .progressViewStyle(CircularProgressViewStyle())
                   .scaleEffect(2)
                   .padding()
               Spacer()
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
//        MARK: --- Reason: Test
//        .task {
//            do {
//                await vm.sendOTP()
//            }
//        }
    }
    
    //Title View
    var titleView: some View {
        CustomTitleView(title: "Yeni şifrə", subtitle: "Daxil olmaq üçün yeni şifrə təyin edin.")
    }
    
    //Text Field View
    
    var textFieldView: some View {
        VStack (spacing: 20 ){
            
            CustomTextField(placeholder: "Şifrənizi təyin edin",title: "Şifrə", isSecure: true, text: $vm.passwordText, isRightTextField: $vm.isRightPassword, errorMessage: $vm.passwordError)
        
        CustomTextField(placeholder: "Şifrənizi təsdiq edin",title: "Şifrənin təsdiqi", isSecure: true, text: $vm.confirmPasswordText, isRightTextField: $vm.isRightConfirmPassword, errorMessage: $vm.confirmPasswordError)
        }
    }
    
    // Renew Button View
    var renewButtonView: some View {
        CustomButton(title: "Yenilə", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
            isLoading = true
            
            Task {
                await vm.updatePassword()
                isLoading = false
            }
        }
        .disabled(vm.passwordText.isEmpty && vm.confirmPasswordText.isEmpty && !vm.isRightPassword && !vm.isRightConfirmPassword)
    }
    var canContinue: Bool {
        !vm.passwordText.isEmpty && !vm.confirmPasswordText.isEmpty && vm.isRightPassword && vm.isRightConfirmPassword
    }
}

#Preview {
    PasswordChangeView()
}
