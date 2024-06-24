//
//  OTPView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 11.06.24.
//

import SwiftUI

struct OTPView: View {
  
    @StateObject var vm = OTPViewModel()
    @Environment (\.dismiss) private var dismiss
    @State var isChangePassword: Bool = false
    @State var navigateLoginView: Bool = false
    @State var navigatePasswordChangeView: Bool = false
        
    var body: some View {
        
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                titleView
                OTPTextField(numberOfFields: 6) { code in
                    vm.otpText = code
                }
                timerView
                Spacer()
                confirmButtonView
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
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
    
    // Back Button View
    var backButtonView: some View {
        CustomButton(style: .back, title: "") {
            dismiss()
        }
    }
    
    //Title View
    var titleView: some View {
        CustomTitleView(title: "Təsdiq Kodu", subtitle: "E-poçtunuza gələn təsdiq kodunu daxil edin.")
    }
    
    //Countdown View
    var timerView: some View {
        HStack {
            Text("Qalan vaxt:")
                .foregroundStyle(.primaryBlue)
                .font(.system(size: 17))
            CountdownView()
        }
    }
    
    // Button View
    var confirmButtonView: some View {
        
        VStack(spacing: 16) {
            
            CustomButton(title: "Təsdiqlə", color: .primaryBlue) {
               // TODO: action must be added here
                if isChangePassword  {
                    Task {
                        await vm.sendOTPTrust()
                    }
                    navigatePasswordChangeView = true
                } else {
                    Task {
                        await vm.sendOTPConfirm() 
                    }
                    navigateLoginView = true

                }
            }
            .background(
                NavigationLink(
                   destination: PasswordChangeView(),
                   isActive: $navigatePasswordChangeView,
                   label: {})
            )  
            .background(
                NavigationLink(
                   destination: LoginView(),
                   isActive: $navigateLoginView,
                   label: {})
            )
            
            
            CustomButton(style: .text, title: "Kodu yenidən göndər") {
                
            }
            
        }
    }
}

#Preview {
    OTPView()
}
