//: [Previous](@previous)

import Foundation

let arr = [1, 2, 3, 4, 5, 6]

func pair(_ arr: [Int]) -> [[Int]] {
    var firstTwo = Array(arr[arr.startIndex...arr.startIndex + 1])
    var rest = Array(arr[arr.startIndex + 2..<arr.endIndex])
    var bigA = [[Int]]()
    
    
    if arr.count == 2 {
        return [arr]
    } else {
        for i in 0...rest.count {
            let list = pair(rest)
            for j in list {
                bigA.append(firstTwo + j)
            }
            guard i < rest.count else { continue }
            let tempFirst = firstTwo[firstTwo.endIndex - 1]
            firstTwo[firstTwo.endIndex - 1] = rest[i]
            rest[i] = tempFirst
        }
        return bigA
    }
    
}


print(pair(arr))

//: [Next](@next)
