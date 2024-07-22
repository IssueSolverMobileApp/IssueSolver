//
//  HomeViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 22.07.24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var homeData: [QueryDataModel] = []
    @Published var placeholderData = QueryDataModel()
    @Published var isDataEmptyButSuccess: Bool = false
    
    private var homeRepository = HTTPHomeRepository()
    private var pageCount: Int = 0
    
    init(homeData: [QueryDataModel] = []) {
        self.homeData = homeData
    }
    
    private var isLoading: Bool = false
    
    func getMoreQuery() {
        if !isLoading {
            self.isLoading = true
            getHomeQueries()
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
    
    private func getHomeQueries() {
        homeRepository.getAllQueries(pageCount: "\(pageCount)") { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    guard let data = success.data else { return }
                    self.isDataEmptyHandler(data: data)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }
        }
    }
    
    private func addLike(queryID: String) {
        homeRepository.postLike(queryID: queryID) { result in
            switch result {
            case .success(let success):
                print(success.message ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func deleteLike(queryID: String) {
        homeRepository.deleteLike(queryID: queryID) { result in
            switch result {
            case .success(let success):
                print(success.message ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addData(homeData: [QueryDataModel]) {
        homeData.forEach { item in
            if !homeData.contains(item) && item != QueryDataModel() {
                self.homeData.append(item)
            }
        }
        pageCount = pageCount + 1
        isLoading = false
    }
    
    private func isDataEmptyHandler(data: [QueryDataModel]) {
        if data.isEmpty && pageCount == 0 {
            isDataEmptyButSuccess = true
        } else {
            addData(homeData: data)
            isDataEmptyButSuccess = false
        }
    }
}
