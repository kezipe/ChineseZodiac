//: [Previous](@previous)

import Foundation

let arr = [1, 2, 3, 4]

func pair(_ arr: [Int]) -> [Int] {
    var firstTwo = Array(arr[arr.startIndex...arr.startIndex + 1])
    var rest = Array(arr[arr.startIndex + 2..<arr.endIndex])
    
    print(firstTwo, rest)
    for i in 0..<arr.count / 2  {
        var tempFirst = firstTwo
        firstTwo[firstTwo.endIndex - 1] = rest[i]
        rest[i] = tempFirst[firstTwo.endIndex - 1]
        print(firstTwo, rest)
    }
}

pair(arr)
//: [Next](@next)
