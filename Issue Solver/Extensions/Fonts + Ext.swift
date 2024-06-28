//
//  Fonts + Ext.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 13.06.24.
//

import SwiftUI
import UIKit

extension Font {
    static func jakartaFont(weight: JakartaFont, size: CGFloat) -> Font {
        return Font.custom(weight.rawValue, size: size)
    }
}

extension UIFont {
    static func jakartaFont(weight: JakartaFont, size: CGFloat) -> UIFont? {
        return UIFont(name: weight.rawValue, size: size)
    }
}
