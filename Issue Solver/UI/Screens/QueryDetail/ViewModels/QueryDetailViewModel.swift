//
//  QueryDetailViewModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 21.07.24.
//

import Foundation

final class QueryDetailViewModel: ObservableObject {
    
    private var repository = HTTPQueryRepository()
    
    @Published var item: QueryDataModel = QueryDataModel()
    @Published var isDeletePressed: Bool = false
    @Published var isViewLoading: Bool = false

    
    func getSingleQuery(id: String) {
        repository.getSingleQuery(id: id) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.item = success.data
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteQuery(id: String, completion: @escaping (Bool) -> Void) {
        repository.deleteComment(requestID: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    completion(true)
                case .failure(let error):
                    completion(false)
                    print(error.localizedDescription)
                }
            }
        }
    }

    func likeToggle() {
        if item.likeSuccess ?? Bool() {
            deleteLike(queryID: "\(item.requestID ?? Int())")
        } else {
            addLike(queryID: "\(item.requestID ?? Int())")
        }
    }
    
    private func addLike(queryID: String) {
        repository.postLike(queryID: queryID) { [ weak self ] result in
            guard let self else { return }
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.item.likeSuccess = true
                    self.item.likeCount! += 1
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func deleteLike(queryID: String) {
        repository.deleteLike(queryID: queryID) { [ weak self ] result in
            guard let self else { return }
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.item.likeSuccess = false
                    self.item.likeCount! -= 1
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
