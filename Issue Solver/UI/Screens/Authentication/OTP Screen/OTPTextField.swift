//
//  OTPTextField.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 11.06.24.
//

import SwiftUI

struct OTPTextField: View {
    
    @Binding var enteredValue: [String]
    @Binding var isError: Bool
    
    @FocusState private var fieldFocus: Int?
    
    init(enteredValue: Binding<[String]>, isError: Binding<Bool>) {
        self._enteredValue = enteredValue
        self._isError = isError
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                ForEach(0..<enteredValue.count, id: \.self) { index in
                    if index > 0 && index % 3 == 0 {
                        Image(.line)
                    }
                    textFieldView(index: index, proxy: proxy)
                        .multilineTextAlignment(.center)
                        .focused($fieldFocus, equals: index)
                        .onChange(of: enteredValue[index]) { newValue in
                            print("------ DEBUG: newValue ------")
                            print(newValue)
                            if newValue.count > 1 {
                                enteredValue[index] = String(enteredValue[index].suffix(1))
                            }
                            
                            if !newValue.isEmpty && index < enteredValue.count - 1 {
                                fieldFocus = index + 1
                            } else if newValue.isEmpty && index > 0 {
                                fieldFocus = index - 1
                            } else if newValue.count < 1 {
                                fieldFocus = index - 1
                            }
                            
                            isError = false
                        }
                        .onTapGesture {
                            fieldFocus = index
                        }
                    
                }
                .onAppear {
                    fieldFocus = 0
                }
            }
        }
        .frame(height: 64)
    }
    
    // MARK: - Views
    
    func textFieldView(index: Int, proxy: GeometryProxy) -> some View {
        TextField("", text: $enteredValue[index])
            .keyboardType(.numberPad)
            .foregroundStyle(isError ? Color.red : .primaryBlue)
            .frame(width: (proxy.size.width - 62) / CGFloat(enteredValue.count), height: 62)
            .background(
                RoundedRectangle(cornerRadius: 12)
                            // ------- 1 -------    -------------------- 2 ------------------
                    .stroke( isError ? Color.red : (fieldFocus == index ? Color.blue : Color.white), lineWidth: 2)
                    .background(isError ? Color.red.opacity(0.1) : .white))
            .cornerRadius(12)
        
    }
    
}

