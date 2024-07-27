//
//  LoadingView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 01.07.24.
//

import SwiftUI


struct LoadingView: View {     /// - Creating loading view for some time, to replace actual full customized loading view
    var isLoading: Bool = false
    
    var body: some View {
        if isLoading {
            ZStack {
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(.circular)
            }
            .frame(width: 60,height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .circular))
            
        }
    }
}

