    //
    //  HomeViewModel.swift
    //  Issue Solver
    //
    //  Created by Irada Bakirli on 22.07.24.
    //

    import Foundation

    class HomeViewModel: ObservableObject {
        
        @Published var queryData: [QueryDataModel] = []
        @Published var selectedFilters: [String] = []
        @Published var isPresented: Bool = false
        @Published var queryID: String = ""
        @Published var isLoading: Bool = false
        
        private var homeRepository = HTTPHomeRepository()
        private var queryRepository = HTTPQueryRepository()
        var filterViewModel = FilterViewModel()
        var pageCount: Int = 0
        
        init(queryData: [QueryDataModel] = []) {
            self.queryData = queryData
        }
        
        func getMoreQuery() {
            guard !isLoading else { return }
            isLoading = true
            queryData = [.mock(), .mock(), .mock()]
            if !selectedFilters.isEmpty {
                applyCurrentFilter()
            } else {
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
            homeRepository.getAllQueries(pageCount: "\(pageCount)") { [weak self] result in
                guard let self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        guard let data = success.data else { return }
                        self.queryData = []
                        self.addData(queryData: data)
                        self.isLoading = false
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.isLoading = false
                    }
                }
            }
        }
        
         func applyFilter(organization: String, category: String, status: String, days: String) {
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
                        self.isLoading = false
                    case .failure(let error):
                        print("Error applying filter: \(error.localizedDescription)")
                        self.isLoading = false
                    }
                }
            }
        }
        func applyCurrentFilter() {
            guard selectedFilters.count >= 4 else {
                print("Selected filters array does not have enough elements")
                return
            }
            applyFilter(
                organization: selectedFilters[0],
                category: selectedFilters[1],
                status: selectedFilters[2],
                days: selectedFilters[3]
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
