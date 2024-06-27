//
//  RegisterView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 12.06.24.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @StateObject var vm = RegisterViewModel()
    @State var navigateOTPView: Bool = false
    @State var isChecked: Bool = false
    @State var showCheckboxError: Bool = false
    
    var body: some View {
        
            ZStack {
                Color.surfaceBackground.ignoresSafeArea()
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack (alignment: .leading){
                            titleView
                            textFieldsView
                            Spacer()
                        }
                    }
                    continueButtonView
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                
                ///Progress View
                if vm.isLoading {
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
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                hideKeyboard()
        }
    }
    
    ///Title View
    var titleView: some View {
        CustomTitleView(title: "Qeydiyyat", subtitle: "Zəhmət olmasa, şəxsi məlumatlarınızı daxil edin.")
    }
    
    var textFieldsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            //Name Surname Text Field View
            CustomTextField(placeholder: "Ad, Soyad", title: "Ad, Soyad", text: $vm.fullNameText,isRightTextField: $vm.isRightFullName, errorMessage: $vm.fullNameError)
            
            
            // Email Text Field View
            CustomTextField(placeholder: "E-poçtunuzu daxil edin", title: "E-poçt", text: $vm.emailText, isRightTextField: $vm.isRightEmail, errorMessage: $vm.emailError)
             
            
            // Password TextField View
            VStack(alignment: .leading, spacing: 8) {
                CustomTextField(placeholder: "Şifrənizi təyin edin", title: "Şifrə", isSecure: true, text: $vm.passwordText,isRightTextField: $vm.isRightPassword, errorMessage: $vm.passwordError)
            }
            
            // Confirm Password TextField View
            CustomTextField(placeholder: "Şifrənizi təsdiq edin", title: "Şifrənin təsdiqi", isSecure: true, text: $vm.confirmPasswordText,isRightTextField: $vm.isRightConfirmPassword, errorMessage: $vm.confirmPasswordError)
            
            checkboxView
                .padding(.vertical, 8)
        }
        .padding(1)
    }
    ///CheckBox View
    var checkboxView: some View {
        HStack {
            CustomCheckBox(isChecked: $isChecked, borderColor: showCheckboxError && !isChecked ? .red : .clear)
            
            TextView(text: "Şərtlər və qaydaları qəbul edirəm", clickableTexts: [ Constants.termsOfUse])
                .jakartaFont(.subtitle)
        }
        
    }
    
    var continueButtonView: some View {
        VStack {
            
            CustomButton(title: "Davam et", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
                Task {
                    if !isChecked {
                      showCheckboxError = true
                    } else {
                        showCheckboxError = false
                    }
                    await vm.register { success in
                        if success {
                            navigateOTPView = true
                        }
                    }
                }
            }
            .background(
                NavigationLink(destination: OTPView(isChangePassword: false),
                               isActive: $navigateOTPView,
                               label: {})
            )
            .disabled(!canContinue)
            
            HStack {
                Text("Hesabınız var mı?")
                    .foregroundStyle(.secondaryGray)
                CustomButton(style: .text, title: "Daxil olun") {
                    dismiss()
                }
            }
            .jakartaFont(.subtitle)
            .padding(.top, 8)
        }
    }
    
    var canContinue: Bool {
        return !vm.fullNameText.isEmpty && !vm.emailText.isEmpty && !vm.passwordText.isEmpty && !vm.confirmPasswordText.isEmpty && vm.isRightFields
    }
}



#Preview {
    RegisterView()
}
