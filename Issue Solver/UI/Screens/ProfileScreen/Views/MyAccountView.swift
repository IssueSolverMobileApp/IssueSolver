//
//  MyAccountView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 23.06.24.
//

import SwiftUI

struct MyAccountView: View {
    
    @StateObject var vm = MyAccountViewModel()
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                backButtonView
                titleView
                textFieldView
                Spacer()
                saveChangesButtonView
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
        CustomTitleView(title: "Hesabım", subtitle: "Hesabın məlumatlarını dəyişə bilərsiniz", color: .primaryBlue)
    }
    
    /// Textfield View
    
    var textFieldView: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                
                //Full Name View
                CustomTextField(placeholder: "İRADƏ BƏKİRLİ",title: "Ad, soyad", text: $vm.fullNameText)
                
                //Email View
                CustomTextField(placeholder: "iradebekirli@gmail.com",title: "E-poçt",textColor: .disabledGray, color: .disabledGray.opacity(0.12) , text: $vm.emailText)
            }
        }
    }
    
    /// saveChangesButtonView
    var saveChangesButtonView: some View {
        CustomButton(style:.rounded,title: "Dəyişiklikləri yadda saxla") {}
            .padding(.vertical, -54)
    }
        
}

#Preview {
    MyAccountView()
}
