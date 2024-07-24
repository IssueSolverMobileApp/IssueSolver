//
//  CustomFilterRowView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 22.07.24.
//

import SwiftUI

struct CustomFilterRowView: View {
    
    @State private var showingBottomSheet = false
    
    let title: String
    let subtitle: String
    let rightImage: String
    
    var width: CGFloat?
    var height: CGFloat?
    var color: Color = .black
    var font: JakartaFonts?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            titleView
            ZStack {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color(.white))
                    .frame(height: 56)
                
                HStack (spacing: 12) {
                    subtitleView
                    Spacer()
                    rightImageView
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
            }
            .frame(height: height)
            .onTapGesture {
                showingBottomSheet = true
            }
            .sheet(isPresented: $showingBottomSheet) {
                Text("This app was brought to you by Hacking with Swift")
        }
        }
    }
   
    
    ///  Title View
    var titleView: some View {
                Text(title)
                    .jakartaFont(.subtitle)
                    .foregroundStyle(.black)
        }
    ///  Title Subtitle View
    var subtitleView: some View {
                Text(subtitle)
                    .jakartaFont(.subtitle)
                    .foregroundStyle(.secondaryGray)
        }
    
    /// RightImageView
    var rightImageView: some View {
        Image(rightImage)
            .frame(width: width, height: height)
        }
    }

#Preview {
    CustomFilterRowView(title: "salam", subtitle: "salam", rightImage: "eye")
}
