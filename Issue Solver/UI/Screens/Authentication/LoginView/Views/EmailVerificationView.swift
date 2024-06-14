//
//  EmailVerificationView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 14.06.24.
//

import SwiftUI

struct EmailVerificationView: View {
    @StateObject var authVM: AuthViewModel = AuthViewModel()
    @StateObject var vm = EmailVerificationViewModel()
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24 ) {
                backButtonView
                titleView
                textFieldView
                Spacer()
                confirmButtonView
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        
    }
    
    // Back Button View
    var backButtonView: some View {
        CustomButton(style: .back, title: "") {
        }
    }
    
    //Title View
    var titleView: some View {
        CustomTitleView(title: "E-poçtunuzu daxil edin", subtitle: "E-poçt hesabınıza təsdiq kodu göndəriləcək.")
    }
    
    //Email TextField
    var textFieldView: some View {
        CustomTextField(placeholder: "E-poçtunuzu daxil edin",title: "E- poçt",text: $vm.emailText)
    }
    
    //Confirm Email Button
    var confirmButtonView: some View {
        CustomButton(title: "Təsdiq kodu göndər") {
            // TODO: action mus be added here
            Task {
                await vm.emailVerification()
            }
        }
    }
}

#Preview {
    EmailVerificationView()
}
