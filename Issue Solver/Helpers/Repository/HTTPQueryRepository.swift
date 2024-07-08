//
//  HTTPQueryRepository.swift
//  Issue Solver
//
//  Created by Vusal Nuriyev on 08.07.24.
//

import Foundation
import NetworkingPack

final class HTTPQueryRepository {
    
    private let http: HTTPClient = .shared
    
    func createNewQuery(body: QueryModel, completion: @escaping (Result<SuccessModel, Error>) -> Void) {
        http.POST(endPoint: EndPoint.query(.request(body.categoryName)), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
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
        http.GET(endPoint: EndPoint.query(.category)) { (data: CategoryData?, error: Error?) in
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
