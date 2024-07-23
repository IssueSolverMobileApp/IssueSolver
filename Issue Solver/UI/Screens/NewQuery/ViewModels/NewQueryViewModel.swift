//
//  NewReqeuestViewModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 02.07.24.
//

import Foundation

@MainActor
class NewQueryViewModel: ObservableObject {
    
    @Published var categories: [QueryCategoryModel] = []
    @Published var organizations: [OrganizationModel] = []
    @Published var selectedOrganization: OrganizationModel = OrganizationModel()
    @Published var selectedCategory: QueryCategoryModel = QueryCategoryModel()
    
    
    @Published var addressText: String = ""
    @Published var categoryPicker: String = ""
    @Published var isRightTextEditor: Bool = true
    @Published var explanationEditorText: String = ""
    @Published var notificationType: NotificationType?
    @Published var isLoading: Bool = false
    @Published var isResetPressed: Bool = false
    
    private let queryRepository: HTTPNewQueryRepository = HTTPNewQueryRepository()
    
    init() {
        isLoading = true
        getCategories()
        getOrganizations()
    }
    
    func createNewQuery() {
        let newQuery = QueryDataModel(address: addressText, description: explanationEditorText, organizationName: selectedOrganization.name, category: selectedCategory)
            queryRepository.createNewQuery(body: newQuery) { [ weak self ] result in
                switch result {
                case .success(let success):
                    print(success)
                    self?.cleanFields()
                    self?.notificationType = .success(success)
                case .failure(let error):
                    self?.notificationType = .error(error)
                }
            }
    }
    
    func getCategories() {
        queryRepository.getCategories { [ weak self ] result in
            self?.isLoading = false
            switch result {
            case .success(let success):
                self?.categories = success
                self?.selectedCategory = success.first!
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getOrganizations() {
        queryRepository.getOrganizations { [ weak self ] result in
            self?.isLoading = false
            switch result {
            case .success(let success):
                self?.organizations = success
                self?.selectedOrganization = success.first!
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func cleanFields() {
        addressText = ""
        explanationEditorText = ""
        if !organizations.isEmpty && !categories.isEmpty {
            selectedOrganization = organizations.first!
            selectedCategory = categories.first!
        }
    }
}
