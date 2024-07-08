//
//  HTTPProfileRepository.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 05.07.24.
//

import Foundation
import NetworkingPack

final class HTTPProfileRepository {
    
    private var http: HTTPClient = .shared
    
    /// - Delete Account Function
    func deleteAccount(body: PasswordModel, completion: @escaping (Result<SuccessModel, Error>) -> Void) {
        
        http.DELETE(endPoint: EndPoint.profile(.deleteAccount), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
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
    
    /// - Change Password Function
    func changePassword(body: PasswordModel, completion: @escaping (Result<SuccessModel, Error>) -> Void){
        
        http.POST(endPoint: EndPoint.profile(.changePassword), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
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
    
}
