//
//  Date+Extensions.swift
//  
//
//  Created by Kevin Peng on 2021-04-26.
//

import Foundation

extension Date {
    func convertToChineseDate() -> String {
        let formatter = DateFormatter.longChineseDateFormatter
        let chineseDate = formatter.string(from: self)
        return chineseDate
    }

    func branch() -> String? {
        let chineseDate = self.convertToChineseDate()
        guard let hyphen = chineseDate.firstIndex(of: "-") else {
            return nil
        }

        let startIndex = chineseDate.index(after: hyphen)
        let endIndex = chineseDate.index(chineseDate.endIndex, offsetBy: -2)
        let branchExtracted = chineseDate[startIndex ... endIndex]

        return String(branchExtracted)
    }

    func chineseZodiacForBranch(_ branch: String) -> ChineseZodiac? {
        let branches: [String: ChineseZodiac] = [
            "zi": .rat,
            "chou": .ox,
            "yin": .tiger,
            "mao": .rabbit,
            "chen": .dragon,
            "si": .snake,
            "wu": .horse,
            "wei": .goat,
            "shen": .monkey,
            "you": .rooster,
            "xu": .dog,
            "hai": .pig
        ]
        return branches[branch]
    }
}
