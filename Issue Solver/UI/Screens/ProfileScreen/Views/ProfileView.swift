//
//  ProfileView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        
        NavigationView {
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
    }

    
    /// 1st section
    var firstSectionView: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            ///Profile View
                CustomRowView(title: "Irada Bakirli", subtitle: "iradebekirli@gmail.com", leftImage: "profile", rightImage: "settings",width: 48, height: 48,handler: {})
                    .frame(height: 86)
                
            ///Change Password View
            NavigationLink(destination: EmptyView()) {
                CustomRowView(title: "Şifrəni dəyiş", subtitle: nil, leftImage: "privacy", rightImage: nil,width: 38, height: 38, handler: {})
                    .frame(height: 86)
            }
        }
    }
        
   /// 2nd section

    var secondSectionView: some View {
        
        VStack(alignment: .leading, spacing: 12) {
        
        ///Privacy Policy View
            NavigationLink(destination: EmptyView()) {
                CustomRowView(title: "Məxfilik siyasəti", subtitle: nil, leftImage: nil, rightImage: nil, handler: {})
                    .frame(height: 76)
            }
        ///FAQ View
            NavigationLink(destination: EmptyView()) {
                CustomRowView(title: "Tez-tez verilən suallar", subtitle: nil, leftImage: nil, rightImage: nil, handler: {})
                    .frame(height: 76)
            }
        ///About App View
            NavigationLink(destination: EmptyView()) {
                CustomRowView(title: "Tətbiq haqqında", subtitle: nil, leftImage: nil, rightImage: nil, handler: {})
                    .frame(height: 76)
            }
        }
    }
    
    /// 3rd section
    
    var thirdSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            /// Exit View
            CustomRowView(title: "Hesabdan çıxış", subtitle: nil, leftImage: "exit", rightImage: nil, width: 38, height: 38 , handler: {})
                .frame(height: 86)
            
            /// Delete account View
            CustomRowView(title: "Hesabı sil", subtitle: nil, leftImage: nil, rightImage: nil, color: .red ,handler: {
                
            })
                .frame(height: 76)
                .onTapGesture {
                    vm.showDeleteAccountAlert = true
                }
            
                    .alert( isPresented: $vm.showDeleteAccountAlert) {
                        Alert(title: Text(""),
                              message: Text("Hesabınızı silmək istədiyinizə əminsiniz?"),
                              primaryButton: .destructive(Text("Bəli")) ,
                              secondaryButton: .default(Text("Xeyr")))
            }
        }
    }
}

#Preview {
    ProfileView()
}
