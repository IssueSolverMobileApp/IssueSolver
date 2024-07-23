//
//  FilterViewModel.swift
//  Issue Solver
//
//  Created by Irada Bakirli on 22.07.24.
//

import Foundation

class FilterViewModel: ObservableObject {
    
    @Published var categories: [QueryCategoryModel] = []
    @Published var organizations: [OrganizationModel] = []
    @Published var statuses: [StatusModel] = [
        StatusModel(name: "Gözləmədə"),
        StatusModel(name: "Baxılır"),
        StatusModel(name: "Əsassızdır"),
        StatusModel(name: "Həllolundu"),
        StatusModel(name: "Arxivdədir") ]
    
    @Published var date: [DateModel] = [
        DateModel(name: "LastDay"),
        DateModel(name: "LastWeek"),
        DateModel(name: "LastMonth")]
    
    @Published var selectedOrganization: OrganizationModel = OrganizationModel()
    @Published var selectedCategory: QueryCategoryModel = QueryCategoryModel()
    @Published var selectedStatus: StatusModel = StatusModel(name: "Status")
    @Published var selectedDate: DateModel = DateModel(name: "Tarix")
    
    @Published var isRightTextEditor: Bool = true
    @Published var dateText: String = ""
    @Published var categoryPicker: String = ""
    
    private let queryRepository: HTTPNewQueryRepository = HTTPNewQueryRepository()
    private let homeRepository: HTTPHomeRepository = HTTPHomeRepository()
    
    
    func applyFilter() {
        let filter = QueryDataModel(status: selectedStatus.name, organizationName: selectedOrganization.name,createDate: selectedDate.name, category: selectedCategory )
        homeRepository.applyFilter(status: selectedStatus.name ?? "", category: selectedCategory.name ?? "", organization: selectedOrganization.name ?? "", days: selectedDate.name ?? "") { result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    
    func getCategories() {
        queryRepository.getCategories { [ weak self ] result in
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
            switch result {
            case .success(let success):
                self?.organizations = success
                self?.selectedOrganization = success.first!
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
