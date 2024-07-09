//
//  TabBarScreen.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 08.07.24.
//

import SwiftUI

struct FloatingTabBar: View {
    
    var tabs = ["homeIcon", "queryIcon", "addIcon", "interactionsIcon", "profileIcon"]
    
    @State var selectedTab = "homeIcon"
    
    // Location of each curve
    @State var xAxis: CGFloat = 0
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                Color.red
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("homeIcon")
                
               MyQueryView()
                    .tag("queryIcon")
                
               NewQueryView()
                    .tag("addIcon")
                
                Color.brown
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("interactionsIcon")
                
               ProfileView()
                    .tag("profileIcon")
            }
            
            // Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    GeometryReader { reader in
                        Button(action: {
                            withAnimation(.spring()) {
                                selectedTab = image
                                xAxis = reader.frame(in: .global).midX
                            }
                        }, label: {
                            Image(image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                                .foregroundColor(selectedTab == image ? .white : .black)
                                .padding(selectedTab == image ? 15 : 0)
                                .background(
                                    ZStack {
                                        if selectedTab == image {
                                            Circle()
                                                .fill(Color.blue)
                                                .frame(width: 60, height: 60)
                                                .matchedGeometryEffect(id: "background", in: animation)
                                        }
                                    }
                                )
                                .offset(y: selectedTab == image ? -20 : 0)
                        })
                        .onAppear {
                            if image == tabs.first {
                                xAxis = reader.frame(in: .global).midX
                            }
                        }
                    }
                    .frame(width: 35, height: 40)
                    if image != tabs.last { Spacer() }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(
                Color.white
                    .clipShape(CustomShape(xAxis: xAxis))
                    .cornerRadius(12)
                    .animation(.smooth, value: 10)
            )
            .padding(.bottom, 0)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct FloatingTabBar_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTabBar()
    }
}

struct CustomShape: Shape {
    var xAxis: CGFloat
    
    // Animate Path
    var animatableData: CGFloat {
        get { return xAxis }
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 60)
            let control1 = CGPoint(x: center - 20, y: 0)
            let control2 = CGPoint(x: center - 30, y: 20)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 80, y: 40)
            let control4 = CGPoint(x: center + 30, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}



