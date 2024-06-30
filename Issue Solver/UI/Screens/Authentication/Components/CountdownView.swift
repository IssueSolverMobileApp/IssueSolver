//
//  CountdownView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 12.06.24.
//

import SwiftUI

struct CountdownView: View {
    @State private var timeRemaining = 180
    @State private var timer: Timer? = nil
    
    var completion: () -> Void
    
    var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        Text(formattedTime)
            .foregroundStyle(.primaryBlue)
            .font(.system(size: 17))
            .onAppear {
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
                timer = nil
            }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timer = nil
                completion()
            }
        }
    }
}
#Preview {
    CountdownView {
        
    }
}

