//
//  ProfileView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 21.06.24.
//

import SwiftUI
import SafariServices

struct ProfileView: View {
    
    @EnvironmentObject var router: Router
    @StateObject var vm = ProfileViewModel()
    @State var showExitAccountAlert = false
    @State var showDeleteAccountAlert = false
    
    @StateObject private var auth: AuthManager = .shared
    
    var body: some View {
        ZStack {
            Color.surfaceBackground
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 48) {
                    firstSectionView
                    secondSectionView
                    thirdSection
                    Spacer()
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
                vm.getFullName()
        }
    }
    
    /// 1st section
    var firstSectionView: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            ///Profile View
            CustomRowView(title: vm.fullNameText,
                          subtitle: vm.emailText,
                          leftImage: "profile",
                          rightImage: "settings",
                          width: 48, height: 48,
                          color: .primaryBlue ,
                          font: .custom(.bold, 20),
                          handler: { router.navigate {
                MyAccountView()
            } })
            .frame(height: 100)
            
            ///Change Password View
            CustomRowView(title: "Şifrəni dəyiş",
                          subtitle: nil,
                          leftImage: "privacy",
                          rightImage: "chevron",
                          width: 38, height: 38,
                          handler: {})
            .frame(height: 86)
            .onTapGesture {
                router.navigate {
                    NewPasswordView()
                }
            }
        }
    }
    
    /// 2nd section
    var secondSectionView: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            ///Privacy Policy View
            
            Link(destination: vm.terms!) {
                CustomRowView(title: "Məxfilik siyasəti",
                              subtitle: nil,
                              leftImage: nil,
                              rightImage: "chevron",
                              handler: {})
                .frame(height: 76)
            }
            
            ///FAQ View
            Link(destination: vm.questions!) {
                CustomRowView(title: "Tez-tez verilən suallar",
                              subtitle: nil,
                              leftImage: nil,
                              rightImage: "chevron",
                              handler: {})
                .frame(height: 76)
            }
            
            ///About App View
            Link(destination: vm.aboutApp!) {
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
                showExitAccountAlert = true
            }
            .alert( isPresented: $showExitAccountAlert) {
                Alert(title: Text(""),
                      message: Text("Hesabdan çıxış etməyə əminsiniz?"),
                      primaryButton: .default(Text("İmtina")),
                      secondaryButton: .destructive(Text("Çıxış"), action: {
                    auth.logOut()
              }) )
            }
            /// Delete account View
            CustomRowView(title: "Hesabı sil",
                          subtitle: nil,
                          leftImage: nil,
                          rightImage: "chevron",
                          color: .red ,handler: {})
            .frame(height: 76)
            .onTapGesture {
                showDeleteAccountAlert = true
            }
            .alert( isPresented: $showDeleteAccountAlert) {
                Alert(title: Text(""),
                      message: Text("Hesabınızı silmək istədiyinizə əminsiniz?"),
                      primaryButton: .default(Text("Xeyr"))  ,
                      secondaryButton: .destructive(Text("Bəli"), action: { router.navigate {
                      DeleteAccountView()
                } }) )
            }
        }
    }
}
#Preview {
    ProfileView()
}
