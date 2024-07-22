//
//  NewRequestView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 01.07.24.
// 

import SwiftUI

struct NewQueryView: View {
    @EnvironmentObject var router: Router
    @StateObject var vm = NewQueryViewModel()
    
    @State private var addressText: String = ""
    @State private var categoryPicker: String = ""
        
    @State var isRightTextEditor: Bool = true
    @State var explanationEditorText: String = ""
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    titleView
                    textFieldView
                    pickerView
                    textView
                    buttonView
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
        }
    }
    
    
    var titleView: some View {
        HStack {
            CustomTitleView(title: "Yeni sorğu", subtitle: "") {
                router.navigate { NewQueryInfoView() }
            }
        }
    }
    
    var textFieldView: some View {
        VStack {
            CustomTextField(placeholder: "Ünvanı daxil edin", title: "Problemin baş verdiyi yer", text: $addressText, errorMessage: .constant(""), clickableText: Constants.howToRequestShare, clickableTextWidth: 116)
        }
    }
    
    var pickerView: some View {
        
        VStack(spacing: 16) {
            CustomPickerView(selection: $vm.selectedCategory, selectedTitle: vm.selectedCategory?.categoryName ?? "", title: "Problemin yönləndiriləcəyi qurum", isRightTextEditor: $isRightTextEditor) {
                
            }
            
            CustomPickerView(selection: $vm.selectedCategory, selectedTitle: vm.selectedCategory?.categoryName ?? "", title: "Kategoriya", isRightTextEditor: $isRightTextEditor) {
                
            }
            
        }
    }
    
    
    var buttonView: some View {
        VStack(spacing: 16) {
            CustomButton(style: .rounded, title: "Paylaş", color: .primaryBlue) {
                // TODO: Paylaş button action must be here
            }
            
            CustomButton(style: .rounded, title: "Sıfırla", color: .white, foregroundStyle: .primaryBlue) {
                // TODO: sıfırla button action must be here
            }
        }
    }
    
    var textView: some View {
        
        CustomTextEditor(title: "Ətraflı izah", errorText: "Min:10-Max:500 simvol", explanation: $explanationEditorText, isRightTextField: $isRightTextEditor)
    }
}

#Preview {
    NewQueryView()
}

