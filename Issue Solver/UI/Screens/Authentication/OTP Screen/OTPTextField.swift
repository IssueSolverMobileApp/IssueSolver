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
    
    let completion: (String) -> Void
    
    init(numberOfFields: Int, completion: @escaping (String) -> Void) {
        self.numberOfFields = numberOfFields
        self.enterValue =  Array(repeating: "", count: numberOfFields)
        self.completion = completion
    }
    
    var body: some View {
  
        GeometryReader { geometry in
            
            HStack {
                ForEach(0..<numberOfFields, id: \.self) { index in
                    if index > 0 && index % 3 == 0 {
                        Image("line")
                    }
                    TextField("", text: $enterValue[index])
                        .keyboardType(.numberPad)
                        .foregroundColor(.primaryBlue)
                        .frame(width: (geometry.size.width - 62) / CGFloat(numberOfFields), height: 62)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(fieldFocus == index ? Color.blue : Color.white, lineWidth: 2)
                                .background(.white))
                        .cornerRadius(12)
                        .multilineTextAlignment(.center)
                        .focused($fieldFocus, equals: index)
                        .onChange(of: enterValue[index]) { newValue in
                            if newValue.count > 1 {
                                enterValue[index] = String(enterValue[index].suffix(1))
                            }
                            
                            if !newValue.isEmpty && index < numberOfFields - 1 {
                                fieldFocus = index + 1
                                
                            } else if newValue.isEmpty && index > 0 {
                                fieldFocus = index - 1
                            }
                            completion(creatString())
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
        .frame(height: 64)
    }
    
    func creatString() -> String {
        var newString: String = ""
        enterValue.forEach { result in
            newString.append(result)
        }
        
         return newString
    }
    
}

#Preview {
    OTPTextField(numberOfFields: 6) {code in}
}
