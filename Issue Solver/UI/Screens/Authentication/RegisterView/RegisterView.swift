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
    
    var body: some View {
        
            ZStack {
                Color.surfaceBackground.ignoresSafeArea()
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack (spacing: 24){
                            titleView
                            textFieldsView
                            Spacer()
                        }
                    }
                    continueButtonView
                }
                .padding([.horizontal, .vertical], 16)
            }
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                hideKeyboard()
        }
    }
    
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
            CustomTextField(placeholder: "Şifrənizi təsdiq edin", title: "Şifrənin təsdiqi", isSecure: true, text: $vm.confirmPasswordText,isRightTextField: $vm.isRightConfirmEmail, errorMessage: $vm.confirmPasswordError)
            
            checkboxView
                .padding(.vertical, 8)
        }
    }
    
    var checkboxView: some View {
        HStack {
            CustomCheckBox(isChecked: $isChecked)
            
            TextView(text: "İstifadəçi şərtləri və Məxfilik siyasəti qəbul edirəm", clickableTexts: [Constants.privacyPolicy, Constants.termsOfUse])
        }
        .jakartaFont(.subtitle)
    }
    
    var continueButtonView: some View {
        VStack {
            
            CustomButton(title: "Davam et", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
                Task {
                    
                    await vm.register { boolean in
                        navigateOTPView = boolean
                    }
                    
                }
            }
            .background(
                NavigationLink(destination: OTPView(isChangePassword: false),
                               isActive: $navigateOTPView,
                               label: {})
            )
            
            
            .disabled(vm.fullNameText.isEmpty && vm.emailText.isEmpty && vm.passwordText.isEmpty && vm.confirmPasswordText.isEmpty && !isChecked)
            
            HStack {
                Text("Hesabınız var mı?")
                    .foregroundColor(.secondaryGray)
                CustomButton(style: .text, title: "Daxil olun") {
                    dismiss()
                }
            }
            .jakartaFont(.subtitle)
            .padding(.top, 8)
        }
    }
    
    var canContinue: Bool {
        return !vm.fullNameText.isEmpty && !vm.emailText.isEmpty && !vm.passwordText.isEmpty && !vm.confirmPasswordText.isEmpty && isChecked
    }
}



#Preview {
    RegisterView()
}
