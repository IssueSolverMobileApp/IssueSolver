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
    @State private var selectedGov: String = "Kategoriya"
    
    private var gov: [String] = [
        "Innovasiya ve Reqemsal Inkisaf Agentliyi",
        "Innovasiya ve Reqemsal Inkisaf ",
        "Innovasiya ve Reqemsal ",
        "Innovasiya ve",
    ]
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()

            VStack {
                titleView
                textFieldView
                pickerView
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
        
        VStack(alignment: .leading) {
            
            HStack {
                
                Text("Problemin yönləndiriləcəyi qurum")
                    .jakartaFont(.heading)
                Spacer()
            }
            HStack {
                Spacer()
                Picker("", selection: $selectedGov) {
                    ForEach(gov, id: \.self) { item in
                        Text(item)
                    }
                }
//                .selectio
                .padding([.bottom, .top], 8)
                Spacer()
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 8))
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
}

#Preview {
    NewRequestView()
}
