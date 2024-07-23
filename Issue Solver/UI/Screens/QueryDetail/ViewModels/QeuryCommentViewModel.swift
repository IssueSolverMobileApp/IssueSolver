//
//  QeuryCommentBottomSheetViewModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 22.07.24.
//

import Foundation

final class QeuryCommentViewModel: ObservableObject {
    
    @Published var commentData: [QueryCommentDataModel] = []
    @Published var isDataEmptyButSuccess: Bool = false
    
    private var userFullName: String = ""
    private var repository = HTTPQueryRepository()
    private var pageCount: Int = 0
    private var isLoading: Bool = false

    func getMoreQuery(requestID: String) {
        if !isLoading {
            self.isLoading = true
            getQueryComments(requestID: requestID )
        }
    }

    func getQueryComments(requestID: String) {
        repository.getComments(requestID: requestID, pageCount: "\(pageCount)") { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                guard let data = success.data  else { return }
                guard let fullName = success.fullName else { return }
                    self.isDataEmptyHandler(data: data)
                    self.userFullName = fullName
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
        private func addComment(requestID: String, text: String) {
            let item = PostCommentModel(commentText: text)
            repository.postComment(requestID: requestID, body: item) { [weak self] result in
                guard let self else { return }
                DispatchQueue.main.async {
                switch result {
                case .success(let success):
                        guard let data = success.data else { return }
                        self.handleCommentSuccess(data: data, success: true)
                    case .failure(let error):
                        self.handleCommentSuccess(data: nil, success: false)
                        print(error.localizedDescription)
                    }
                }
            }
        }
    
    func addLocalComment(requestID: String?, text: String?) {
        guard let newText = text, let requestID else { return }
        let item = QueryCommentDataModel(commentID: Int(), commentIsSuccess: false, fullName: userFullName, authority: "USER", commentText: newText, createDate: "")
        commentData.insert(item, at: 0)
        addComment(requestID: requestID, text: newText)
    }
    
    private func handleCommentSuccess(data: QueryCommentDataModel?,success: Bool) {
        if !(commentData[0].commentIsSuccess ?? true) {
            commentData.remove(at: 0)
            guard let data else { return }
            commentData.insert(data, at: 0)
        }
        
    }
    
    private func addData(commentData: [QueryCommentDataModel]) {
        commentData.forEach { item in
            if !self.commentData.contains(item) && item != QueryCommentDataModel() {
                self.commentData.append(item)
            }
        }
        pageCount = pageCount + 1
        isLoading = false
    }
    
    private func isDataEmptyHandler(data: [QueryCommentDataModel]) {
        if data.isEmpty && pageCount == 0 {
            isDataEmptyButSuccess = true
        } else {
            addData(commentData: data)
            isDataEmptyButSuccess = false
        }
    }
}

