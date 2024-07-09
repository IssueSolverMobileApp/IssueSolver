//
//  NewPasswordView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import SwiftUI

struct NewPasswordView: View {
    
    @StateObject var vm = NewPasswordViewModel()
    @Environment (\.dismiss) private var dismiss
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack (spacing: 24) {
                ScrollView(showsIndicators: false) {
                        titleView
                        textFieldView
                    }
                    renewButtonView
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButtonView
            }
        }
    }
    
   ///Back Button View
    var backButtonView: some View {
        CustomButton(style: .back, title: "") {
            dismiss()
        }
    }
    
    /// Title View
    var titleView: some View {
        CustomTitleView(title: "Yeni şifrə",subtitle: "Daxil olmaq üçün yeni şifrə təyin edin.", color: .primaryBlue)
    }
    
    /// Textfield View
    
    var textFieldView: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                
                //Current Password View
                CustomTextField(placeholder: "Şifrənizi daxil edin",title: "Cari şifrə",isSecure: true, text: $vm.currentPasswordText, isRightTextField: $vm.isRightCurrentPassword, errorMessage: $vm.currentPasswordError)
                
                //New Password View
                CustomTextField(placeholder: "Yeni şifrəni təyin edin",title: "Yeni şifrə",isSecure: true, text: $vm.newPasswordText, isRightTextField: $vm.isRightNewPassword, errorMessage: $vm.newPasswordError)
                
                //Confirm New Password View
                CustomTextField(placeholder: "Şifrəni təsdiq edin",title: "Şifrənin təsdiqi",isSecure: true, text: $vm.confirmPasswordText, isRightTextField: $vm.isRightConfirmPassword, errorMessage: $vm.confirmPasswordError)
            }
        }
    }
    
    /// Renew button
    var renewButtonView: some View {
        CustomButton(style:.rounded,title: "Yenilə", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
                 vm.updateUserPassword(with:router)
        }
        .disabled(vm.currentPasswordText.isEmpty && vm.newPasswordText.isEmpty && vm.confirmPasswordText.isEmpty && !vm.isRightFields )
    }
        
    
    var canContinue: Bool {
        !vm.currentPasswordText.isEmpty && !vm.newPasswordText.isEmpty && !vm.confirmPasswordText.isEmpty && vm.isRightFields
    }
}

#Preview {
    NewPasswordView()
}
