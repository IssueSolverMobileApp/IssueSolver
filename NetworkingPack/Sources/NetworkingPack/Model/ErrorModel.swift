//
//  ErrorModel.swift
//
//
//  Created by Valeh Amirov on 13.06.24.
//

import Foundation

public struct ErrorModel: Codable {
    let success: Bool?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
    }
}
