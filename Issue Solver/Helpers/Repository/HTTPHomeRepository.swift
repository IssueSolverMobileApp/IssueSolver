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
    
    func postLike(queryID: String, completion: @escaping(Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.query(.likePost(queryID)), body: nil) { (data: SuccessModel?, error: Error? )in
            if let error {
                completion(.failure(error))
            }
            if let data {
                completion(.success(data))
            }
        }
    }
    
    func deleteLike(queryID: String, completion: @escaping(Result<SuccessModel, Error>) -> Void) {
        
        http.DELETE(endPoint: EndPoint.query(.likeDelete(queryID)), body: nil) {(data: SuccessModel?, error: Error? ) in
            if let error {
                completion(.failure(error))
            }
            if let data {
                completion(.success(data))
            }
            
        }
    }
    
}
