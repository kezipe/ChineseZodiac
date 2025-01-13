//
//  Person+Extensions.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-22.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import Foundation

extension Person {
    var zodiacSign: Zodiac {
        guard 1...13 ~= self.zodiac else {
            fatalError("Non-existent zodiac sign")
        }
        return Zodiac(rank: Int(self.zodiac) - 1)!
    }

    var zodiacName: String {
        return self.zodiacSign.rawValue.capitalized
    }

    var isPlaceholder: Bool {
        return self.zodiacSign == .alone
    }
}
