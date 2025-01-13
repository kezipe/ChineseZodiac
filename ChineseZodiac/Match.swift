//
//  Match.swift
//  ChineseZodiac
//
//  Created by Kevin Peng on 2020-02-26.
//  Copyright © 2020 Monorail Apps. All rights reserved.
//

import Foundation

enum Compatibility: Int, Comparable, CustomStringConvertible {
    case alone
    case poor
    case average
    case goodMatchOrEnemy
    case goodFriend
    case complementary
    case perfect

    var description: String {
        switch self {
        case .alone:
            return "Alone"
        case .poor:
            return "Poor"
        case .average:
            return "Average"
        case .goodMatchOrEnemy:
            return "Good Match or Enemy"
        case .goodFriend:
            return "Good Friend"
        case .complementary:
            return "Complementary"
        case .perfect:
            return "Perfect Match"
        }
    }

    static func < (lhs: Compatibility, rhs: Compatibility) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

struct Match: Comparable {
    var firstPerson: Person
    var secondPerson: Person
    var compatibility: Compatibility

    var isAlone: Bool {
        firstPerson.isPlaceholder || secondPerson.isPlaceholder
    }

    var loner: Person? {
        guard isAlone else {
            return nil
        }

        if firstPerson.isPlaceholder {
            return secondPerson
        } else {
            return firstPerson
        }
    }

    static func < (lhs: Match, rhs: Match) -> Bool {
        return lhs.compatibility > rhs.compatibility
    }
}
