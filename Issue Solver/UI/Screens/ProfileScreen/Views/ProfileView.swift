//
//  ProfileView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
            ZStack {
                Color.surfaceBackground.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 48) {
                    firstSectionView
                    secondSectionView
                    thirdSection
                    Spacer()
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 16)
            }
        }
    }
    
    /// 1st section
    var firstSectionView: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            ///Profile View
            CustomRowView(title: "Irada Bakirli", subtitle: "iradebekirli@gmail.com", leftImage: "profile", rightImage: "settings", handler: {})
                .frame(height: 86)
            
            ///Change Password View
            CustomRowView(title: "Şifrəni dəyiş", subtitle: nil, leftImage: "privacy", rightImage: nil, handler: {})
                .frame(height: 86)
        }
    }
        
   /// 2nd section

    var secondSectionView: some View {
        
        VStack(alignment: .leading, spacing: 12) {
        
        ///Privacy Policy View
            CustomRowView(title: "Məxfilik siyasəti", subtitle: nil, leftImage: nil, rightImage: nil, handler: {})
                .frame(height: 76)
            
        ///FAQ View
            CustomRowView(title: "Tez-tez verilən suallar", subtitle: nil, leftImage: nil, rightImage: nil, handler: {})
                .frame(height: 76)
        
        ///About App View
            CustomRowView(title: "Tətbiq haqqında", subtitle: nil, leftImage: nil, rightImage: nil, handler: {})
                .frame(height: 76)
        }
    }
    
    /// 3rd section
    
    var thirdSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            /// Exit View
            CustomRowView(title: "Hesabdan çıxış", subtitle: nil, leftImage: "exit", rightImage: nil, handler: {})
                .frame(height: 86)
            
            /// Delete account View
            CustomRowView(title: "Hesabı sil", subtitle: nil, leftImage: nil, rightImage: nil, handler: {})
                .frame(height: 86)
        }
    }
}

#Preview {
    ProfileView()
}
