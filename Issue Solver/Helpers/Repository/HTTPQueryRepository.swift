//
//  HTTPMyQueryRepository.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 09.07.24.
//

import Foundation
import NetworkingPack


final class HTTPQueryRepository {
    
    private var http: HTTPClient = .shared
    
    func getMyQueries(pageCount: String, completion: @escaping (Result<QueryModel, Error>) -> Void) {
        http.GET(endPoint: EndPoint.myQuery(.myqueries(pageCount))) { (data: QueryModel?,error: Error? ) in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                completion(.success(data))
            }
        }
    }
    
    func postLike(queryID: String, completion: @escaping(Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.myQuery(.likePost(queryID)), body: nil) { (data: SuccessModel?, error: Error? )in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                completion(.success(data))
            }
        }
    }
    
    func deleteLike(queryID: String, completion: @escaping(Result<SuccessModel, Error>) -> Void) {
        
        http.DELETE(endPoint: EndPoint.myQuery(.likeDelete(queryID)), body: nil) {(data: SuccessModel?, error: Error? ) in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                completion(.success(data))
            }

        }
    }
}
