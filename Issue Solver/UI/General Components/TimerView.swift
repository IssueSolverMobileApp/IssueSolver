//
//  TimerView.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 12.06.24.
//

import SwiftUI

struct TimerView: View {
    @State var timeRemaining = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var formattedTime: String {
         let minutes = timeRemaining / 60
         let seconds = timeRemaining % 60
         return String(format: "%02d:%02d", minutes, seconds)
     }

    var body: some View {
        Text(formattedTime)
            .foregroundColor(.primaryBlue)
            .font(.system(size: 17))
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
            }
    }
}

#Preview {
    TimerView()
}
