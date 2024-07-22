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
                        .padding(.bottom, 60)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            if let type = vm.notificationType {
                VStack {
                    NotificationView(type: type) {
                        vm.notificationType = nil
                    }
                    Spacer()
                }
            }
        }
    }
    
    
    var titleView: some View {
        HStack {
            CustomTitleView(title: "Yeni sorğu") {
                router.navigate { NewQueryInfoView() }
            }
        }
    }
    
    var textFieldView: some View {
        VStack {
            CustomTextField(placeholder: "Ünvanı daxil edin", title: "Problemin baş verdiyi yer", text: $vm.addressText, errorMessage: .constant(""), clickableText: Constants.howToRequestShare, clickableTextWidth: 116)
        }
    }
    
    var pickerView: some View {
        
        VStack(spacing: 16) {
            CustomPickerView(selection: $vm.selectedOrganization, title: "Problemin yönləndiriləcəyi qurum", isRightTextEditor: $vm.isRightTextEditor) {
                ForEach(vm.organizations, id: \.self) { organization in
                    Text(organization.name ?? "")
                        .tag(organization.id)
                }
            }
            
            CustomPickerView(selection: $vm.selectedCategory, title: "Kategoriya", isRightTextEditor: $vm.isRightTextEditor) {
                ForEach(vm.categories, id: \.self) { category in
                    Text(category.name ?? "")
                        .tag(category.categoryID)
                }
            }
            
        }
    }
    
    
    var buttonView: some View {
        VStack(spacing: 16) {
            CustomButton(style: .rounded, title: "Paylaş", color: .primaryBlue) {
                vm.createNewQuery()
            }
            
            CustomButton(style: .rounded, title: "Sıfırla", color: .white, foregroundStyle: .primaryBlue) {
                vm.cleanFields()
            }
            .disabled((!vm.addressText.isEmpty || !vm.explanationEditorText.isEmpty) ? false : true)
            .opacity((!vm.addressText.isEmpty || !vm.explanationEditorText.isEmpty) ? 1 : 0.5)
        }
    }
    
    var textView: some View {
        CustomTextEditor(title: "Ətraflı izah", errorText: "Min:10-Max:500 simvol", explanation: $vm.explanationEditorText, isRightTextField: $vm.isRightTextEditor)
    }
}

#Preview {
    NewQueryView()
}

