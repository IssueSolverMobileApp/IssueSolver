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
            
            VStack {
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
    
    
    private var titleView: some View {
        HStack {
            CustomTitleView(title: "Yeni sorğu", image: .infoIcon)
        }
    }
    
    private var textFieldView: some View {
        VStack {
            CustomTextField(placeholder: "Ünvanı daxil edin", title: "Problemin baş verdiyi yer", text: $addressText, errorMessage: $vm.errorMessage)
            HStack {
                Spacer()
                ZStack {
                    TextView(clickableTexts: [Constants.howToRequestShare], uiFont: UIFont.jakartaFont(weight: .regular, size: 12)!, isScrollEnabled: false)
                        .background(Color.red)
                }
                .frame(width: 120,height: 30)
            }
        }
    }
    
    private var pickerView: some View {
        
        VStack(spacing: 20) {
            CustomPickerView(selectedGov: $selectedGov, items: governments, title: "Problemin yönləndiriləcəyi qurum", placeholder: "Qurum")
            
            CustomPickerView(selectedGov: $selectedGov, items: governments, title: "Kategoriya", placeholder: "Kategoriya")
        }
    }
    
    
    private var buttonView: some View {
        VStack {
            CustomButton(style: .rounded, title: "Paylaş", color: .primaryBlue) {
            }
            
            CustomButton(style: .rounded, title: "Ləğv et", color: .white, foregroundStyle: .primaryBlue) {
            }
        }
    }
    
    private var textView: some View {
        
        ZStack {
            ZStack {
                TextEditor(text: $explanation)
                
                VStack {
                    HStack {
                        Text(explanation == "" ? "Problem haqqında ətraflı məlumat daxil edin" : "" )
                            .foregroundStyle(explanation == "" ? Color.gray : Color.black)
                        
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.leading, 8)
                .padding(.top, 8)
            }
            
            .padding(3)
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    NewRequestView()
}
