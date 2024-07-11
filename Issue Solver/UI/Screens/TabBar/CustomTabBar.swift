//
//  CustomTabBar.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 11.07.24.
//

import SwiftUI

struct CustomTabBar: View {
    
    @State var currentTab: Tab = .Home
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @Namespace var animation
    
    @State var currentXValue: CGFloat = 0
    
    var animatableData: CGFloat {
        get{currentXValue}
        set {currentXValue = newValue}
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            
            Color.red.ignoresSafeArea()
                .tag(Tab.Home)
            
            Color.gray.ignoresSafeArea()
                .tag(Tab.MyQuery)
            
            Color.yellow.ignoresSafeArea()
                .tag(Tab.NewQuery)
            
            Color.green.ignoresSafeArea()
                .tag(Tab.Interactions)
            
            Color.pink.ignoresSafeArea()
                .tag(Tab.Profile)
            
        }
        /// - Curved Tab Bar
        .overlay(
            HStack(spacing:0) {
                
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    TabButton(tab: tab)
                    
                }
                
            }
                .padding(.vertical)
                .padding(.bottom, getSafeArea().bottom == 0 ? 10 : (getSafeArea().bottom))
                .background(
                    Color.white
                        .clipShape(BottomCurve(currentXValue: currentXValue))
                )
            , alignment: .bottom
        )
        .ignoresSafeArea(.all, edges: .bottom)
    }
    

    
    /// - Tab Button
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        
        GeometryReader { proxy in
            
            Button {
                withAnimation(.smooth) {
                    currentTab = tab
                    
                    currentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                
                Image(tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(currentTab.rawValue == tab.rawValue ? .white : .black)
                    .padding(currentTab == tab ? 15 : 0)
                    .background(
                        ZStack {
                            
                            if currentTab == tab {
                                Color.primaryBlue
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    
                    )
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -16 : 0)
            }
            .onAppear {
                
                if tab == Tab.allCases.first && currentXValue == 0 {
                    
                    currentXValue = proxy.frame(in: .global).midX
                }
                
            }
        }
        .frame(height: 30)
    }
}




enum Tab: String, CaseIterable {
    case Home = "homeIcon"
    case MyQuery = "queryIcon"
    case NewQuery = "addIcon"
    case Interactions = "interactionsIcon"
    case Profile = "profileIcon"
}


extension View {
   
    func getSafeArea() -> UIEdgeInsets {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}
