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
        http.POST(endPoint: EndPoint.myQuery(.likeDelete(queryID)), body: nil) { (data: SuccessModel?, error: Error? )in
           
            if let error {
                completion(.failure(error))
            }
            
            if let data {
                completion(.success(data))
            }
        }
    }
    
    func createNewQuery(body: QueryDataModel, completion: @escaping (Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.newQuery(.request(body.category?.categoryName ?? "")), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success(data))
                }
            }
        }
    }
    
    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        http.GET(endPoint: EndPoint.newQuery(.category)) { (data: CategoryData?, error: Error?) in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success(data.data ?? []))
                }
            }
        }
    }
        

//    
//    func getMyQuery(queryID: String, completion: @escaping(SuccessModel, Error)) {
//        http.POST(endPoint: EndPoint.m, body: <#T##Data?#>, completion: <#T##(Decodable?, (any Error)?) -> Void#>)
//    }
}
