//
//  QueryDetailViewModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 21.07.24.
//

import Foundation

final class QueryDetailViewModel: ObservableObject {
    
    private var repository = HTTPQueryRepository()
    @Published var item: QueryDataModel?
    @Published var placeholderItem: QueryDataModel = QueryDataModel(requestID: Int(), fullName: "Valeh Amirov", address: "Baku", description: "Bu Card placeholder ucun nezerde tutulub", status: "Baxılır", organizationName: "IDDA", createDate: "26.07.2024", commentCount: Int(), likeCount: 0, likeSuccess: false, category: QueryCategoryModel(categoryID: Int(), name: "Rəqəmsal İnkişaf"))
    
    @Published var isDeletePressed: Bool = false
    @Published var isViewLoadingForDelete: Bool = false
    @Published var isLoading: Bool = false
    @Published var isPresented: Bool = false

    
    func getSingleQuery(id: String) {
        isLoading = true
        repository.getSingleQuery(id: id) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.item = success.data
                    self.isLoading = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }
    
    func deleteQuery(id: String, completion: @escaping (Bool) -> Void) {
        repository.deleteSingleQuery(requestID: id) { result in
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
        if item?.likeSuccess ?? Bool() {
            deleteLike(queryID: "\(item?.requestID ?? Int())")
        } else {
            addLike(queryID: "\(item?.requestID ?? Int())")
        }
    }
    
    private func addLike(queryID: String) {
        repository.postLike(queryID: queryID) { [ weak self ] result in
            guard let self else { return }
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.item?.likeSuccess = true
                    self.item?.likeCount! += 1
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
                    self.item?.likeSuccess = false
                    self.item?.likeCount! -= 1
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
