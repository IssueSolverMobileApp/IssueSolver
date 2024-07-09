//
//  HTTPMyQueryRepository.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 09.07.24.
//

import Foundation
import NetworkingPack


final class HTTPMyQueryRepository {
    
    private var http: HTTPClient = .shared
    
    func getMyQuery(pageCount: String, completion: @escaping (Result<QueryModel, Error>) -> Void) {
        http.GET(endPoint: EndPoint.myQuery(.myquery(pageCount))) { (data: QueryModel?,error: Error? ) in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                completion(.success(data))
            }
        }
    }
}
