//
//  OTPTextField.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 11.06.24.
//

import SwiftUI

struct OTPTextField: View {
    
    let numberOfFields: Int
    
    @State var enterValue: [String]
    @FocusState private var fieldFocus: Int?
    
    init(numberOfFields: Int) {
        self.numberOfFields = numberOfFields
        self.enterValue =  Array(repeating: "", count: numberOfFields)
    }
    
    var body: some View {
  
        
        HStack {
            ForEach(0..<numberOfFields, id: \.self) { index in
                if index > 0 && index % 3 == 0 {
                    Image("line")
                }
                TextField("", text: $enterValue[index])
                .keyboardType(.numberPad)
                .foregroundColor(.primaryBlue)
                .frame(width: 52, height: 65)
                .background(.white)
                .cornerRadius(12)
                .multilineTextAlignment(.center)
                .focused($fieldFocus, equals: index)
                //.tag(index)
                .onChange(of: enterValue[index]) { newValue in
                    if newValue.count > 1 {
                        enterValue[index] = String(enterValue[index].prefix(1))
                    }
                    
                    if !newValue.isEmpty && index < numberOfFields - 1 {
                            fieldFocus = index + 1
                        
                    } else if newValue.isEmpty && index > 0 {
                        fieldFocus = index - 1
                    }
                }
                .onTapGesture {
                       fieldFocus = index
                }
            }
        }
        .onAppear {
                fieldFocus = 0
            }
    }
}

#Preview {
    OTPTextField(numberOfFields: 6)
}
