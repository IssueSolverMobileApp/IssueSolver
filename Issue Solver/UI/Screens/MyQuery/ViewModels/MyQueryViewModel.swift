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
    
    var isLoading: Bool = false
    
    func getMyQuery() {
        queryRepository.getMyQueries(pageCount: "\(pageCount)") { [weak self] result in
            guard let self else { return }
            self.isLoading = true

            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    guard let data = success.data else { return }
                    print("------------DEBUG-----------")
//                    if !self.isLoading {
                        data.forEach { item in
                            if !self.queryData.contains(item) && item != QueryDataModel() {
                                self.queryData.append(item)
                                self.pageCount = self.pageCount + 1
                            }
                        }
//                    }
                    self.isLoading = false
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }
        }
    }
    
    func likeToggle(like: Bool, queryID: Int?) {
        guard let queryID else { return }
        if like {
            addLike(queryID: "\(queryID)")
        } else {
            deleteLike(queryID: "\(queryID)")
        }
    }
    
    private func addLike(queryID: String) {
        print(queryID)
        queryRepository.postLike(queryID: queryID) { result in
            switch result {
            case .success(let success):
                print(success.message ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func deleteLike(queryID: String) {
        queryRepository.deleteLike(queryID: queryID) { result in
            switch result {
            case .success(let success):
                print(success.message ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
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
        


