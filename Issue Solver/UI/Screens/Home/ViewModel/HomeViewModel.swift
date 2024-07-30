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
        @Published var hasMoreData: Bool = true
        @Published var isProgressViewSeen: Bool = false
        @Published var ifNeedDeleteButton: Bool = false
        
        private var homeRepository = HTTPHomeRepository()
        private var queryRepository = HTTPQueryRepository()
        var isInitialDataLoaded: Bool = false
        var pageCount: Int = 0
        
        init(queryData: [QueryDataModel] = []) {
            self.queryData = queryData
        }
        
        func getMoreQuery() {
            guard !isLoading && hasMoreData else { return }
            isLoading = true
            
            if !isInitialDataLoaded {
                queryData = QueryDataModel.mockArray()
            }
            if let selectedFilters = selectedFilters {
                applyCurrentFilter(selectedFilters)
            } else {
                getHomeQueries()
            }
        }
        
        func isPresentedToggle(queryID: String) {
            self.queryID = queryID
            isPresented.toggle()
        }
        
        private func getHomeQueries() {
            isLoading = true
            homeRepository.getAllQueries(pageCount: "\(pageCount)") { [weak self] result in
                guard let self = self else { return }
                 DispatchQueue.main.async {
                     self.isLoading = false
                     
                     switch result {
                     case .success(let success):
                         guard let data = success.data else {
                             self.hasMoreData = false
                             return
                         }
                         if data.isEmpty {
                             self.hasMoreData = false
                                                                                 
                         } else {
                             if !self.isInitialDataLoaded {
                              self.queryData = []
                            }
                             self.addData(queryData: data)
                         }
                         self.isInitialDataLoaded = true

                     case .failure(let error):
                         print(error.localizedDescription)
                     }
                 }
             }
         }
        
         func applyFilter(organization: String, category: String, status: String, days: String) {
             isLoading = true
             isInitialDataLoaded = false
             pageCount = 0
             homeRepository.applyFilter(status: status, category: category, organization: organization, days: days, pageCount: "\(pageCount)") { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                       case .success(let success):
                           guard let data = success.data else {
                               self.queryData = []
                               self.hasMoreData = false
                               return
                           }
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
                status: (filters.status?.nameWithoutSpaces == "Status") ? "" : filters.status?.nameWithoutSpaces ?? "",
                days: (filters.days?.name == "Tarix") ? "" : filters.days?.name ?? ""
        )}
        
        private func addLike(queryID: String) {
            queryRepository.postLike(queryID: queryID) { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        if let index = self.queryData.firstIndex(where: {"\($0.requestID ?? Int())" == queryID}) {
                            self.queryData[index].likeSuccess = true
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        private func deleteLike(queryID: String) {
            queryRepository.deleteLike(queryID: queryID) { [ weak self ] result in
                guard let self else { return }
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        if let index = self.queryData.firstIndex(where: {"\($0.requestID ?? Int())" == queryID}) {
                            self.queryData[index].likeSuccess = false
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
        
        private func addData(queryData: [QueryDataModel]) {
            queryData.forEach { item in
                if !queryData.contains(item) && item != QueryDataModel() {
                    self.queryData.append(item)
                }
            }
            self.pageCount += 1
            self.isInitialDataLoaded = true
            isLoading = false
            isProgressViewSeenHandler(data: queryData)
        }
        
        private func isProgressViewSeenHandler(data: [QueryDataModel]) {
            let dataCount = self.queryData.count % 10
            
            if dataCount == 0 && !self.queryData.isEmpty && data.isEmpty {
                isProgressViewSeen = false
            } else if dataCount == 0 && !self.queryData.isEmpty {
                isProgressViewSeen = true
            } else if dataCount > 0 && !self.queryData.isEmpty {
                isProgressViewSeen = false
            }
        }
        
         func refreshQueries()  {
            isLoading = true
            pageCount = 0
            homeRepository.getAllQueries(pageCount: "\(pageCount)") { [weak self] result in
                guard let self = self else { return }
                 DispatchQueue.main.async {
                     self.isLoading = false
                     
                     switch result {
                     case .success(let success):
                         guard let data = success.data else {
                             self.hasMoreData = false
                             return
                         }
                         if data.isEmpty {
                             self.hasMoreData = false
                                                                                 
                         } else {
                             if !self.isInitialDataLoaded {
                              self.queryData = []
                            }
                             self.queryData = []
                             self.addData(queryData: data)
                         }
                         self.isInitialDataLoaded = true

                     case .failure(let error):
                         print(error.localizedDescription)
                     }
                 }
             }
         }
    }
