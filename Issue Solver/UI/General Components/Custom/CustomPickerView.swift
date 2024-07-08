//
//  CustomPickerView.swift
//  Issue Solver
//
//  Created by ValehAmirov on 02.07.24.
//

import SwiftUI


struct CustomPickerView<V, C>: View where V : Codable, V : Hashable, C : View{
    
    @Binding var selection: V
    @State var selectedTitle: String
    var title: String?
    var textColor: Color?
    @Binding var isRightTextEditor: Bool
    
    @ViewBuilder var view: () -> C
    
    var body: some View {

        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .jakartaFont(.heading)
                    .foregroundStyle(isRightTextEditor ? (textColor ?? .black) :  .red)
                
            }
            
            HStack {
                Spacer()
                
                Menu {
                    Picker("reminderFrequency", selection: $selection) {
                        view()
                    }
                } label: {
                    HStack {
                        Text(selectedTitle)
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
