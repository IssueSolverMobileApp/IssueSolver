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
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                titleView
                textFieldView
                Spacer()
                renewButtonView
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
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
                CustomTextField(placeholder: "Şifrənizi daxil edin",title: "Cari şifrə",isSecure: true, text: $vm.currentPasswordText)
                
                //New Password View
                CustomTextField(placeholder: "Yeni şifrəni təyin edin",title: "Yeni şifrə",isSecure: true, text: $vm.newPasswordText)
                
                //Confirm New Password View
                CustomTextField(placeholder: "Şifrəni təsdiq edin",title: "Şifrənin təsdiqi",isSecure: true, text: $vm.confirmPasswordtext)
            }
        }
    }
    
    /// Renew button
    var renewButtonView: some View {
        CustomButton(style:.rounded,title: "Yenilə") {}
            .padding(.vertical, -54)
    }
        
}

#Preview {
    NewPasswordView()
}
