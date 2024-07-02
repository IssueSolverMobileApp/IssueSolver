//
//  CustomPickerView.swift
//  Issue Solver
//
//  Created by ValehAmirov on 02.07.24.
//

import SwiftUI

struct personModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    
}
struct CustomPickerView: View {
    
//    @State private var categoryPicker: String = ""
    @Binding var selectedGov: personModel
    var items: [personModel]?
    var title: String
    var placeholder: String
    
    
    var body: some View {

        VStack(alignment: .leading) {
            
            HStack {
                Text(title)
                    .jakartaFont(.heading)
                Spacer()
            }
            HStack {
                Spacer()
                
                Menu {
                    Picker("reminderFrequency", selection: $selectedGov) {
                        ForEach(items ?? []) { item in
                            Text(item.name)
                                .tag(item)
                        }
                    }
                    
                } label: {
                    HStack {
                        Text(selectedGov.name)
                            .jakartaFont(.custom(.light, 14))
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        Image(.arrowDownIcon)
                    }
                }
                .padding([.bottom, .top])
                Spacer()
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 12))
        }
    }
}

//#Preview {
//    CustomPickerView(selectedGov: "")
//}
