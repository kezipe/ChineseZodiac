//: [Previous](@previous)

import Foundation

let stems = Array("甲乙丙丁戊己庚辛壬癸")
let branches = Array("子丑寅卯辰巳午未申酉戌亥")

var sIndex = 0
var bIndex = 0

for i in 0...66 {
  let s = stems[sIndex]
  let b = branches[bIndex]
  print("\(s)\(b): \(i + 1)")
  sIndex += 1
  bIndex += 1
  if sIndex == stems.count {
    sIndex = 0
  }
  if bIndex == branches.count {
    bIndex = 0
  }
}

//: [Next](@next)
