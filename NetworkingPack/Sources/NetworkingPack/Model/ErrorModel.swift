//
//  ErrorModel.swift
//
//
//  Created by Valeh Amirov on 13.06.24.
//

import Foundation

public struct ErrorModel: Codable {
    let timeSpam: String?
    let url: String?
    let title: String?
    let success: Bool?
    let status: Int?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case timeSpam = "timeSpam"
        case url = "url"
        case title = "title"
        case success = "success"
        case status = "status"
        case message = "message"
    }
}
