//
//  HTTPNewQueryRepository.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 22.07.24.
//

import Foundation
import NetworkingPack

final class HTTPNewQueryRepository {
    
    private var http: HTTPClient = .shared
    
    func createNewQuery(body: QueryDataModel, completion: @escaping (Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.newQuery(.request(body.category?.name ?? "")), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
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
    
    func getCategories(completion: @escaping (Result<[QueryCategoryModel], Error>) -> Void) {
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
    
    func getOrganizations(completion: @escaping (Result<[OrganizationModel], Error>) -> Void) {
        http.GET(endPoint: EndPoint.newQuery(.organizations)) { (data: OrganizationData?, error: Error?) in
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
    
}
