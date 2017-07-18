//: [Previous](@previous)

import Foundation

let arr = [1, 2, 3, 4]



var prevArr = arr
var nowArr = arr
for i in stride(from: nowArr.count - 2, to: 0, by: -1) {
    print(nowArr)
    nowArr[nowArr.endIndex - i] = prevArr[prevArr.endIndex - (nowArr.count - 1)]
    nowArr[nowArr.endIndex - (nowArr.count - 1)] = prevArr[prevArr.endIndex - i]
    prevArr = nowArr
}


print(nowArr)


//: [Next](@next)
