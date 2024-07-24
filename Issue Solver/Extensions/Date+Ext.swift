//
//  Date+Ext.swift
//  Issue Solver
//
//  Created by Valeh Amirov on 19.07.24.
//

import Foundation
extension Date {
    
    enum DateFormType: String {
        case hour = "HH:mm"
        case day = "dd.MM.YYYY"
        case all = "dd.MM.YYYY, HH:mm"
    }
//    MARK: this method can correct string date, for our custom date format.
    
    func dateFormatter(_ text: String? ,_ format: DateFormType) -> String {
        guard let text else { return String() }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let date = dateFormatter.date(from: text) ?? Date()
        let resultFormat = dateFormatter.string(from: date)
        return resultFormat

    }
}
