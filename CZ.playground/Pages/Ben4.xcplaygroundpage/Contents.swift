//: [Previous](@previous)

import Foundation

let persons = [Person(name: "Alice", zodiac: 1),
               Person(name: "Bob", zodiac: 2),
               Person(name: "Charlie", zodiac: 3),
               Person(name: "Dave", zodiac: 4),
               Person(name: "Elon", zodiac: 5),
               Person(name: "Frank", zodiac: 6)]

let arr = [1,2,3,4,5,6]

func pair(_ arr: [Int]) -> [[Int]] {
    var bigA = [[Int]]()
    if arr.count == 2 {
        return [arr]
    }
    
    var firstTwo = Array(arr[arr.startIndex...arr.startIndex + 1])
    var rest = Array(arr[arr.startIndex + 2..<arr.endIndex])
    var list:[[Int]]
    for i in 0...rest.count {
        list = pair(rest)
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

let results = pair(arr)
var matchScores = [Int]()
for i in 0..<results.count {
    var tempScore = 0
    for j in stride(from: 0, to: results[0].count - 1, by: 2) {
        tempScore += Helper.match(person1: results[i][j], person2: results[i][j + 1])
    }
    matchScores.append(tempScore)
}
let bestResultIndex = matchScores.index(of: matchScores.max()!)!
let pairing = results[bestResultIndex]
var pairingPersons = [Person]()
for i in 0..<pairing.count {
    for person in persons {
        if person.zodiac == pairing[i] {
            pairingPersons.append(person)
        }
    }
}

var pairings = [[Person]]()
for i in stride(from: 0, to: pairingPersons.count - 1, by: 2) {
    pairings.append([pairingPersons[i], pairingPersons[i + 1]])
}
for p in pairings {
    print(p)
}
//: [Next](@next)
