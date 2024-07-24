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
    @Published var selectedOrganization: OrganizationModel = OrganizationModel(id: UUID(), name: "Qurum")
    @Published var selectedCategory: QueryCategoryModel = QueryCategoryModel(categoryID: 0, name: "Kateqoriya")
    
    
    @Published var addressText: String = ""
    @Published var categoryPicker: String = ""
    @Published var addressTextFieldError: (Bool, String)?
    @Published var textEditorError: (Bool, String)?
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
        if addressText.count < 4 {
            addressTextFieldError = (false, "Has error :(")
        } else if explanationEditorText.isEmpty {
            textEditorError = (false, "Has text editor error :(")
        } else {
            queryRepository.createNewQuery(body: newQuery) { [ weak self ] result in
                switch result {
                case .success(let success):
                    print(success)
                    self?.cleanFields()
                    self?.notificationType = .success(success)
                    self?.addressTextFieldError = nil
                    self?.textEditorError = nil
                case .failure(let error):
                    self?.notificationType = .error(error)
                }
            }
        }
    }
    
    func getCategories() {
        queryRepository.getCategories { [ weak self ] result in
            self?.isLoading = false
            switch result {
            case .success(let success):
                self?.categories = success
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
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func cleanFields() {
        addressText = ""
        explanationEditorText = ""
        if !organizations.isEmpty && !categories.isEmpty {
            selectedOrganization = OrganizationModel(id: UUID(), name: "Qurum")
            selectedCategory = QueryCategoryModel(categoryID: 0, name: "Kateqoriya")
        }
    }
}
