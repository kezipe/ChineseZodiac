//
//  Zodiac.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import Foundation

enum Zodiac: String, CaseIterable {
    case rat
    case ox
    case tiger
    case rabbit
    case dragon
    case snake
    case horse
    case goat
    case monkey
    case rooster
    case dog
    case pig
    case alone = ""

    var rank: Int {
        Self.allCases.firstIndex { self == $0 }!
    }

    init?(rank: Int) {
        let zodiac = Self.allCases.first { $0.rank == rank }
        if let zodiac = zodiac {
            self = zodiac
        } else {
            return nil
        }
    }

    private static let matchTable = [
        [2, 6, 2, 6, 6, 3, 1, 4, 5, 1, 5, 5, 0],
        [6, 2, 1, 5, 1, 6, 1, 1, 2, 6, 5, 4, 0],
        [2, 1, 1, 2, 6, 1, 6, 3, 1, 5, 5, 6, 0],
        [6, 5, 2, 2, 2, 1, 2, 6, 6, 1, 6, 6, 0],
        [6, 1, 6, 2, 3, 6, 2, 1, 5, 5, 1, 3, 0],
        [3, 6, 1, 1, 6, 1, 3, 1, 3, 6, 2, 1, 0],
        [1, 1, 6, 2, 2, 3, 1, 6, 2, 1, 2, 5, 0],
        [4, 1, 3, 6, 1, 1, 6, 5, 5, 2, 1, 6, 0],
        [5, 6, 1, 6, 5, 3, 2, 5, 3, 2, 5, 1, 0],
        [1, 6, 5, 1, 5, 6, 1, 2, 2, 1, 1, 2, 0],
        [5, 2, 5, 6, 1, 2, 2, 1, 5, 1, 2, 5, 0],
        [5, 4, 6, 6, 3, 1, 5, 6, 1, 2, 5, 3, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ]

    static func match(_ lhs: Zodiac, with rhs: Zodiac) -> Int {
        Self.matchTable[lhs.rank][rhs.rank]
    }

}
