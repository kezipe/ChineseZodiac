//
//  Compatibility.swift
//  
//
//  Created by Kevin Peng on 2021-04-27.
//

import Foundation

public enum Compatibility: Int, Comparable, CustomStringConvertible {
    case alone
    case poor
    case average
    case goodMatchOrEnemy
    case goodFriend
    case complementary
    case perfect

    public var description: String {
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

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
