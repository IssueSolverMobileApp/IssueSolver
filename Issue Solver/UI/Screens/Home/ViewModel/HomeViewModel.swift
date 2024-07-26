    //
    //  HomeViewModel.swift
    //  Issue Solver
    //
    //  Created by Irada Bakirli on 22.07.24.
    //

    import Foundation

    class HomeViewModel: ObservableObject {
        
        @Published var queryData: [QueryDataModel] = []
        @Published var selectedFilters: SelectedFilters? = nil
        @Published var isPresented: Bool = false
        @Published var queryID: String = ""
        @Published var isLoading: Bool = false
        
        private var homeRepository = HTTPHomeRepository()
        private var queryRepository = HTTPQueryRepository()
        var pageCount: Int = 0
        var pageCountisChange: Bool = false
        
        init(queryData: [QueryDataModel] = []) {
            self.queryData = queryData
        }
        
        func getMoreQuery() {
            guard !isLoading else { return }
            isLoading = true
            queryData = QueryDataModel.mockArray()
            if let selectedFilters {
                applyCurrentFilter(selectedFilters)
            } else {
//                queryData = []
//                pageCount = 0
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
        
        func isPresentedToggle(queryID: String) {
            self.queryID = queryID
            isPresented.toggle()
        }
        
        private func getHomeQueries() {
            isLoading = true
            homeRepository.getAllQueries(pageCount: "\(pageCount)") { [weak self] result in
                guard let self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        guard let data = success.data else { return }
                        self.queryData = []
                        self.addData(queryData: data)
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.isLoading = false
                    }
                }
            }
        }
        
         func applyFilter(organization: String, category: String, status: String, days: String) {
             isLoading = true
            print("Applying filter: \(status), \(category), \(organization), \(days)")
             pageCount = 0
            homeRepository.applyFilter(status: status, category: category, organization: organization, days: days, pageCount: "\(pageCount)") { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        guard let data = success.data else { return }
                        self.queryData = []
                        self.addData(queryData: data)
                    case .failure(let error):
                        print("Error applying filter: \(error.localizedDescription)")
                        self.isLoading = false
                    }
                }
            }
        }
        func applyCurrentFilter(_ filters: SelectedFilters) {
            applyFilter(
                organization: (filters.organization?.name == "Qurum") ? "" : filters.organization?.name ?? "",
                category: (filters.category?.name == "Kateqoriya") ? "" : filters.category?.name ?? "",
                status: (  filters.status?.name == "Status") ? "" : filters.status?.name ?? "",
                days: ( filters.days?.name == "Tarix") ? "" : filters.days?.name ?? ""
            )
        }
        
        private func addLike(queryID: String) {
            queryRepository.postLike(queryID: queryID) { result in
                switch result {
                case .success(let success):
                    print(success.message ?? "")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        private func deleteLike(queryID: String) {
            queryRepository.deleteLike(queryID: queryID) { result in
                switch result {
                case .success(let success):
                    print(success.message ?? "")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        private func addData(queryData: [QueryDataModel]) {
            queryData.forEach { item in
                if !queryData.contains(item) && item != QueryDataModel() {
                    self.queryData.append(item)
                }
            }
            pageCount = pageCount + 1
            isLoading = false
        }
    }
