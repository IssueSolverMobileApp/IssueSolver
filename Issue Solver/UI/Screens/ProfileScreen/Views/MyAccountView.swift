//
//  MyAccountView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import SwiftUI

struct MyAccountView: View {
    
    @StateObject var vm = MyAccountViewModel()
    @Environment (\.dismiss) private var dismiss
    @EnvironmentObject var router: Router
    
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            
            VStack (spacing: 24) {
                ScrollView {
                    titleView
                    VStack (spacing: 24) {
                        fullNameTextFieldView
                        emailTextView
                    }
                }
                    saveChangesButtonView
            }
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
        
        .onAppear {
                 vm.getUserInfo()
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
        CustomTitleView(title: "Hesabım", subtitle: "Hesabın məlumatlarını dəyişə bilərsiniz", color: .primaryBlue)
    }
    
    /// Textfield View
    
    var fullNameTextFieldView: some View {
        CustomTextField(placeholder: "Name Surname",title: "Ad, soyad", text: $vm.fullNameText, isRightTextField: $vm.isRightFullName, errorMessage: $vm.fullNameError)
      }
    
   var emailTextView: some View {
       VStack(alignment: .leading) {
           Text("E-poçt")
               .foregroundStyle(.disabledGray)
               .jakartaFont(.heading)
           ZStack(alignment: .leading) {
               RoundedRectangle(cornerRadius: Constants.cornerRadius)
                   .fill(Color(.lightGray.withAlphaComponent(0.2)))
                   .frame(height: 56)
               
               Text(vm.emailText)
                   .foregroundStyle(.primaryGray)
                   .padding(.horizontal, 16)
                   .jakartaFont(.subtitle)
           }
       }
  }
    /// saveChangesButtonView
    var saveChangesButtonView: some View {
        CustomButton(style:.rounded,title: "Dəyişiklikləri yadda saxla", color: canContinue ? .primaryBlue : .primaryBlue.opacity(0.5)) {
                vm.updateUserFullName(with: router)
        }
        .disabled(vm.fullNameText.isEmpty)
    }
    var canContinue: Bool {
        !vm.fullNameText.isEmpty
    }
}

#Preview {
    MyAccountView()
}
