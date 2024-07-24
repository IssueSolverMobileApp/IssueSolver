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
    
    
    @Published var addressText: String = "" {
        didSet {
            if addressText.count < 5 && !addressText .isEmpty {
                addressTextFieldError = "Adres mətni minimum 5 simvoldan ibarət olamlıdır"
                isRightAddress = false
            } else {
                addressTextFieldError = nil
                isRightAddress = true
            }
        }
    }
    
    @Published var explanationEditorText: String = "" {
        didSet {
            if explanationEditorText.count < 10 && !explanationEditorText.isEmpty {
                textEditorError = "Müraciət mətni minimum 10 simvoldan ibarət olamlıdır"
                isRightExplanation = false
            } else {
                textEditorError = nil
                isRightExplanation = true
            }
        }
    }
    
    @Published var categoryPicker: String = ""
    @Published var addressTextFieldError: String?
    @Published var textEditorError: String?
    @Published var isRightAddress: Bool = true
    @Published var isRightOrganization: Bool = true
    @Published var isRightCategory: Bool = true
    @Published var isRightExplanation: Bool = true
    
    @Published var notificationType: NotificationType?
    @Published var isLoading: Bool = false
    @Published var isResetPressed: Bool = false
    
    private let queryRepository: HTTPNewQueryRepository = HTTPNewQueryRepository()
    
    init() {
        isLoading = true
        getOrganizations()
    }
    
    func createNewQuery(completion: @escaping (SuccessModel?, Error?) -> Void) {
        cleanErrors()
        let newQuery = QueryDataModel(address: addressText, description: explanationEditorText, organizationName: selectedOrganization.name, category: selectedCategory)
       
        if selectedOrganization.name == "Qurum" {
            isRightOrganization = false
        }
        
        if selectedCategory.name == "Kateqoriya" {
            isRightCategory = false
        }
        
        if isRightAddress, isRightCategory, isRightExplanation, isRightOrganization {
            queryRepository.createNewQuery(body: newQuery) { [ weak self ] result in
                guard let self else { return }
                
                switch result {
                case .success(let success):
                    print(success)
                    self.cleanFields()
                    self.addressTextFieldError = nil
                    self.textEditorError = nil
                    completion(success, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    func getCategories() {
        queryRepository.getCategories { [ weak self ] result in
            guard let self else { return }
            self.isLoading = false
            switch result {
            case .success(let success):
                self.categories = success
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    func getOrganizations() {
        queryRepository.getOrganizations { [ weak self ] result in
            guard let self else { return }
            self.isLoading = false
            switch result {
            case .success(let success):
                self.organizations = success
                self.getCategories()
            case .failure(let error):
                self.getCategories()
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
    
    func cleanErrors() {
        isRightAddress = true
        isRightExplanation = true
        isRightOrganization = true
        isRightCategory = true
        addressTextFieldError = nil
        textEditorError = nil
    }
}
