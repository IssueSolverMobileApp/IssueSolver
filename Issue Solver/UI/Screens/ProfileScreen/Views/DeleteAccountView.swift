//
//  DeleteAccountView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import SwiftUI

struct DeleteAccountView: View {
    
    @StateObject var vm = DeleteAccountViewModel()
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                backButtonView
                titleView
                textFieldView
                Spacer()
                deleteAccountButtonView
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
   ///Back Button View
    var backButtonView: some View {
        CustomButton(style: .back, title: "") {}
    }
    
    /// Title View
    var titleView: some View {
        CustomTitleView(title: "Şifrənizi daxil edin", subtitle: "Zəhmət olmasa, hesabı silmək üçün məlumatlarınızı daxil edin.", color: .primaryBlue)
    }
    
    ///  Password Textfield View
    var textFieldView: some View {

        CustomTextField(placeholder: "***********",title: "Şifrə",isSecure: true, text: $vm.passwordText)
    }

    
    /// saveChangesButtonView
    var deleteAccountButtonView: some View {
        
        CustomButton(style:.rounded,title: "Hesabı sil") {}
            .padding(.vertical, -54)
    }
        
}

#Preview {
    DeleteAccountView()
}
