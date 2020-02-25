//: [Previous](@previous)

import Foundation

var normalCalendarDateComponents = DateComponents()
normalCalendarDateComponents.year = 2020
normalCalendarDateComponents.month = 5
normalCalendarDateComponents.day = 1

let calendar = Calendar(identifier: .gregorian)
let normalDate = calendar.date(from: normalCalendarDateComponents)!

let formatter = DateFormatter()
formatter.dateFormat = "MMM d, yyyy"
formatter.calendar = .init(identifier: .chinese)
formatter.dateStyle = .full
print(formatter.string(from: normalDate))

//: [Next](@next)
