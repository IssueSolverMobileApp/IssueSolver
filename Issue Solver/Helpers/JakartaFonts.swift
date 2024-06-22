//
//  JakartaFonts.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 14.06.24.
//

import Foundation

enum JakartaFonts {
    case title
    case title2
    case subtitle
    case subtitle2
    case heading
    case subheading
    case roundedButton
    case textButton
    case rowTitle
    case custom(JakartaFont, CGFloat)
}

enum JakartaFont: String {
    case bold = "PlusJakartaSans-Bold"
    case semiBold = "PlusJakartaSans-SemiBold"
    case extraBold = "PlusJakartaSans-ExtraBold"
    case light = "PlusJakartaSans-Light"
    case regular = "PlusJakartaSans-Regular"
    case medium = "PlusJakartaSans-Medium"
    
    var font: String {
        return self.rawValue
    }
}
