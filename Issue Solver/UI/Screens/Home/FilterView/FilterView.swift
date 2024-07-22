//
//  FilterView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 22.07.24.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject var router: Router
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.surfaceBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                ScrollView {
                    titleView
                    bottomSheetView
                }
                    buttonView
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButtonView
            }
        }
    }
    
    ///Back Button View
     var backButtonView: some View {
         CustomButton(style: .back, title: "") {
             router.dismissView()
         }
     }
    
    var titleView: some View {
        HStack {
            CustomTitleView(title: "Filter")
        }
    }
    
    var bottomSheetView: some View {
        
        VStack(spacing: 24) {
            
            CustomFilterRowView(title: "Problemin yönləndiriləcəyi qurum", subtitle: "Qurum", rightImage: "arrowDownIcon" )
            
            CustomFilterRowView(title: "Problemin Kateqoriyası", subtitle: "Kateqoriya", rightImage: "arrowDownIcon" )
            
            CustomFilterRowView(title: "Problemin statusu", subtitle: "Status", rightImage: "arrowDownIcon" )
              
            
            CustomFilterRowView(title: "Problemin paylaşılma tarixi", subtitle: "Tarix", rightImage: "arrowDownIcon" )
        }
    }
    
    var buttonView: some View {
            CustomButton(style: .rounded, title: "Tətbiq et", color: .primaryBlue) {
                //  MARK: Paylaş button action must be here
            }
        }
    }

#Preview {
    FilterView()
}
