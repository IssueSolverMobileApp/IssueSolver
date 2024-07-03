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
    
    @Binding var selectedGov: personModel
    var items: [personModel]?
    var title: String?
    var placeholder: String
    var textColor: Color?
    @Binding var isRightTextEditor: Bool

    
    var body: some View {

        VStack(alignment: .leading) {
            
            HStack {
                if let title {
                    Text(title)
                        .jakartaFont(.heading)
                        .foregroundStyle(isRightTextEditor ? (textColor ?? .black) :  .red)
                    Spacer()
                }
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
