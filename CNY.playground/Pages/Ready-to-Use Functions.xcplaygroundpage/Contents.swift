//: Playground - noun: a place where people can play

import Foundation

func normalDate(fromYear year: Int, month: Int, day: Int) -> Date {
  var normalCalendarDateComponents = DateComponents()
  normalCalendarDateComponents.year = year
  normalCalendarDateComponents.month = month
  normalCalendarDateComponents.day = day
  
  let normalCalendar = Calendar(identifier: .gregorian)
  let normalDate = normalCalendar.date(from: normalCalendarDateComponents)!
  return normalDate
}

func zodiacFrom(date normalDate: Date) -> String {
  let chineseDateString = convertToChineseDate(from: normalDate)
  return zodiacFrom(chineseDate: chineseDateString)
}

func convertToChineseDate(from normalDate: Date) -> String {
  let chineseCalendar = Calendar(identifier: .chinese)
  let formatter = DateFormatter()
  formatter.calendar = chineseCalendar
  formatter.dateStyle = .full
  let chineseDate = formatter.string(from: normalDate)
  return chineseDate
}

func zodiacFrom(chineseDate: String) -> String {
  let branchExtracted = extractBranchFrom(chineseDate: chineseDate)
  if let zodiac = branchNameToZodiac(branchExtracted) {
    return zodiac
  }
  fatalError("Cannot convert \(chineseDate) to a zodiac sign")
}

func extractBranchFrom(chineseDate: String) -> String {
  guard let hyphen = chineseDate.firstIndex(of: "-") else {
    fatalError("\(chineseDate) is not correctly formatted, use DateFormatter.Style.full")
  }
  
  let startIndex = chineseDate.index(after: hyphen)
  let endIndex = chineseDate.index(chineseDate.endIndex, offsetBy: -2)
  let branchExtracted = chineseDate[startIndex ... endIndex]
  
  return String(branchExtracted)
}

func branchNameToZodiac(_ branch: String) -> String? {
  let dict = [
    "zi": "rat",
    "chou": "ox",
    "yin": "tiger",
    "mao": "rabbit",
    "chen": "dragon",
    "si": "snake",
    "wu": "horse",
    "wei": "goat",
    "shen": "monkey",
    "you": "rooster",
    "xu": "dog",
    "hai": "pig"
  ]
  return dict[branch]
}

let date = normalDate(fromYear: 1991, month: 6, day: 22)
let zodiac = zodiacFrom(date: date)
print(zodiac)

let anotherDate = normalDate(fromYear: 1991, month: 1, day: 20)
let anotherZodiac = zodiacFrom(date: anotherDate)
print(anotherZodiac)







