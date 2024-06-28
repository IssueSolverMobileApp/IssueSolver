//
//  TextView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 24.06.24.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    let text: String
    var clickableTexts: [[String: String]]? /// - Use this when you want to make texts clickable;
    var completion: (() -> Void)?
    var uiFont: UIFont
    var isScrollEnabled: Bool = true
    
    
    func makeUIView(context: Context) -> some UIView {
        let textView = UITextView()
        textView.text = text
        textView.font = uiFont
        textView.isScrollEnabled = isScrollEnabled
        textView.backgroundColor = .clear
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        // Link Attributes
        textView.attributedText = setAttributesToText()
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.primaryBlue,
            .font: uiFont
        ]
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    // MARK: - Private Functions
    
    private func setAttributesToText() -> NSAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self.text)
        
        if let clickableTexts {
            for clikableText in clickableTexts {
                let linkRange = attributedString.mutableString.range(of: clikableText.keys.first ?? "")
                print()
                attributedString.setAttributes([.link: clikableText.values.first ?? ""], range: linkRange)
            }
        }
        
        return attributedString
    }
}
