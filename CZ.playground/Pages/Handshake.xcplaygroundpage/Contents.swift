//: [Previous](@previous)

import Foundation

func determineHandshake(memberCount: Int) -> Int {
    if memberCount == 1 {
        return 0
    } else if memberCount == 2 {
        return 1
    } else {
        return determineHandshake(memberCount: memberCount - 1) + memberCount - 1
    }
}


print(determineHandshake(memberCount: 3))




//: [Next](@next)
