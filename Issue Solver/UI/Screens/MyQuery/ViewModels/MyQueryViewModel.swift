//
//  MyQueryViewModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 05.07.24.
//

import Foundation

class MyQueryViewModel: ObservableObject {

    @Published var queryData: [QueryDataModel] = []
    
    private var queryRepository = HTTPQueryRepository()
    private var pageCount: Int = 0
    
    init(queryData: [QueryDataModel] = []) {
        self.queryData = queryData
    }
    
    func getMyQuery() {
        queryRepository.getMyQueries(pageCount: "\(pageCount)") { [weak self ]result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    guard let data =  success.data else { return }
                    self.queryData.append(contentsOf: data)
                    if success == QueryModel() {
                        self.pageCount += 1
                    } else {
                        self.pageCount = 0
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
//        queryRepository.getMyQuery(pageCount: "\(pageCount)") { result in
//            switch result {
//            case .success(let success):
//                if !((success.data?.isEmpty) != nil) {
//                    self.queryData.append(contentsOf: success.data ?? [])
//                    self.pageCount += 1
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
    }
}
