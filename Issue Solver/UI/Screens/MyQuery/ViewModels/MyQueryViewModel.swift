//
//  MyQueryViewModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 05.07.24.
//

import Foundation

class MyQueryViewModel: ObservableObject {
    
    @Published var queryData: [QueryDataModel] = []
    @Published var placeholderData = QueryDataModel()
    @Published var isDataEmptyButSuccess: Bool = false
    @Published var isPresented: Bool = false
    @Published var queryID: String = ""
    @Published var deleteQueryID: String = ""
    @Published var isDeletePressed: Bool = false
    @Published var isViewLoading: Bool = false
    
    @Published var isProgressViewSeen: Bool = false
    
    private var queryRepository = HTTPQueryRepository()
    private var pageCount: Int = 0 {
        didSet {
            print("salam pageCount tetiklendi")
            print(pageCount)
        }
    }
    
    init(queryData: [QueryDataModel] = []) {
        self.queryData = queryData
    }
    
    private var isLoading: Bool = false
    
    func getMoreQuery() {
        if !isLoading {
            self.isLoading = true
            getMyQueryWithPagination()
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
    
    func isDeletePressed(id: String?,_ isPressed: Bool) {
        self.isDeletePressed = isPressed
        guard let id else { return }
        self.deleteQueryID = id
        
    }
    
    func deleteQuery() {
        isViewLoading = true
        queryRepository.deleteSingleQuery(requestID: deleteQueryID) { [weak self ] result in
            guard let self else { return }
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.deleteQueryOnLocal()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func deleteQueryOnLocal() {
        if let index = queryData.firstIndex(where: {"\($0.requestID ?? Int())" == deleteQueryID}) {
            queryData.remove(at: index)
        }
        isViewLoading = false
        pageCount = queryData.count / 10
        if queryData.isEmpty {
            isDataEmptyButSuccess = true
        }
    }
    
    //    func deleteQueryOnDetailLocal(id: String) {
    //        if let index = queryData.firstIndex(where: {"\($0.requestID ?? Int())" == id}) {
    //            queryData.remove(at: index)
    //        }
    //        pageCount = queryData.count / 10
    //        if queryData.isEmpty {
    //            isDataEmptyButSuccess = true
    //        }
    //    }
    
    func getMyQuery() {
        pageCount = 0
        queryRepository.getMyQueries(pageCount: "\(pageCount)") { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    guard let data = success.data else { return }
                    self.isDataEmptyHandlerRemoveData(data: data)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }
        }
    }
    
    func getMyQueryWithPagination() {
        queryRepository.getMyQueries(pageCount: "\(pageCount)") { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    guard let data = success.data else { return }
                    self.isDataEmptyHandler(data: data)
                case .failure(let error):
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }
        }
    }
    
    
    
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
    
    private func addData(queryData: [QueryDataModel]) {
        
        queryData.forEach { item in
            if !self.queryData.contains(where: { $0.requestID == item.requestID }) {
                self.queryData.append(item)
            }
        }
        pageCount = self.queryData.count / 10
        isLoading = false
        isProgressViewSeenHandler(data: queryData)
    }
    
    private func isDataEmptyHandlerRemoveData(data: [QueryDataModel]) {
        if data.isEmpty && pageCount == 0 {
            isDataEmptyButSuccess = true
        } else {
            queryData.removeAll()
            addData(queryData: data)
            isDataEmptyButSuccess = false
        }
    }
    
    private func isDataEmptyHandler(data: [QueryDataModel]) {
        if data.isEmpty && pageCount == 0 {
            isDataEmptyButSuccess = true
        } else {
            addData(queryData: data)
            isDataEmptyButSuccess = false
        }
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
}
        
