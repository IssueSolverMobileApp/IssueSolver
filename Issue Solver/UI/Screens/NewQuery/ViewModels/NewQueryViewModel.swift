//
//  NewReqeuestViewModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 02.07.24.
//

import Foundation

@MainActor
class NewQueryViewModel: ObservableObject {
    
    @Published var newQuery: QueryDataModel?
    @Published var categories: [QueryCategoryModel] = []
    @Published var selectedCategory: QueryCategoryModel?
    
    private let queryRepository: HTTPNewQueryRepository = HTTPNewQueryRepository()
    
    init() {
        getCategories()
        self.selectedCategory = categories.first
    }
    
    func createNewQuery() {
        if let newQuery {
            queryRepository.createNewQuery(body: newQuery) { result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func getCategories() {
        queryRepository.getCategories { result in
            switch result {
            case .success(let success):
                self.categories = success
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
