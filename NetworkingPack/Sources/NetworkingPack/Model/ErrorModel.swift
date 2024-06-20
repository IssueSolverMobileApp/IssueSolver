//
//  ErrorModel.swift
//
//
//  Created by Valeh Amirov on 13.06.24.
//

import Foundation

struct ErrorModel: Codable {
    let timeSpam: String?
    let url: String?
    let title: String?
    let success: Bool?
    let status: Int?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case timeSpam = "TimeSpam"
        case url = "Url"
        case title = "Title"
        case success = "Success"
        case status = "Status"
        case message = "Message"
    }
}
