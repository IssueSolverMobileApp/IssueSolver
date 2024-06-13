//
//  JSONConverter.swift
//  Issue Solver
//
//  Created by ValehAmirov on 13.06.24.
//

import Foundation

final class JSONConverter {
    
    
    func encode<T: Encodable>(input: T) -> Data {
        do {
            let data = try JSONEncoder().encode(input)
            return data
        }
        catch {
            print(error.localizedDescription)
        }
        return Data()
    }
}
