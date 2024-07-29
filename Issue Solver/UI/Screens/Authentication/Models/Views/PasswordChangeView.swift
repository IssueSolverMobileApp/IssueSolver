//
//  PasswordChangeView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 14.06.24.
//

import SwiftUI

struct PasswordChangeView: View {
    @EnvironmentObject var router: Router
    @StateObject var vm: PasswordChangeViewModel = PasswordChangeViewModel()
    
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
            .padding(.bottom, 16)

        }
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            hideKeyboard()
        }
        /// - In success case view will navigate to PasswordChangeView
        .background(
            NavigationLink(destination: LoginView(), isActive: $vm.navigateToLoginView, label: {}))
    }
    
    // TitleView
    var titleView: some View {
        CustomTitleView(title: "Yeni şifrə", subtitle: "Daxil olmaq üçün yeni şifrə təyin edin")
    }
    
    // TextFieldViews
    var textFieldView: some View {
        VStack (spacing:20) {
            CustomTextField(placeholder: "Şifrənizi təyin edin",title: "Şifrə", isSecure: true, text: $vm.passwordText, isRightTextField: $vm.isRightPassword, errorMessage: $vm.passwordError)
        
            CustomTextField(placeholder: "Şifrənizi təsdiq edin",title: "Şifrənin təsdiqi", isSecure: true, text: $vm.confirmPasswordText, isRightTextField: $vm.isRightConfirmPassword, errorMessage: $vm.confirmPasswordError)
        }
    }
    
    // RenewButtonView
    var renewButtonView: some View {
        CustomButton(title: "Yenilə", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
            
            vm.isLoading = true
                Task {
                    await vm.updatePassword() { result in
                        switch result {
                        case .success(_):
                            vm.isLoading = false
                            DispatchQueue.main.async {
                                router.popToRoot()
                            }
                        case .failure(_):
                            vm.isLoading = false
                        }
                    }
                }
            }
        .disabled(!canContinue)
        
        /// - In error case alert will shown
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text(""), message: Text(vm.errorMessage), dismissButton: .default(Text("Oldu")) {vm.isLoading = false})
          }
       }
    
    //  For Making Button Color With Opacity Logic
    var canContinue: Bool {
        !vm.passwordText.isEmpty && !vm.confirmPasswordText.isEmpty && vm.isRightPassword && vm.isRightConfirmPassword
    }
    
}

#Preview {
    PasswordChangeView()
}
