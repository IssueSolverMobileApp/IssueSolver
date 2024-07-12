//
//  HomeViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 12.07.24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var queryData: [QueryDataModel]
    
    private var homeRepository = HTTPHomeRepository()
    private var pageCount: Int = 0
    
    init(queryData: [QueryDataModel] = []) {
        self.queryData = queryData
    }
    
    func getAllHomeQueries()  {
        homeRepository.getAllQueries(pageCount: "\(pageCount)") { result in
            switch result {
            case .success(let success):
//                if !((success.data?.isEmpty) != [] ) {
                    self.queryData.append(contentsOf: success.data ?? [])
//                    self?.pageCount += 1
//                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}
    
    
