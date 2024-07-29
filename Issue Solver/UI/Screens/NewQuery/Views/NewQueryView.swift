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
    @Binding var notificationType: NotificationType?
    @FocusState var isInputActive: Bool
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            ScrollView {
                titleView
                .padding(.horizontal)
                
                VStack(spacing: 20) {
                    textFieldView
                    pickerView
                    textView
                    buttonView
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            .onAppear {
                UIScrollView.appearance().keyboardDismissMode = .interactive
            }
            
        }
        .alert(
            isPresented: $vm.isResetPressed,
            content: {
                Alert(
                    title: Text("Sorğunuzu ləğv etməyə əminsiniz?"),
                    primaryButton: .default(Text("Bəli"), action: { vm.cleanFields() }),
                    secondaryButton: .cancel({
                        vm.isResetPressed = false
                    })
                )
            }
        )
        
    }
    
    
    var titleView: some View {
        HStack {
            CustomTitleView(title: "Yeni sorğu", subtitle: "Xahiş olunur, sorğu üçün məlumatları daxil edin", image1: .infoIcon) {
                router.navigate { NewQueryInfoView() }
            }
        }
    }
    
    var textFieldView: some View {
        VStack(alignment: .leading) {
            CustomTextField(placeholder: "Ünvanı daxil edin", title: "Problemin baş verdiyi yer", text: $vm.addressText, isRightTextField: $vm.isRightAddress, errorMessage: $vm.addressTextFieldError)
                .focused($isInputActive)
            HStack {
                TextView(clickableTexts:  [Constants.howToRequestShare], uiFont: UIFont.jakartaFont(weight: .regular, size: 12)!, isScrollEnabled: false)
                Spacer()
                Text("Max: 50 simvol")
                    .font(.jakartaFont(weight: .regular, size: 12))
            }
            
        }
    }
    
    var pickerView: some View {
        
        VStack(spacing: 16) {
            CustomPickerView(selection: $vm.selectedCategory, title: "Kateqoriya", textColor: vm.selectedCategory.name == "Kateqoriya" ? .gray : .black, isRightTextEditor: $vm.isRightCategory) {
                ForEach(vm.categories, id: \.self) { category in
                    Text(category.name ?? "")
                        .tag(category.categoryID)
                }
            }
            
            CustomPickerView(selection: $vm.selectedOrganization, title: "Problemin yönləndiriləcəyi qurum", textColor: vm.selectedOrganization.name == "Qurum" ? .gray : .black, isRightTextEditor: $vm.isRightOrganization) {
                if vm.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    ForEach(vm.organizations, id: \.self) { organization in
                        Text(organization.name ?? "")
                            .tag(organization.id)
                    }
                }
            }
            
        }
    }
    
    
    var buttonView: some View {
        VStack(spacing: 16) {
            CustomButton(style: .rounded, title: "Paylaş", color: .primaryBlue) {
                vm.createNewQuery { success, error  in
                    if let success {
                        self.notificationType = .success(success)
                    } else if let error {
                        self.notificationType = .error(error)
                    }
                }
            }
            .disabled((vm.addressText.isEmpty || vm.explanationEditorText.isEmpty || !vm.isRightAddress || !vm.isRightExplanation) ? true : false)
            .opacity((vm.addressText.isEmpty || vm.explanationEditorText.isEmpty || !vm.isRightAddress || !vm.isRightExplanation) ? 0.5 : 1)
            
            CustomButton(style: .rounded, title: "Sıfırla", color: .white, foregroundStyle: .primaryBlue) {
                vm.isResetPressed = true
            }
            .disabled((!vm.addressText.isEmpty || !vm.explanationEditorText.isEmpty || !vm.isRightAddress || !vm.isRightExplanation) ? false : true)
            .opacity((!vm.addressText.isEmpty || !vm.explanationEditorText.isEmpty) ? 1 : 0.5)
        }
    }
    
    var textView: some View {
        CustomTextEditor(title: "Ətraflı izah", errorText: vm.textEditorError, explanation: $vm.explanationEditorText, isRightTextField: $vm.isRightExplanation)
    }
}

