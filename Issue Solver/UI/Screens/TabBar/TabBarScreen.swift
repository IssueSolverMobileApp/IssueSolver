//
//  TabBarScreen.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 08.07.24.
//

import SwiftUI

struct FloatingTabBar: View {
    
    var tabs = ["homeIcon", "queryIcon", "addIcon", "interactionsIcon", "profileIcon"]
    
    @State var selectedTab = "home"
    
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
                    .tag("home")
                
                Color.blue
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("notifications")
                
                Color.orange
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("search")
                
                Color.brown
                    .ignoresSafeArea(.all, edges: .all)
                    .tag("basket")
            }
            
            // Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    GeometryReader { reader in
                        Button(action: {
                            withAnimation {
                                selectedTab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                        }, label: {
                            Image(image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                                .foregroundColor(selectedTab == image ? .white : .black)
                                .padding(selectedTab == image ? 15 : 0)
                                .background(Color.blue.opacity(selectedTab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedTab == image ? -30 : 0, y: selectedTab == image ? -20 : 0)
                        })
                        .onAppear(perform: {
                            if image == tabs.first {
                                xAxis = reader.frame(in: .global).minX
                            }
                        })
                    }
                    .frame(width: 35, height: 40)
                    if image != tabs.last { Spacer() }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Color.white.clipShape(CustomShape(xAxis: xAxis)))
            

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
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 40)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 40)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}

struct MyIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.addRect(CGRect(x: 0, y: 0.05*height, width: 1.02381*width, height: 0.95*height))
        
        path.move(to: CGPoint(x: 0.20714*width, y: 0.05*height))
        
        path.addCurve(to: CGPoint(x: 0.23575*width, y: 0.31014*height), control1: CGPoint(x: 0.22791*width, y: 0.05*height), control2: CGPoint(x: 0.23146*width, y: 0.16786*height))
        
        path.addCurve(to: CGPoint(x: 0.32381*width, y: 0.8*height), control1: CGPoint(x: 0.24228*width, y: 0.52677*height), control2: CGPoint(x: 0.25052*width, y: 0.8*height))
        
        path.addCurve(to: CGPoint(x: 0.4156*width, y: 0.30719*height), control1: CGPoint(x: 0.39744*width, y: 0.8*height), control2: CGPoint(x: 0.4076*width, y: 0.52428*height))
        
        path.addCurve(to: CGPoint(x: 0.44524*width, y: 0.05*height), control1: CGPoint(x: 0.4208*width, y: 0.16623*height), control2: CGPoint(x: 0.42509*width, y: 0.05*height))
        
        path.addLine(to: CGPoint(x: 0.20714*width, y: 0.05*height))
        
        path.closeSubpath()
        return path
    }
}
