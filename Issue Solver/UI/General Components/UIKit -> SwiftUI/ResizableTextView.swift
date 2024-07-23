//
//  ResizableTextView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 23.07.24.
//

import SwiftUI

struct ResizableTextView: UIViewRepresentable {
    
    @Binding var txt: String
    @Binding var height: CGFloat
    
    func makeCoordinator() -> Coordinator {
        return ResizableTextView.Coordinator(parent1: self)
    }
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isEditable = true
        view.isScrollEnabled = true
        view.text = "Rəyinizi daxil edin"
        view.font = .systemFont(ofSize: 18)
        view.textColor = .secondaryContainerBlue
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: ResizableTextView
        
        init(parent1: ResizableTextView) {
            self.parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if self.parent.txt == "" {
                textView.text = ""
                textView.textColor = .black
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.txt = textView.text
            }
        }
    }
}
