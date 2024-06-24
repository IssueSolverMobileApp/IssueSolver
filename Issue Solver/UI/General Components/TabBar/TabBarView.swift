//
//  TabBarView.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 24.06.24.
//

import SwiftUI

/**
 - Parameter circleSize: CGFloat - for
 */

struct TabBarView: View {
    let widthOfView: CGFloat
    @Binding var selectedTab: Tab
    
    // Private Values
    @State private var paddingBetweenTabs: CGFloat = 0
    @State private var tabButtonOffset: CGFloat = 20 /// - Use minus number to make tab buttons higher
    @Namespace private var animation
    
    private let circleSize: CGFloat = 40
    private let tabButtonSize: CGFloat = 20
    
    var body: some View {
        ZStack {
            contentView
        }
        .onAppear {
            paddingBetweenTabs = widthOfView / (pow(CGFloat(Tab.allCases.count), 2) * 2)
        }
        .padding(.vertical)
    }
    
    // MARK: - Views
    
    var contentView: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                tabButtonView(tab)
            }
        }
        .padding()
        .background {
            Rectangle()
                .fill(Color(.systemBackground)) /// - Use '.systemBackground' as a default background color
        }
    }
    
    func tabButtonView(_ tab: Tab) -> some View {
        Button {
            withAnimation(.bouncy) {
                selectedTab = tab
            }
        } label: {
            ZStack {
                if selectedTab == tab {
                    Circle()
                        .fill(Color.primaryBlue)
                        .frame(width: circleSize, height: circleSize)
                        .matchedGeometryEffect(id: "tabButton", in: animation)
                }
                
                
                Image(tab.imageName)
                    .resizable()
                    .frame(width: tabButtonSize, height: tabButtonSize)
                    .foregroundStyle(selectedTab == tab ? .white : .black)
                
            }
        }
        .offset(y: selectedTab == tab ? 0 : tabButtonOffset)
        .padding(.horizontal, paddingBetweenTabs)
    }
    
    // MARK: - Functions
    
    
}
