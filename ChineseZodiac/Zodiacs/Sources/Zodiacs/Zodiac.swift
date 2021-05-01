//
//  File.swift
//  
//
//  Created by Kevin Peng on 2021-04-27.
//

import Foundation

public protocol Zodiac {
    init?(date: Date)
    func compatibility(with: Self) -> Compatibility
}
