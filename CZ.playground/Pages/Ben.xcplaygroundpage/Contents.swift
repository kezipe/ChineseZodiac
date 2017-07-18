//: [Previous](@previous)

import Foundation

let arr = [1, 2, 3, 4, 5, 6]

func swap(_ arr: [Int]) -> [Int] {
    var firstTwo = Array(arr[arr.startIndex...arr.startIndex + 1])
    var rest = Array(arr[arr.startIndex + 2..<arr.endIndex])
    
    
    
    if arr.count == 2 {
        return firstTwo + rest
    } else if arr.count == 4 {
        for i in 0..<rest.count {
            var tempFirst = firstTwo
            firstTwo[firstTwo.endIndex - 1] = rest[i]
            rest[i] = tempFirst[firstTwo.endIndex - 1]
        }
        return firstTwo + rest
    } else if arr.count > 5 {
            var tempFirst = firstTwo[firstTwo.endIndex - 1]
            firstTwo[firstTwo.endIndex - 1] = rest[0]
            rest[i] = tempFirst
        return firstTwo + swap(rest)
    } else {
        return []
    }
}

swap(arr)

//: [Next](@next)
