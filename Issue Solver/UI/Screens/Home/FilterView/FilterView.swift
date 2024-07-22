//
//  FilterView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 22.07.24.
//

import SwiftUI

struct FilterView: View {
    
    @StateObject var vm = HomeViewModel()
    @State var isRightTextEditor: Bool = true
    @State private var categoryPicker: String = ""
    @State var selectedGov: personModel = personModel(name: "Innovasiya ve Reqemsal Inkisaf Agentliyi")

    private var governments: [personModel] = [
        personModel(name: "Innovasiya ve Reqemsal Inkisaf Agentliyi"),
        personModel(name: "Innovasiya ve Reqemsal Inkisaf "),
        personModel(name: "Innovasiya ve Reqemsal "),
        personModel(name: "Innovasiya ve Reqemsal Inkisaf Agentliyi")
    ]
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
                VStack(spacing: 20) {
                    titleView
                ScrollView {
                    pickerView
                    buttonView
                }
            }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
        }
    }
    
    var titleView: some View {
        HStack {
            CustomTitleView(title: "Filter")
        }
    }
    
    var pickerView: some View {
        
        VStack(spacing: 24) {
            CustomPickerView(selectedGov: $selectedGov, items: governments, title: "Problemin yönləndiriləcəyi qurum", placeholder: "Qurum", isRightTextEditor: $isRightTextEditor)
            
            CustomPickerView(selectedGov: $selectedGov, items: governments, title: "Problemin Kateqoriyası", placeholder: "Kategoriya", isRightTextEditor: $isRightTextEditor)
            
            CustomPickerView(selectedGov: $selectedGov, items: governments, title: "Problemin statusu", placeholder: "Status", isRightTextEditor: $isRightTextEditor)
            
            CustomPickerView(selectedGov: $selectedGov, items: governments, title: "Problemin paylaşılma tarixi", placeholder: "Tarix", isRightTextEditor: $isRightTextEditor)
            
        }
    }
    
    
    var buttonView: some View {
            CustomButton(style: .rounded, title: "Tətbiq et", color: .primaryBlue) {
                //  MARK: Paylaş button action must be here
            }
        }
    }

#Preview {
    FilterView()
}
