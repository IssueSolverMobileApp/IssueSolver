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
    
    private var repository = HTTPQueryRepository()
    private var pageCount: Int = 0

    func getQueryComments(requestID: String, pageCount: String) {
        repository.getComments(requestID: requestID, pageCount: pageCount) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                guard let data = success.data  else { return }
                self.isDataEmptyHandler(data: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addData(commentData: [QueryCommentDataModel]) {
        commentData.forEach { item in
            if !self.commentData.contains(item) && item != QueryCommentDataModel() {
                self.commentData.append(item)
            }
        }
        pageCount = pageCount + 1
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

