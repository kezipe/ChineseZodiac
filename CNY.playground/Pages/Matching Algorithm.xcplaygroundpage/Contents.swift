//: [Previous](@previous)

import Foundation

func factorial(_ factorialNumber: UInt64) -> UInt64 {
  if factorialNumber == 0 {
    return 1
  } else {
    return factorialNumber * factorial(factorialNumber - 1)
  }
}


func ways(_ n: Int) -> UInt64 {
  return factorial(UInt64(n))/factorial(UInt64(n/2))/UInt64(pow(2, Double(n/2)))
}

print(ways(6))

//: [Next](@next)
