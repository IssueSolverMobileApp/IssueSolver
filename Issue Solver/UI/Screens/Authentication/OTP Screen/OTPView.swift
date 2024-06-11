//
//  OTPView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 11.06.24.
//

import SwiftUI

struct OTPView: View {
    
    var body: some View {
        
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            
            VStack {
                Text("E-poçtunuza gələn təsdiq kodunu daxil edin.")
                    .foregroundColor(.gray)
                    .padding(.vertical,38)
                
                OTPTextField(numberOfFields: 6)
                    .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    OTPView()
}
