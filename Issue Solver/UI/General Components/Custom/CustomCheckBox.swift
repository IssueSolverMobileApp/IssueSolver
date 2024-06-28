//
//  CustomCheckBox.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 12.06.24.
//

import SwiftUI

struct CustomCheckBox: View {
    @Binding var isChecked: Bool
    var borderColor: Color
    let boxSize: CGSize = CGSize(width: 25, height: 25)
    
    
    var body: some View {
        Button {
            withAnimation {
                isChecked.toggle()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius/2)
                    .fill(Color(.systemBackground))
                if isChecked {
                    Image(systemName: "checkmark")
                }
            }
            .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius/2).stroke(borderColor, lineWidth: 1))
        }
        .frame(width: boxSize.width, height: boxSize.height)
    }
    
}
