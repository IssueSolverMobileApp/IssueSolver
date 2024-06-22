//
//  ProfileView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm = ProfileViewModel()
    @State private var navigateToDeleteAccountView = false
    @State private var navigateToMyAccountView = false
    
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
            CustomRowView(title: "IRADA BAKIRLI", 
                          subtitle: "iradebekirli@gmail.com",
                          leftImage: "profile",
                          rightImage: "settings",
                          width: 48, height: 48,
                          color: .primaryBlue ,
                          font: .custom(.bold, 20),
                          handler: { navigateToMyAccountView = true })

             .frame(height: 86)
             NavigationLink(
                destination: MyAccountView(),
                isActive: $navigateToMyAccountView,
                label: { EmptyView() })
            
            ///Change Password View
            NavigationLink(destination: NewPasswordView()) {
                CustomRowView(title: "Şifrəni dəyiş", 
                              subtitle: nil,
                              leftImage: "privacy",
                              rightImage: "chevron",
                              width: 38, height: 38, 
                              handler: {})
                    .frame(height: 86)
            }
        }
    }
        
    
   /// 2nd section
    var secondSectionView: some View {
        
        VStack(alignment: .leading, spacing: 12) {
        
        ///Privacy Policy View
            NavigationLink(destination: EmptyView()) {
                CustomRowView(title: "Məxfilik siyasəti", 
                              subtitle: nil,
                              leftImage: nil,
                              rightImage: "chevron",
                              handler: {})
                    .frame(height: 76)
            }
        ///FAQ View
            NavigationLink(destination: EmptyView()) {
                CustomRowView(title: "Tez-tez verilən suallar", 
                              subtitle: nil,
                              leftImage: nil,
                              rightImage: "chevron",
                              handler: {})
                    .frame(height: 76)
            }
        ///About App View
            NavigationLink(destination: EmptyView()) {
                CustomRowView(title: "Tətbiq haqqında", 
                              subtitle: nil,
                              leftImage: nil,
                              rightImage: "chevron",
                              handler: {})
                    .frame(height: 76)
            }
        }
    }
    
    /// 3rd section
    var thirdSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            /// Exit View
            CustomRowView(title: "Hesabdan çıxış", 
                          subtitle: nil,
                          leftImage: "exit",
                          rightImage: "chevron",
                          width: 38, height: 38 , handler: {})
                .frame(height: 86)
            
                .onTapGesture {
                    vm.showExitAccountAlert = true
                }
                    .alert( isPresented: $vm.showExitAccountAlert) {
                        Alert(title: Text(""),
                              message: Text("Hesabdan çıxış etməyə əminsiniz?"),
                              primaryButton: .destructive(Text("Çıxış")) ,
                              secondaryButton: .default(Text("İmtina")))
            }
            
            /// Delete account View
            CustomRowView(title: "Hesabı sil", 
                          subtitle: nil, 
                          leftImage: nil,
                          rightImage: "chevron", 
                          color: .red ,handler: {})
                .frame(height: 76)
                .onTapGesture {
                    vm.showDeleteAccountAlert = true
                }
            
                    .alert( isPresented: $vm.showDeleteAccountAlert) {
                        Alert(title: Text(""),
                              message: Text("Hesabınızı silmək istədiyinizə əminsiniz?"),
                              primaryButton: .destructive(Text("Bəli"), action: { navigateToDeleteAccountView = true }) ,
                              secondaryButton: .default(Text("Xeyr")))
            }
            
            NavigationLink(
                destination: DeleteAccountView(),
                isActive: $navigateToDeleteAccountView,
                label: {
                    EmptyView() })
        }
    }
}

#Preview {
    ProfileView()
}
