//
//  TabBarView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 11.07.24.
//

import SwiftUI

struct TabBarView: View {
    
    @State var currentTab: Tab = .homeIcon
    @State var notificationType: NotificationType?
    
    init() {
        UITabBar.appearance().alpha = 0
    }
    
    @Namespace var animation
    
    @State var currentXValue: CGFloat = 0
    
    var animatableData: CGFloat {
        get{currentXValue}
        set {currentXValue = newValue}
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $currentTab) {
                
                HomeView()
                    .tag(Tab.homeIcon)
                
                MyQueryView()
                    .tag(Tab.queryIcon)
                
                NewQueryView(selectedTab: $currentTab, notificationType: $notificationType)
                    .tag(Tab.addIcon)
                
                //            Color.green.ignoresSafeArea()
                //                .tag(Tab.interactionsIcon)
                
                ProfileView()
                    .tag(Tab.profileIcon)
            }
            
            if let type = notificationType {
                VStack {
                    NotificationView(type: type) {
                        notificationType = nil
                    }
                    Spacer()
                }
            }
            
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
                withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.25)) {
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
                    .offset(y: currentTab == tab ? -25 : 0)
            }
            .onAppear {
                
                if tab == Tab.allCases.first && currentXValue == 0 {
                    
                    currentXValue = proxy.frame(in: .global).midX
                }
                
            }
        }
        .frame(height: 20)
    }
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

