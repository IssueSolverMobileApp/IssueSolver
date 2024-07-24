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
                VStack {
                    titleView
                    textFieldView
                }
                .padding()
                
                VStack(spacing: 20) {
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
            CustomTitleView(title: "Yeni sorğu") {
                router.navigate { NewQueryInfoView() }
            }
        }
    }
    
    var textFieldView: some View {
        VStack(alignment: .leading) {
            CustomTextField(placeholder: "Ünvanı daxil edin", title: "Problemin baş verdiyi yer", text: $vm.addressText, errorMessage: .constant(""))
            HStack {
                TextView(clickableTexts:  [Constants.howToRequestShare], uiFont: UIFont.jakartaFont(weight: .regular, size: 12)!, isScrollEnabled: false)
                Spacer()
                Text("Max: 50 simvol")
                    .font(.jakartaFont(weight: .regular, size: 12))
            }
            .padding(.trailing)
        }
    }
    
    var pickerView: some View {
        
        VStack(spacing: 16) {
            
            
            CustomPickerView(selection: $vm.selectedCategory, title: "Kategoriya", isRightTextEditor: .constant(true)) {
                ForEach(vm.categories, id: \.self) { category in
                    Text(category.name ?? "")
                        .tag(category.categoryID)
                }
            }
            
            CustomPickerView(selection: $vm.selectedOrganization, title: "Problemin yönləndiriləcəyi qurum", isRightTextEditor: .constant(true)) {
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
                vm.createNewQuery()
            }
            
            CustomButton(style: .rounded, title: "Sıfırla", color: .white, foregroundStyle: .primaryBlue) {
                vm.isResetPressed = true
            }
            .disabled((!vm.addressText.isEmpty || !vm.explanationEditorText.isEmpty) ? false : true)
            .opacity((!vm.addressText.isEmpty || !vm.explanationEditorText.isEmpty) ? 1 : 0.5)
        }
    }
    
    var textView: some View {
        CustomTextEditor(title: "Ətraflı izah", errorText: "Min:10-Max:500 simvol", explanation: $vm.explanationEditorText, isRightTextField: .constant(true))
    }
}

#Preview {
    NewQueryView()
}

