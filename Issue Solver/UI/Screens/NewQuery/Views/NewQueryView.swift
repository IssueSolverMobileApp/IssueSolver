//
//  NewRequestView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 01.07.24.
// 

import SwiftUI

struct NewQueryView: View {
    
    @StateObject var vm = NewQueryViewModel()
    @EnvironmentObject var router: Router
    
    @State private var addressText: String = ""
    @State private var categoryPicker: String = ""
    @State var selectedGov: personModel = personModel(name: "Innovasiya ve Reqemsal Inkisaf Agentliyi")
        
    @State var isRightTextEditor: Bool = true
    @State var explanationEditorText: String = ""

    private var governments: [personModel] = [
        personModel(name: "Innovasiya ve Reqemsal Inkisaf Agentliyi"),
        personModel(name: "Innovasiya ve Reqemsal Inkisaf "),
        personModel(name: "Innovasiya ve Reqemsal "),
        personModel(name: "Innovasiya ve Reqemsal Inkisaf Agentliyi")
    ]
    
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
            CustomTitleView(title: "Yeni sorğu", image1: .infoIcon) {
//          MARK: - navigation action must be here
                router.navigate { NewQueryInfoView() }
            }
        }
    }
    
    var textFieldView: some View {
        VStack {
            CustomTextField(placeholder: "Ünvanı daxil edin", title: "Problemin baş verdiyi yer", text: $addressText, errorMessage: $vm.errorMessage, clickableText: Constants.howToRequestShare, clickableTextWidth: 116)
        }
    }
    
    var pickerView: some View {
        
        VStack(spacing: 16) {
            CustomPickerView(selectedGov: $selectedGov, items: governments, title: "Problemin yönləndiriləcəyi qurum", placeholder: "Qurum", isRightTextEditor: $isRightTextEditor)
            
            CustomPickerView(selectedGov: $selectedGov, items: governments, title: "Kategoriya", placeholder: "Kategoriya", isRightTextEditor: $isRightTextEditor)
        }
    }
    
    
    var buttonView: some View {
        VStack(spacing: 16) {
            CustomButton(style: .rounded, title: "Paylaş", color: .primaryBlue) {
                //  MARK: Paylaş button action must be here
            }
            
            CustomButton(style: .rounded, title: "Sıfırla", color: .white, foregroundStyle: .primaryBlue) {
                //  MARK: sıfırla button action must be here
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
