//
//  QueryCommentBottomSheetView.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct QueryCommentView: View {
    @State var txt: String = ""
    @State var height: CGFloat = 20
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.secondary)
                .frame(width: 30, height: 3)
                .padding(10)
            HStack {
                Text("Rəylər")
                    .jakartaFont(.rowTitle)
            }
            ScrollView {
                VStack(spacing: 12) {
                    CustomCommentRowView()
                    CustomCommentRowView()
                    CustomCommentRowView()
                }
            }
            
            HStack(spacing: 8) {
                ZStack {
                    ResizableTF(txt: $txt, height: $height)
                        .frame(height: height < 124 ? height : 124)
                        .padding(.vertical, 5)
                        .padding(.horizontal)
                        .background(.outLineContainerBlue)
                        .clipShape(.rect(cornerRadius: 24))
                        .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.primaryBlue.opacity(0.29)))
                }
                .padding(.leading)
                Button {
                    
                } label: {
                    Image(.sendCommentIcon)
                        .frame(width: 40, height: 40)

                }
                
                .background(.white)
                .clipShape(Circle())

            }
            .padding(.trailing,20)
            .padding(.bottom, 5)

        }
        .background(ignoresSafeAreaEdges: .bottom)
    }
}

struct ResizableTF: UIViewRepresentable {
    
    @Binding var txt: String
    @Binding var height: CGFloat
    
    func makeCoordinator() -> Coordinator {
        return ResizableTF.Coordinator(parent1: self)
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
        
        var parent: ResizableTF
        
        init(parent1: ResizableTF) {
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

  
#Preview {
    QueryCommentView()
}
