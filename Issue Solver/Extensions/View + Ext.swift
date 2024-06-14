//
//  View + Ext.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 14.06.24.
//

import SwiftUI

extension View {
    /// - We will create ready-to-use fonts which similar to Apple fonts (e.g. title, title2, title3, callout and etc.)
    func jakartaFont(_ fonts: JakartaFonts) -> some View {
        switch fonts {
        // Title
        case .title:
            return self.font(.jakartaFont(weight: .semiBold, size: 28))
        // Title2
        case .title2:
            return self.font(.jakartaFont(weight: .semiBold, size: 20))
        // Subtitle
        case .subtitle:
            return self.font(.jakartaFont(weight: .regular, size: 15))
        // Subtitle2
        case .subtitle2:
            return self.font(.jakartaFont(weight: .regular, size: 13))
        // Heading
        case .heading:
            return self.font(.jakartaFont(weight: .regular, size: 15))
        // Subheading
        case .subheading:
            return self.font(.jakartaFont(weight: .regular, size: 13))
        // Rounded Button
        case .roundedButton:
            return self.font(.jakartaFont(weight: .medium, size: 18))
        // Text Button
        case .textButton:
            return self.font(.jakartaFont(weight: .medium, size: 15))
        // If these ready-to-use are not enough, we can use custom font
        case .custom(let weight, let size):
            return self.font(.jakartaFont(weight: weight, size: size))
        }
    }
    
}
