//
//  FilterViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 22.07.24.
//

import Foundation

class FilterViewModel: ObservableObject {
    
    @Published var categories: [QueryCategoryModel] = [QueryCategoryModel.none]
    @Published var organizations: [OrganizationModel] = [OrganizationModel.none]
    @Published var statuses: [StatusModel] = [
        .none,
        StatusModel(name: "Gözləmədə"),
        StatusModel(name: "Baxılır"),
        StatusModel(name: "Əsassızdır"),
        StatusModel(name: "Həll edildi"),
        StatusModel(name: "Arxivdədir") ]
    
    @Published var date: [DateModel] = [
        .none,
        DateModel(name: "Son bir gün"),
        DateModel(name: "Son bir ay"),
        DateModel(name: "Son bir həftə")]
    
    @Published var selectedOrganization: OrganizationModel = OrganizationModel(id: UUID(),name: "Qurum")
    @Published var selectedCategory: QueryCategoryModel = QueryCategoryModel(categoryID: 0 ,name: "Kateqoriya")
    @Published var selectedStatus: StatusModel = StatusModel(id: UUID() ,name: "Status")
    @Published var selectedDate: DateModel =  DateModel(id: UUID(), name: "Tarix")
    
    @Published var isRightTextEditor: Bool = true
    @Published var dateText: String = ""
    @Published var categoryPicker: String = ""
    
    private let queryRepository: HTTPNewQueryRepository = HTTPNewQueryRepository()
    private let homeRepository: HTTPHomeRepository = HTTPHomeRepository()
    
    var onApplyFilter: ((String, String, String, String) -> Void)?
    
    func getCategories() {
        queryRepository.getCategories { [ weak self ] result in
            switch result {
            case .success(let success):
                self?.categories = [QueryCategoryModel.none] + success
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getOrganizations() {
        queryRepository.getOrganizations { [ weak self ] result in
            switch result {
            case .success(let success):
                self?.organizations = [OrganizationModel.none] + success

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func applyFilter() {
        let statusName = (selectedStatus.name == "Status" || selectedStatus == .none) ? "" : selectedStatus.nameWithoutSpaces
        let categoryName = (selectedCategory.name == "Kateqoriya" || selectedCategory == .none) ? "" : selectedCategory.name
        let organizationName = (selectedOrganization.name == "Qurum" || selectedOrganization == .none) ? "" : selectedOrganization.name
        let dateName = (selectedDate.name == "Tarix" || selectedDate == .none) ? "" : selectedDate.name
        
        onApplyFilter?(statusName, categoryName ?? "", organizationName ?? "", dateName ?? "")
    }
}
