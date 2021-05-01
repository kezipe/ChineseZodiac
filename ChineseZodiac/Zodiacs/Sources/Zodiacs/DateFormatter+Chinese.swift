//
//  DateFormatter+Chinese.swift.swift
//  
//
//  Created by Kevin Peng on 2021-04-26.
//

import Foundation

extension DateFormatter {
    static let longChineseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.calendar = Calendar(identifier: .chinese)
        formatter.dateStyle = .long
        return formatter
    }()
}
