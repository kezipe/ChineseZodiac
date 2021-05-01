//
//  Zodiac+Compatibility.swift.swift
//  
//
//  Created by Kevin Peng on 2021-04-27.
//

import Foundation

extension ChineseZodiac {
    private static let matchTable = [
        [2,6,2,6,6,3,1,4,5,1,5,5],
        [6,2,1,5,1,6,1,1,2,6,5,4],
        [2,1,1,2,6,1,6,3,1,5,5,6],
        [6,5,2,2,2,1,2,6,6,1,6,6],
        [6,1,6,2,3,6,2,1,5,5,1,3],
        [3,6,1,1,6,1,3,1,3,6,2,1],
        [1,1,6,2,2,3,1,6,2,1,2,5],
        [4,1,3,6,1,1,6,5,5,2,1,6],
        [5,6,1,6,5,3,2,5,3,2,5,1],
        [1,6,5,1,5,6,1,2,2,1,1,2],
        [5,2,5,6,1,2,2,1,5,1,2,5],
        [5,4,6,6,3,1,5,6,1,2,5,3],
    ]

    public func compatibility(with other: ChineseZodiac) -> Compatibility {
        let lhsIndex = self.rawValue
        let rhsIndex = other.rawValue
        let compatibilityValue = Self.matchTable[lhsIndex][rhsIndex]
        return Compatibility(rawValue: compatibilityValue)!
    }
}
