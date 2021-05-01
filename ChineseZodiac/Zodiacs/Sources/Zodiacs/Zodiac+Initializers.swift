//
//  Zodiac+Initializers.swift.swift
//  
//
//  Created by Kevin Peng on 2021-04-26.
//

import Foundation

public extension ChineseZodiac {
    init?(date: Date) {
        if let branch = date.branch(),
           let zodiac = date.chineseZodiacForBranch(branch) {
            self = zodiac
            return
        }
        return nil
    }
}
