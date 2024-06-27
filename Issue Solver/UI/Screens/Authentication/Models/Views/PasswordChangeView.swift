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
    @State private var navigateToLoginView = false
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack (alignment: .leading) {
                titleView
                textFieldView
                Spacer()
                renewButtonView
            }
            .padding(.horizontal,20)
            .padding(.vertical, 24)
            
            ///Progress View
            if isLoading {
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
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarBackButtonHidden(true)
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
                if vm.confirmPasswordSuccess {
                    isLoading = false
                    navigateToLoginView = true
                } else {
                    isLoading = false
                }
            }
        }
        .disabled(!canContinue)
        
        ///In success case will navigate PasswordChangeView
        .background(
            NavigationLink(
                destination: LoginView(),
                isActive: $navigateToLoginView,
                label: {}))
        
        ///In error case alert will shown
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text(""), message: Text(vm.errorMessage), dismissButton: .default(Text("Oldu")) {isLoading = false})
           }
    }
    var canContinue: Bool {
        !vm.passwordText.isEmpty && !vm.confirmPasswordText.isEmpty && vm.isRightPassword && vm.isRightConfirmPassword
    }
}

#Preview {
    PasswordChangeView()
}
