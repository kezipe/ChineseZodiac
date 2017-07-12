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

func getZodiac(i: Int) -> String {
    let zodiac = [1:"Rat", 2:"Ox", 3:"Tiger", 4:"Rabbit", 5:"Dragon", 6:"Snake", 7:"Horse", 8:"Goat", 9:"Monkey", 10:"Rooster", 11:"Dog", 12:"Pig"]
    return zodiac[i]!
}

class Person {
    var name: String
    var zodiac: Int
    
    init(name: String, zodiac: Int) {
        self.name = name
        self.zodiac = zodiac
    }
}


func matchP(per: [Person]) {
    var pers = per
    var perso = per
    var score = 0
    var scores = [Int]()
    print("p started with \(pers.count) units long")
    for h in 0..<perso.endIndex/2 {
        pers = perso
        for i in 0..<pers.endIndex/2 {
            var p = pers
            for _ in 0..<p.endIndex/2 {
                guard p.count > 1 else { break }
                score += match[p.first!.zodiac-1][p.last!.zodiac-1]
                
                print("\(getZodiac(i: p.first!.zodiac)) and \(getZodiac(i: p.last!.zodiac)) gives \(match[p.first!.zodiac-1][p.last!.zodiac-1])")
                p.remove(at: p.startIndex)
                p.remove(at: p.endIndex - 1)
            }
            print("\(i+1)th iteration has \(score)")
            pers.append(pers.first!)
            pers.remove(at: pers.startIndex)
            scores.append(score)
            score = 0
        }
        perso.remove(at: perso.startIndex)
    }
    
    for i in scores {
        print(i)
    }
}

let persons = [Person(name: "Alice", zodiac: 1),
               Person(name: "Bob", zodiac: 2),
               Person(name: "Charlie", zodiac: 3),
               Person(name: "David", zodiac: 4)]

matchP(per: persons)

func factorial(factorialNumber: Double) -> Double {
    if factorialNumber == 0 {
        return 1
    } else {
        return factorialNumber * factorial(factorialNumber: factorialNumber - 1)
    }
}

func howMany(i: Int) -> Double {
    let i = Double(i)
    let bottomLeft = factorial(factorialNumber: i/2.0)
    let bottomRight = pow(2.0, i/2.0)
    return factorial(factorialNumber: i) / bottomLeft / bottomRight
}

howMany(i: 6)


//: [Next](@next)
