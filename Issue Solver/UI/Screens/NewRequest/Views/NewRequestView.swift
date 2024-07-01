//
//  NewRequestView.swift
//  Issue Solver
//
//  Created by ValehAmirov on 01.07.24.
//

import SwiftUI

struct NewRequestView: View {
    @State private var addressText: String = ""
    
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()

            VStack {
                titleView
                textFieldView
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    }
    
    
     private var titleView: some View {
         HStack(alignment:.top) {
             CustomTitleView(title: "Yeni sorğu", image: .infoIcon)
         }
    }
    
    private var textFieldView: some View {
        VStack {
            CustomTextField(placeholder: "Ünvanı daxil edin", title: "Problemin baş verdiyi yer", text: $addressText)
            TextView(clickableTexts: [Constants.howToRequestShare], uiFont: UIFont.jakartaFont(weight: .regular, size: 12)!, isScrollEnabled: false)
        }
    }
}

#Preview {
    NewRequestView()
}
