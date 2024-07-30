//
//  Constants.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev 2 on 11.06.24.
//

import SwiftUI

class Constants {
    
    // MARK: - Strings
    
    /// - Clickable texts and their URL strings
    static let termsOfUse: [String: String] = ["Şərtlər və qaydaları": "https://my.gov.az"]
    static let howToRequestShare: [String: String] = ["Sorğu necə paylaşılır?": "https://youtu.be/aCYCtvndvNU?si=bTpUzJ9c6rhKJ6Ft"]
    
    // MARK: - Numbers
    
    static let cornerRadius: CGFloat = 12
    static let numberOfOTPFields: Int = 6
    
    // MARK: - Colors
    
    /// - Parameters:
    ///  - backgroundColor: Background color of the view
    ///  - uiBackgroundColor: Same as 'backgroundColor', but color type is UIColor
    static let backgroundColor: Color = Color.surfaceBackground
    static let uiBackgroundColor: UIColor = UIColor.surfaceBackground
    
}
