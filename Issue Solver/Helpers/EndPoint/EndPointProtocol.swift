//
//  EndPointProtocol.swift
//  Issue Solver
//
//  Created by ValehAmirov on 13.06.24.
//

import Foundation

protocol EndPointProtocol {
    var baseURL: String { get }
    var url: String { get }
}

extension EndPointProtocol {
    
    var baseURL: String {
        return "https://govermentauthapi20240610022027.azurewebsites.net/api/"
    }

}
