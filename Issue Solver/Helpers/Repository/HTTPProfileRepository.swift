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
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success(data))
                    
            }
        }
    }
    
    /// Get Username
    func getMe(completion: @escaping (Result<ProfileSuccessModel, Error>) -> Void) {
        http.GET(endPoint: EndPoint.auth(.getMe)) { (data: ProfileSuccessModel?, error: Error?) in
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
    
    /// - Change FullName Function
    func changeFullName(body: FullNameModel, completion: @escaping (Result<SuccessModel, Error>) -> Void) {
        http.PUT(endPoint: EndPoint.profile(.updateFullName), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
            if let error {
                completion(.failure(error))
            }
            if let data {
                completion(.success(data))
            }
        }
    }
    
    /// - Change Password Function
    func changePassword(body: UpdatePasswordModel, completion: @escaping (Result<SuccessModel, Error>) -> Void){
        http.PUT(endPoint: EndPoint.profile(.changePassword), body: JSONConverter().encode(input: body)) { (data: SuccessModel?, error: Error?) in
                if let error {
                    completion(.failure(error))
                }
                if let data {
                    completion(.success(data))
            }
        }
    }
    
}
