//: [Previous](@previous)
import Foundation

class Person {
    var zodiac: Int!
    init(_ z: Int) {
        self.zodiac = z
    }
}

let p = [Person(1), Person(2), Person(3), Person(4), Person(5), Person(6)]

for i in 0..<(p.count - 1) {
    for j in (i + 1)..<p.count {
        print(p[i].zodiac, p[j].zodiac)
    }
}
//: [Next](@next)
