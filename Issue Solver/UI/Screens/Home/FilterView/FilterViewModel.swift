//
//  FilterViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 22.07.24.
//

import Foundation

struct SelectedFilters {
    let organization: OrganizationModel?
    let category: QueryCategoryModel?
    let status: StatusModel?
    let days: DateModel?
  }

class FilterViewModel: ObservableObject {
    
    @Published var categories: [QueryCategoryModel] = []
    @Published var organizations: [OrganizationModel] = []
    @Published var statuses: [StatusModel] = [
        StatusModel(name: "Gözləmədə"),
        StatusModel(name: "Baxılır"),
        StatusModel(name: "Əsassızdır"),
        StatusModel(name: "Həll edildi"),
        StatusModel(name: "Arxivdədir") ]
    
    @Published var date: [DateModel] = [
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
    
    init() {
        getCategories()
        getOrganizations()
    }
    
    func getCategories() {
        queryRepository.getCategories { [ weak self ] result in
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
            switch result {
            case .success(let success):
                self?.organizations = success

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
