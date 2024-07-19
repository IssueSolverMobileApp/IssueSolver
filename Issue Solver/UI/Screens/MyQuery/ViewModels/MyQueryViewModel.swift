//
//  MyQueryViewModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 05.07.24.
//

import Foundation

class MyQueryViewModel: ObservableObject {
    
    @Published var queryData: [QueryDataModel] = []
    @Published var placeholderData = QueryDataModel()
    @Published var isDataEmptyButSuccess: Bool = false
    
    private var queryRepository = HTTPQueryRepository()
    private var pageCount: Int = 0
    
    init(queryData: [QueryDataModel] = []) {
        self.queryData = queryData
    }
    
    private var isLoading: Bool = false
    
    func getMoreQuery() {
        if !isLoading {
            getMyQuery()
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
    
    private func getMyQuery() {
        self.isLoading = true
        queryRepository.getMyQueries(pageCount: "\(pageCount)") { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    guard let data = success.data else { return }
                    if data.isEmpty && self.pageCount == 0 {
                        self.isDataEmptyButSuccess = true
                    } else {
                        self.addData(queryData: data)
                        self.isDataEmptyButSuccess = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }
        }
    }
    
    private func addLike(queryID: String) {
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
    
    private func addData(queryData: [QueryDataModel]) {
        queryData.forEach { item in
            if !queryData.contains(item) && item != QueryDataModel() {
                self.queryData.append(item)
            }
        }
        pageCount = pageCount + 1
        isLoading = false
    }
}
        
