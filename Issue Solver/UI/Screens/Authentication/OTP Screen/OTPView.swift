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
            
            VStack(alignment: .leading, spacing: 28) {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Təsdiq Kodu")
                        .font(.system(size: 28))
                        .bold()
                    Text("E-poçtunuza gələn təsdiq kodunu daxil edin.")
                        .foregroundColor(.gray)
                }
                
                OTPTextField(numberOfFields: 6)
                
                HStack {
                    Text("Qalan vaxt:")
                        .foregroundStyle(.primaryBlue)
                        .font(.system(size: 17))
                    TimerView()
                }
                Spacer()
            }
            .padding(.top, 64)
            .padding(.trailing, 20)
            .padding(.leading, 20)
       
            
            
            VStack() {
                Spacer()
                CustomButton(title: "Təsdiqlə") {
                    // code here
                }
                
                Text ("Kodu yenidən göndər")
                    .foregroundStyle(.primaryBlue)
            }
            .padding(.trailing, 20)
            .padding(.leading, 20)
            .padding(.bottom, 20)
            
        }
    }
}

#Preview {
    OTPView()
}
