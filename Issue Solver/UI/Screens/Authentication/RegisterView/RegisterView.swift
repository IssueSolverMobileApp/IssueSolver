//
//  RegisterView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 12.06.24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var authVM: AuthViewModel = AuthViewModel()
    
    // Dummy variables
    @State var isChecked: Bool = false
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack (spacing: 24){
                titleView
                ScrollView(showsIndicators: false) {
                    VStack {
                        textFieldsView
                        Spacer()
                    }
                }
                continueButtonView
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
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
            CustomTextField(placeholder: "Ad, Soyad", title: "Ad, Soyad", text: $authVM.fullNameText)
            
            
            // Email Text Field View
            CustomTextField(placeholder: "E-poçtunuzu daxil edin", title: "E-poçt", text: $authVM.emailText)
            
            // Password TextField View
            VStack(alignment: .leading, spacing: 8) {
                CustomTextField(placeholder: "Şifrənizi təyin edin", title: "Şifrə", isSecure: true, text: $authVM.passwordText)
                Text("Supporting text or hint")
                    .jakartaFont(.subtitle2)
                    .foregroundColor(.secondaryGray)
            }
            
            // Confirm Password TextField View
            CustomTextField(placeholder: "Şifrənizi təsdiq edin", title: "Şifrənin təsdiqi", isSecure: true, text: $authVM.confirmPasswordText)
            
            checkboxView
                .padding(.vertical, 10)
        }
    }
    
    var checkboxView: some View {
        HStack {
            CustomCheckBox(isChecked: $isChecked)
                
                Text("İstifadəçi şərtləri və Məxfilik siyasəti")
                .foregroundColor(.primaryBlue)
//                .onTapGesture {
//                  //functionality must be added
//                    print("Privacy Policy tapped")
//                }
            +
                Text(" qəbul edirəm.")
            
        }
        .jakartaFont(.subtitle)
    }
    
    var continueButtonView: some View {
        VStack {
            CustomButton(title: "Davam et", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {

            }
            
            HStack {
                Text("Hesabınız var mı?")
                    .foregroundColor(.secondaryGray)
                CustomButton(style: .text, title: "Daxil olun") {
                  
                }
            }
            .jakartaFont(.subtitle)
            .padding(.top, 8)
        }
    }
    
    var canContinue: Bool { return !authVM.fullNameText.isEmpty && !authVM.emailText.isEmpty && !authVM.passwordText.isEmpty && !authVM.confirmPasswordText.isEmpty && isChecked
    }
}



#Preview {
    RegisterView()
}
