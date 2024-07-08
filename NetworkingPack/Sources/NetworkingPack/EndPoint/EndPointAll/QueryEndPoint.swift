//
//  SwiftUIView.swift
//  
//
//  Created by Vusal Nuriyev on 08.07.24.
//

import SwiftUI

public enum QueryEndPoint: EndPointProtocol {
    
    case request(String)
    case category
    
    var url: String {
        switch self {
        case .request(let query):
            return "\(baseRequestMS)request?categoryName=\(query)"
        case .category:
            return "\(baseRequestMS)category"
        }
    }
}
