//
//  HTTPHomeRepository.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 12.07.24.
//

import Foundation
import NetworkingPack

class HTTPHomeRepository {
    
    private var http: HTTPClient = .shared
    
    func getAllQueries(pageCount: String, completion: @escaping (Result<QueryModel, Error>) -> Void) {
        http.GET(endPoint: EndPoint.home(.allRequests(pageCount))) { (data: QueryModel?,error: Error? ) in
            if let error {
                completion(.failure(error))
            }
            if let data {
                completion(.success(data))
            }
        }
    }
    
    func applyFilter(status: String, category: String, organization: String,days: String, pageCount: String,  completion: @escaping (Result<QueryModel, Error>) -> Void) {
        
        http.GET(endPoint: EndPoint.filter(.filter(status, category, organization, days, pageCount))) { (data: QueryModel?,error: Error?) in
            if let error {
                completion(.failure(error))
            }
            if let data {
                completion(.success(data))
            }
        }
    }

}
