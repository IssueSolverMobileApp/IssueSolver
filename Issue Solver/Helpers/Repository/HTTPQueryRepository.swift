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
    
    func postLike(postID: String, completion: @escaping(Result<LikeSuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.myQuery(.likePost(postID)), body: nil) { (data: LikeSuccessModel?, error: Error? )in
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                completion(.success(data))
            }
        }
    }
    
    
    func deleteLike(likeID: String, completion: @escaping(Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.myQuery(.likeDelete(likeID)), body: nil) { (data: SuccessModel?, error: Error? )in
           
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                completion(.success(data))
            }
        }
    }

}
