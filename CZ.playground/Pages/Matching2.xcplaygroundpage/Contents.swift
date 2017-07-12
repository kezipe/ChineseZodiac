//: [Previous](@previous)
//: [Previous](@previous)

import Foundation

var match:[[Int]] =
    [[2,6,2,6,6,3,1,4,5,1,5,5],
     [6,2,1,5,1,6,1,1,2,6,5,4],
     [2,1,1,2,6,1,6,3,1,5,5,6],
     [6,5,2,2,2,1,2,6,6,1,6,6],
     [6,1,6,2,3,6,2,1,5,5,1,3],
     [3,6,1,1,6,1,3,1,3,6,2,1],
     [1,1,6,2,2,3,1,6,2,1,2,5],
     [4,1,3,6,1,1,6,5,5,2,1,6],
     [5,6,1,6,5,3,2,5,3,2,5,1],
     [1,6,5,1,5,6,1,2,2,1,1,2],
     [5,2,5,6,1,2,2,1,5,1,2,5],
     [5,4,6,6,3,1,5,6,1,2,5,3]]

func getZodiac(fromIndex: Int) -> String {
    let zodiac = [1:"Rat", 2:"Ox", 3:"Tiger", 4:"Rabbit", 5:"Dragon", 6:"Snake", 7:"Horse", 8:"Goat", 9:"Monkey", 10:"Rooster", 11:"Dog", 12:"Pig"]
    return zodiac[fromIndex]!
}

class Person {
    var name: String
    var zodiac: Int
    
    init(name: String, zodiac: Int) {
        self.name = name
        self.zodiac = zodiac
    }
}


func matchP(p: [Person]) {
    var personPreference = [[Int]]()
    var tempPreference = [Int]()
    for i in 0..<p.count - 1 {
        for j in 1..<p.count{
            guard i + j < p.endIndex else {
                continue
            }
            tempPreference.append(match[p[i].zodiac - 1][p[i + j].zodiac - 1])
        }
        personPreference.append(tempPreference)
        tempPreference = [Int]()
    }
    for i in personPreference {
        print(i)
    }
}

let persons = [Person(name: "Alice", zodiac: 1),
               Person(name: "Bob", zodiac: 2),
               Person(name: "Charlie", zodiac: 3),
               Person(name: "David", zodiac: 4),
               Person(name: "Elon", zodiac: 5)]

matchP(p: persons)
match[1][2]


//: [Next](@next)

//: [Next](@next)
