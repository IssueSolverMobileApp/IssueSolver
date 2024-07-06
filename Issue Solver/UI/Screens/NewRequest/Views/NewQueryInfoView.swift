//
//  NewRequestInfoView.swift
//  Issue Solver
//
//  Created by ValehAmirov on 03.07.24.
//

import SwiftUI

struct NewQueryInfoView: View {
    
    @StateObject var vm = NewQueryInfoViewModel()
    
    var body: some View {
            VStack {
                titleView
                VStack(spacing: 48) {
                    infoView
                    warningView
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    
    
    var titleView: some View {
            CustomTitleView(title: "Qaydalar")
            
    }
    
    var infoView: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Məlumatlar")
                    .jakartaFont(.custom(.bold, 20))
                Spacer()
            }
            VStack {
                HStack {
                    Text(vm.infoSubTitleText)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack(alignment: .top) {
                    Text(vm.infoIconText)
                    .jakartaFont(.custom(.regular, 16))
                    Text(vm.infoText)
                        .jakartaFont(.custom(.regular, 17))
                    Spacer()

                }
                
            }
        }
    }
    
    private var warningView: some View {
        
        VStack(spacing: 24) {
            HStack {
                Text("Xəbərdarlıqlar")
                    .jakartaFont(.custom(.bold, 20))
                Spacer()
            }
            VStack {
                HStack {
                    Text(vm.warningSubTitleText)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack(alignment: .top) {
                    Text(vm.warningIconText)
                    .jakartaFont(.custom(.regular, 17))
                    
                    
                    Text(vm.warningText)
                        .jakartaFont(.custom(.regular, 17))
                    Spacer()

                }
                
            }
        }
    }
}

#Preview {
    NewQueryInfoView()
}
