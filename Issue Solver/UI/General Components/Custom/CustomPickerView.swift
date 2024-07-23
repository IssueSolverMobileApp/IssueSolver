//
//  CustomPickerView.swift
//  Issue Solver
//
//  Created by ValehAmirov on 02.07.24.
//

import SwiftUI

struct CustomPickerView<V, C>: View where V : SelectionProtocol, C : View {
    
    @Binding var selection: V
    var title: String?
    var textColor: Color?
    @Binding var isRightTextEditor: Bool
    var onPickerTapped: (() -> Void)?
    
    @ViewBuilder var view: () -> C
    
    init(selection: Binding<V>, title: String? = nil, textColor: Color? = nil, isRightTextEditor: Binding<Bool>,onPickerTapped: (() -> Void)? = nil, @ViewBuilder view: @escaping () -> C) {
        self._selection = selection
        self.title = title
        self.textColor = textColor
        self._isRightTextEditor = isRightTextEditor
        self.onPickerTapped = onPickerTapped
        self.view = view
    }
    
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
                        Text(selection.name ?? "")
                            .jakartaFont(.custom(.light, 14))
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        Image(.arrowDownIcon)
                    }
                }
                .padding([.bottom, .top])
                .onTapGesture {
                    onPickerTapped?() 
                }
                Spacer()
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 12))
        }
    }
}
