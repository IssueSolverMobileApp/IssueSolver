//
//  CustomToggleLikeStyle.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 07.07.24.
//

import SwiftUI

struct CustomToggleLikeStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(configuration.isOn ? .likeIconFill : .likeIcon )
        }
    }
}
