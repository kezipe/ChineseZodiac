//: [Previous](@previous)
import Foundation

class Person {
    var zodiac: Int!
    init(_ z: Int) {
        self.zodiac = z
    }
}

let p = [Person(1), Person(2), Person(3), Person(4), Person(1), Person(2)]


var rat = [Person]()
var ox = [Person]()
var tiger = [Person]()
var rabbit = [Person]()


for i in 0..<p.endIndex {
    switch p[i].zodiac {
    case 1:
        rat.append(p[i])
    case 2:
        ox.append(p[i])
    case 3:
        tiger.append(p[i])
    case 4:
        rabbit.append(p[i])
    default:
        break
    }
}

var zodiac = [rat, ox, tiger, rabbit]
for (i, z) in zodiac.enumerated() {
    print(i, z)
}
//: [Next](@next)
