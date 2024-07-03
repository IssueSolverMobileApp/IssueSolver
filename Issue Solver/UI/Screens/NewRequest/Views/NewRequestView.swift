//
//  NewRequestView.swift
//  Issue Solver
//
//  Created by ValehAmirov on 01.07.24.
//

import SwiftUI

struct NewRequestView: View {
    
    @StateObject var vm = NewReqeuestViewModel()
    
    @State private var addressText: String = ""
    @State private var categoryPicker: String = ""
    @State var selectedGov: personModel = personModel(name: "Innovasiya ve Reqemsal Inkisaf Agentliyi")
        
    @State var isRightTextEditor: Bool = true

    
    @State var explanation: String = ""

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
    
    
    private var titleView: some View {
        HStack {
            CustomTitleView(title: "Yeni sorğu", image: .infoIcon) {
//          MARK: - navigation action must be here
            }
        }
    }
    
    private var textFieldView: some View {
        VStack {
            CustomTextField(placeholder: "Ünvanı daxil edin", title: "Problemin baş verdiyi yer", text: $addressText, errorMessage: $vm.errorMessage, clickableText: Constants.howToRequestShare, clickableTextWidth: 116)
            
        
        }
    }
    
    private var pickerView: some View {
        
        VStack(spacing: 16) {
            CustomPickerView(selectedGov: $selectedGov, items: governments, title: "Problemin yönləndiriləcəyi qurum", placeholder: "Qurum", isRightTextEditor: $isRightTextEditor)
            
            CustomPickerView(selectedGov: $selectedGov, items: governments, title: "Kategoriya", placeholder: "Kategoriya", isRightTextEditor: $isRightTextEditor)
        }
    }
    
    
    private var buttonView: some View {
        VStack(spacing: 16) {
            CustomButton(style: .rounded, title: "Paylaş", color: .primaryBlue) {
            }
            
            CustomButton(style: .rounded, title: "Ləğv et", color: .white, foregroundStyle: .primaryBlue) {
            }
        }
    }
    
    private var textView: some View {
        
        CustomTextEditor(title: "Ətraflı izah", explanation: $explanation, isRightTextField: $isRightTextEditor)
    }
}

#Preview {
    NewRequestView()
}
