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
            
            ScrollView(showsIndicators: false) {
                VStack {
                    titleView
                    textFieldsView
                    Spacer()
                    continueButtonView
                }
            }
        }
    }
    
    var titleView: some View {
        CustomTitleView(title: "Qeydiyyat", subtitle: "Zəhmət olmasa, şəxsi məlumatlarınızı daxil edin.")
    }
    
    var textFieldsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Full Name Text Field View
            CustomTextField(placeholder: "Ad, soyad", title: "Ad, soyad", text: $authVM.emailText)
            
            // Email Text Field View
            CustomTextField(placeholder: "E-poçtunuzu daxil edin", title: "E-poçt", text: $authVM.emailText)
            
            // Password TextField View
            CustomTextField(placeholder: "Şifrənizi təyin edin", title: "Şifrə", isSecure: true, text: $authVM.passwordText)
            
            // Confirm Password TextField View
            CustomTextField(placeholder: "Şifrənizi təsdiq edin", title: "Şifrənin təsdiqi", isSecure: true, text: $authVM.passwordText)
            
            checkboxView
                .padding(.vertical, 10)
        }
        .padding()
    }
    
    var checkboxView: some View {
        HStack {
            CustomCheckBox(isChecked: $isChecked)
            HStack {
                // Terms of Use Button View
                CustomButton(style: .text, font: .system(size: 12), title: "Istifadəçi şərtləri") {
                    
                }
                
                Text("və")
                
                // Privacy Policy Button View
                CustomButton(style: .text, font: .system(size: 12), title: "Məxfilik siyasəti") {
                    
                }
                Text("qəbul edirəm.")
            }
        }
        .font(.caption)
    }
    
    var continueButtonView: some View {
        VStack {
            CustomButton(title: "Davam et") {
                
            }
            
            
            HStack {
                Text("Hesabınız var mı?")
                CustomButton(style: .text, font: .system(size: 14), title: "Daxil olun") {
                    
                }
            }
            .font(.system(size: 12))
            .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
