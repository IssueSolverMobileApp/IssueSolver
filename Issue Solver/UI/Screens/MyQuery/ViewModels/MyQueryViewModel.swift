//
//  MyQueryViewModel.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 05.07.24.
//

import Foundation

class MyQueryViewModel: ObservableObject {
    
    @Published var postText: String = "Office ipsum you must be muted. Teeth recap latest didn't at. Innovation hill as wider assassin heads-up stronger give. Who's cloud low out email later charts. Believe our territories good client incentivization decisions pole product with. Pushback like be reach incompetent. Need bake ditching another loss to. Algorithm now pants items future-proof needle elephant i'm synergize old. Optimize meat room dog board invested devil reach. Horse building more prioritize meat per stakeholders.building"
    
    @Published var queryData: [QueryDataModel]
    
    private var queryRepository = HTTPQueryRepository()
    private var pageCount: Int = 0
    
    init(queryData: [QueryDataModel] = []) {
        self.queryData = queryData
    }
    
//    @MainActor
//    func getQuery() async {
//        queryRepository.getMyQuery(pageCount: "\(pageCount)") { result in
//            switch result {
//            case .success(let success):
//                if !((success.data?.isEmpty) != nil) {
//                    self.queryData.append(contentsOf: success.data ?? [])
//                    self.pageCount += 1
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        
//    }
}
